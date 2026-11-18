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
order by diff_date