-- 5.평균보다 많이 구매한 사용자 찾기 / 전체 사용자의 평균 구매 횟수보다 많이 구매한 사용자
with user_purchase as (
	select u.user_id, count(o.order_id) as count_order
	from users as u
	left join orders as o
		on u.user_id = o.user_id
		AND o.order_status = 'DELIVERED'
	group by u.user_id
    )

select
	user_id,
    count_order
from user_purchase
where count_order > (
	SELECT AVG(count_order)
	FROM user_purchase
	)
order by count_order desc;

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


-- 7. 월별 신규 구매자 수 구하기 / 매월 새롭게 구매를 시작한 고객이 얼마나 되는지
WITH first_purchase AS (
    SELECT
        user_id,
        MIN(order_date) AS first_order_date
    FROM orders
    WHERE order_status = 'DELIVERED'
    GROUP BY user_id
)

SELECT
    DATE_FORMAT(first_order_date, '%y-%m-01') AS purchase_month,
    COUNT(user_id) AS new_buyers
FROM first_purchase
WHERE first_order_date >= '2025-01-01'
  AND first_order_date < '2026-01-01'
GROUP BY purchase_month
ORDER BY purchase_month;
-- 8. 상품별 매출이 전체 매출에서 차지하는 비율 / 각 상품이 전체 매출에 얼마나 기여하는지
select
	p.product_name,
    p.category,
	sum(oi.quantity * oi.unit_price) as amount_product
from products as p
left join order_items as oi
	on p.product_id = oi.product_id
group by oi.order_id    
