-- 8. 결제 전환 소요 시간(평균 & 중앙값) 분석
-- 구매(purchase)까지 도달한 세션의 첫 view_item부터 purchase까지 걸린 시간(분)의 평균과
-- 중앙값(Median)을 디바이스별로 구하기

with session_test as (
select
	session_id,
    device_type
from user_events
where event_name = 'purchase'
),

dev_session as (
select
	s.session_id,
    ue.event_timestamp,
    ue.event_name,
    ue.device_type
from session_test s
left join user_events ue
	on  s.session_id =ue.session_id
),

time_stamp as (
select
	session_id,
    device_type,
    timestampdiff(second, min(event_timestamp),max(event_timestamp))/60 as purchase_minute
    -- max(event_timestamp)
from dev_session
group by session_id, device_type
),
ranked as (
    SELECT
        device_type,
        purchase_minute,
        ROW_NUMBER() OVER (PARTITION BY device_type ORDER BY purchase_minute) AS rn,
        COUNT(*) OVER (PARTITION BY device_type) AS cnt
    FROM time_stamp
)

select
	device_type,
    MAX(cnt) AS converted_sessions,
	round(avg(purchase_minute), 2) as avg_minutes_to_buy,
	round(avg(CASE WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2)) THEN purchase_minute END), 2) AS median_minutes_to_buy
from ranked
group by device_type;

-- LLM CODE ---------------

WITH session_durations AS (
    SELECT
        device_type,
        TIMESTAMPDIFF(
            SECOND,
            MIN(CASE WHEN event_name = 'view_item' THEN event_timestamp END),
            MAX(CASE WHEN event_name = 'purchase' THEN event_timestamp END)
        ) / 60.0 AS minutes_to_buy
    FROM user_events
    WHERE event_name IN ('view_item', 'purchase')
    GROUP BY session_id, device_type
    HAVING MAX(CASE WHEN event_name = 'purchase' THEN 1 END) = 1
       AND MIN(CASE WHEN event_name = 'view_item' THEN event_timestamp END) IS NOT NULL
),
ranked AS (
    SELECT
        device_type,
        minutes_to_buy,
        ROW_NUMBER() OVER (PARTITION BY device_type ORDER BY minutes_to_buy) AS rn,
        COUNT(*) OVER (PARTITION BY device_type) AS cnt
    FROM session_durations
)
SELECT
    device_type,
    MAX(cnt) AS converted_sessions,
    ROUND(AVG(minutes_to_buy), 2) AS avg_minutes_to_buy,
    ROUND(AVG(CASE WHEN rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2)) THEN minutes_to_buy END), 2) AS median_minutes_to_buy
FROM ranked
GROUP BY device_type;