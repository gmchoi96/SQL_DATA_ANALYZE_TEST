-- 19.사용자별 전체 주문 건수와 주문 금액 합계를 구하라
select u.user_id, count(o.order_id) as order_count, COALESCE(SUM(o.total_amount), 0) AS total_order_amount from orders as o
left join users as u
	on u.user_id = o.user_id
group by u.user_id
order by u.user_id desc;