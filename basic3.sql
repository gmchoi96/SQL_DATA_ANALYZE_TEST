-- 17.유입 채널별 사용자 수를 구하고, 채널이 없는 사용자는 UNKNOWN으로 표시하라.
select
 	coalesce(NULLIF(acquisition_channel, ''), "unknown1") as channel,
	count(*) as count_user
from users
group by channel
ORDER BY count_user DESC;
-- 18.주문이 한 번도 없는 사용자를 모두 조회하라
select u.user_id, u.signup_date
from users as u
left join orders as o
	on u.user_id = o.user_id
where o.order_id is null;
-- 19.사용자별 전체 주문 건수와 주문 금액 합계를 구하라'
select u.user_id, count(o.order_id) as order_count, COALESCE(SUM(o.total_amount), 0) AS total_order_amount from orders as o
left join users as u
	on u.user_id = o.user_id
group by u.user_id
order by u.user_id desc;
-- 20.상품별 주문 수량 합계를 구하라
select p.product_id, p.product_name, sum(oi.quantity) as count_quantity
from order_items as oi
left join products as p
	on p.product_id = oi.product_id
group by p.product_id, p.product_name;

-- 21.카테고리별 배송 완료 주문 금액을 구하라
select p.category, sum(oi.quantity * oi.unit_price) as total_price
from order_items as oi
left join products as p
	on p.product_id = oi.product_id
left join orders as o
	on o.order_id = oi.order_id
where o.order_status = "delivered"
group by p.category
ORDER BY total_price DESC;
-- 21번 문제 동일 결과 확인
SELECT
  p.category,
  SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items AS oi
JOIN products AS p
  ON oi.product_id = p.product_id
JOIN orders AS o
  ON oi.order_id = o.order_id
WHERE o.order_status = 'DELIVERED'
GROUP BY p.category
ORDER BY revenue DESC;