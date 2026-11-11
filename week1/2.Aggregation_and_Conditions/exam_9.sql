-- 9. 전체 주문 건수와 주문 금액 합계
select count(*) as total_order, format(sum(total_amount), 0) from orders;