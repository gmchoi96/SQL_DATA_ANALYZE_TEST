-- 5. 주문 금액이 높은 순서로 주문 10건을 조회한다.
select * from orders
order by total_amount desc limit 10;