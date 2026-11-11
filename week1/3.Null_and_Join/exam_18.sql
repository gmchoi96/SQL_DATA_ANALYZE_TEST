-- 18.주문이 한 번도 없는 사용자를 모두 조회하라
select u.user_id, u.signup_date
from users as u
left join orders as o
	on u.user_id = o.user_id
where o.order_id is null;