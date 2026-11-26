-- 10. 주문 취소율(CANCELLED) 및 취소 금액 분석
-- acquisition_channel과 device_type 기준으로
-- 전체 주문 수, CANCELLED 주문 수, 취소율(%), 취소 금액 합계를 구하기

select
    u.acquisition_channel,
    o.device_type,
    count(u.acquisition_channel) as whole_order,
    count(case when o.order_status='cancelled' then u.acquisition_channel end)
    as cancelled_order,
    round(count(case when o.order_status='cancelled' then u.acquisition_channel end)
    /
    count(u.acquisition_channel)* 100, 2) as cancelled_pct,
    COALESCE(sum(case when o.order_status='cancelled' then o.total_amount end),0) as cancelled_amount
from orders o
left join users u
	on o.user_id = u.user_id 
group by u.acquisition_channel, o.device_type
order by u.acquisition_channel;

-- --------------------------------------

SELECT
    u.acquisition_channel,
    o.device_type,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN o.order_status = 'CANCELLED' THEN 1 END) AS cancelled_orders,
    ROUND(
        100.0 * COUNT(CASE WHEN o.order_status = 'CANCELLED' THEN 1 END)
        / NULLIF(COUNT(o.order_id), 0),
        2
    ) AS cancel_rate_pct,
    COALESCE(SUM(CASE WHEN o.order_status = 'CANCELLED' THEN o.total_amount END), 0) AS cancelled_amount
FROM orders o
JOIN users u
    ON o.user_id = u.user_id
GROUP BY u.acquisition_channel, o.device_type
-- ORDER BY cancel_rate_pct DESC, cancelled_amount DESC;
ORDER BY cancel_rate_pct DESC, cancelled_amount DESC;