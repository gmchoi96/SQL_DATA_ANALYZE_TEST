-- 15. 주문이 5건 이상인 사용자를 구하라
select user_id, count(order_id) as user_order from orders
group by user_id
having count(order_id) >= 5
order by user_id;