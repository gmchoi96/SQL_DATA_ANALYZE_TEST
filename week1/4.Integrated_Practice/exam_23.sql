-- 23. 사용자별 배송 완료 주문 금액 합계가 200,000원 이상인 사용자 조회하기
select user_id, order_status, sum(total_amount) as delivered_amount from orders
where order_status = "delivered" 
group by user_id
having delivered_amount >= 200000
order by delivered_amount desc;