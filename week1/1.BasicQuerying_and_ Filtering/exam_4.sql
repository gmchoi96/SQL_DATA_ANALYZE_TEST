-- 4. 2025년 6월에 발생한 주문을 조회하라
select order_id, order_date from orders
where order_date>= date '2025-06-01'
and order_date< date '2025-07-01';