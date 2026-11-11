-- SELECT COUNT(TOTAL_AMOUNT) FROM ORDERS;
SELECT ORDER_STATUS FROM ORDERS;
-- 8. 전체 사용자 수
select count(*) as user_count from users;
-- 9. 전체 주문 건수와 주문 금액 합계
select count(*) as total_order, format(sum(total_amount), 0) from orders;
-- 10. 주문 1건당 평균 주문 금액을 구하라
SELECT AVG(TOTAL_AMOUNT) AS AVG_ORDER_AMOUNT FROM ORDERS;
-- 11. 주문 상태별 주문 건수를 구하라
SELECT ORDER_STATUS, COUNT(*) AS ORDER_COUNT FROM ORDERS
GROUP BY ORDER_STATUS
ORDER BY ORDER_COUNT DESC;
-- 12. 카테고리별 평균 상품 가격을 구하라
select category,avg(unit_price) as category_avg_price from products
group by category
order by category_avg_price desc;	
-- 13. 배송 완료 주문 금액이 100,000원 이상인 주문만 조회하라
select * from orders
where order_status="DELIVERED" and total_amount > 100000
order by total_amount desc;
-- 14. 사용자별 주문 횟수를 구하라
select user_id, count(*) as user_order from orders
group by user_id;
-- 15. 주문이 5건 이상인 사용자를 구하라
select user_id, count(order_id) as user_order from orders
group by user_id
having count(order_id) >= 5
order by user_id;
-- ///// having과 where의 조건문 차이, having일경우 group by가 더 앞에 옴

-- 16. 주문 금액을 30,000원 미만, 30,000~99,999원, 100,000원 이상으로 분류하라(case when)
select order_id, total_amount,
case
	when total_amount < 30000 then "low"
    when total_amount < 100000 then 'medium'
    else 'high'
    end as amount_group
from orders;