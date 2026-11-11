select * from orders;
-- 22. 월별 배송 완료 주문 건수와 주문 금액 합계를 구하라
select month(order_date) as month_date, count(order_status) as count_delivered, sum(total_amount) as delivered_amount
from orders
where order_status = "delivered"
group by month_date
order by month_date;
-- 23. 사용자별 배송 완료 주문 금액 합계가 200,000원 이상인 사용자를 조회하라.
select user_id, order_status, sum(total_amount) as delivered_amount from orders
where order_status = "delivered" 
group by user_id
having delivered_amount >= 200000
order by delivered_amount desc;
-- 24. 주문 금액 평균보다 주문 금액이 높은 주문을 조회하라
SELECT order_id, total_amount from orders
where total_amount > 
	(select avg(total_amount) from orders);
    -- 서브쿼리임
-- 25. 유입 채널별 사용자 수, 주문한 사용자 수, 배송 완료 주문 금액 합계를 구하기
select coalesce(u.acquisition_channel, 'unknown')  AS channel,
count(distinct u.user_id) as count_user_id,
count(distinct IF(
	o.order_status in ('delivered', 'shipped', 'cancelled'),
    o.user_id,
    null
    )) as ordered_user_count,
    SUM(IF(
		o.order_status = 'delivered',
        o.total_amount,
        0
	)) as delivered_revenue
from users as u 
left join orders as o
	on o.user_id = u.user_id
group by channel
order by delivered_revenue DESC;


SELECT
  COALESCE(u.acquisition_channel, 'UNKNOWN') AS channel,
  COUNT(DISTINCT u.user_id) AS user_count,
  COUNT(DISTINCT IF(
    o.order_status IN ('DELIVERED', 'SHIPPED', 'CANCELLED'),
    o.user_id,
    NULL
  )) AS ordered_user_count,
  SUM(IF(
    o.order_status = 'DELIVERED',
    o.total_amount,
    0
  )) AS delivered_revenue
FROM users AS u
LEFT JOIN orders AS o
  ON u.user_id = o.user_id
GROUP BY channel
ORDER BY delivered_revenue DESC;