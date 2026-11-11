-- 13. 배송 완료 주문 금액이 100,000원 이상인 주문만 조회하라
select * from orders
where order_status="DELIVERED" and total_amount > 100000
order by total_amount desc;