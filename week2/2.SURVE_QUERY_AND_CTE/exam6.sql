-- 6. 사용자별 첫 구매 날짜 구하기 / 사용자들이 처음 구매한 날짜
WITH FIRST_DAY AS (
	select user_id, min(order_date) as first_day_of_month
	from orders
    WHERE order_status = 'DELIVERED'
	group by user_id
)

select user_id, first_day_of_month
from FIRST_DAY
order by first_day_of_month;