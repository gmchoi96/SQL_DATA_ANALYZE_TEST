-- 15. 유입 채널별 고객 매출 분석 / 어떤 유입 채널의 고객이 더 높은 구매 성과를 보이는지 분석

with revenue as (
select
	u.user_id,
    u.acquisition_channel,
    sum(o.total_amount) as revenue_amount
from users as u
left join orders as o
	on u.user_id = o.user_id
    where order_status = 'delivered'
group by acquisition_channel, user_id
order by u.user_id
)

select
	acquisition_channel,
    count(distinct user_id) as count_user,
    sum(revenue_amount) as total_revenue,
    avg(revenue_amount) as avg_revenue
from revenue
group by acquisition_channel
order by total_revenue desc;

