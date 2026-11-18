-- 14. 첫 구매 후 재구매까지 걸린 기간 분석 / 첫 구매 이후 고객들이 얼마나 빨리 다시 구매하는지 분석

with cal_date as (
SELECT
    user_id,
    order_id,
    order_date,
    row_number() over(partition by user_id order by order_date) as rn
FROM orders
WHERE order_status = 'DELIVERED'
ORDER BY user_id, order_date
),

purchase_date as (
select
	user_id,
    max(
		case
		when rn =1 then order_date
		end
        ) as first_purchase_date,
	max(
		case
		when rn =2 then order_date
		end
        ) as second_purchase_date
from cal_date
where rn <= 2
group by user_id
)

select
user_id,
first_purchase_date,
second_purchase_date,
datediff(second_purchase_date, first_purchase_date) as diff_date
from purchase_date
order by diff_date;

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

