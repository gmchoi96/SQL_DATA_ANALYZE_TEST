-- 1. 구매 이력이 있는 사용자 주문 내역 조회
select u.user_id, u.signup_date, o.order_id, o.order_date
from users as u
left join orders as o
	on u.user_id = o.user_id
where order_status = "delivered"
order by o.order_date;