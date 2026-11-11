-- 14. 사용자별 주문 횟수를 구하라
select user_id, count(*) as user_order from orders
group by user_id;