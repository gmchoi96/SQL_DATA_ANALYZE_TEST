-- 5.평균보다 많이 구매한 사용자 찾기 / 전체 사용자의 평균 구매 횟수보다 많이 구매한 사용자
with user_purchase as (
	select u.user_id, count(o.order_id) as count_order
	from users as u
	left join orders as o
		on u.user_id = o.user_id
		AND o.order_status = 'DELIVERED'
	group by u.user_id
    )

select
	user_id,
    count_order
from user_purchase
where count_order > (
	SELECT AVG(count_order)
	FROM user_purchase
	)
order by count_order desc;
