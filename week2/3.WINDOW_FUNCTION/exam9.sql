-- 9. 사용자별 첫 구매 주문 찾기 / 고객별 첫 구매 주문 정보를 확인
with ranked_orders as (
    SELECT
        user_id,
        order_id,
        order_date,
        total_amount,
        row_number() over (partition by user_id order by order_date, order_id) as rn
    FROM orders
	WHERE order_status = 'DELIVERED'
)

select
	user_id,
	order_id,
	order_date,
    total_amount
from ranked_orders
where rn = 1