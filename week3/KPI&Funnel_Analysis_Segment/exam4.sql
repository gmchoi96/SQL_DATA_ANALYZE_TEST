-- 4. 유입 채널별 가입 > 첫 완료 주문 전환율
-- acquisition_channel 별 전체 가입자 수, 완료 주문(completed) 경험자 수,
-- 가입 대비 구매 전환율(%) 구하기


with statistics as (
select
	u.acquisition_channel,
	count(distinct u.user_id) as inflow_user,
    count(distinct case when o.order_status = 'COMPLETED' then u.user_id end) as completed_user
from users u
left join orders o
		on u.user_id = o.user_id
group by acquisition_channel
)


select
	acquisition_channel,
    inflow_user,
    completed_user,
    round(completed_user/nullif(inflow_user, 0)*100, 2) as pur_per_inflow
from statistics
order by pur_per_inflow desc;

WITH channel_users AS (
    SELECT
        u.acquisition_channel,
        u.user_id,
        MAX(CASE WHEN o.order_status = 'COMPLETED' THEN 1 ELSE 0 END) AS is_buyer
    FROM users u
    LEFT JOIN orders o
        ON u.user_id = o.user_id
    GROUP BY u.acquisition_channel, u.user_id
)
SELECT
    acquisition_channel,
    COUNT(user_id) AS total_signups,
    SUM(is_buyer) AS converted_buyers,
    ROUND(100.0 * SUM(is_buyer) / NULLIF(COUNT(user_id), 0), 2) AS signup_to_buyer_cvr
FROM channel_users
GROUP BY acquisition_channel
ORDER BY signup_to_buyer_cvr DESC;
