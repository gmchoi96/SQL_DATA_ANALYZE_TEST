-- 9. 특정 기간 전환율 급락(이상 징후) 추적
-- 2026년 10월 동안 주 시작일( DATE_SUB(event_date, INTERVAL WEEKDAY(event_date) DAY)) 및
-- device_type별로 begin_checkout 대비 purchase 완료율을 구하고,
-- 이상 구간과 원인 가설 3가지를 작성하세요.


select
	DATE_SUB(event_date, INTERVAL WEEKDAY(event_date) DAY) as week_start,
    device_type,
    count(case when event_name = 'begin_checkout' then 1 end) as checkout,
    count(case when event_name = 'purchase' then 1 end) as purchase_completed,
    round(100*count(case when event_name = 'purchase' then 1 end)
    /
    nullif(count(case when event_name = 'begin_checkout' then 1 end),0), 2) as pct
from user_events
where month(event_date) = 10
group by device_type, week_start
order by week_start;

-- --------------------

WITH oct_chk AS (
    SELECT
        DATE_SUB(event_date, INTERVAL WEEKDAY(event_date) DAY) AS week_start,
        device_type,
        session_id,
        MAX(CASE WHEN event_name = 'begin_checkout' THEN 1 ELSE 0 END) AS chk,
        MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS pur
    FROM user_events
    WHERE event_date BETWEEN '2026-10-01' AND '2026-10-31'
      AND event_name IN ('begin_checkout', 'purchase')
    GROUP BY
        DATE_SUB(event_date, INTERVAL WEEKDAY(event_date) DAY),
        device_type,
        session_id
)
SELECT
    week_start,
    device_type,
    SUM(chk) AS checkout_sessions,
    SUM(pur) AS purchase_sessions,
    ROUND(100.0 * SUM(pur) / NULLIF(SUM(chk), 0), 2) AS checkout_to_purchase_pct
FROM oct_chk
GROUP BY week_start, device_type
ORDER BY week_start, device_type;
