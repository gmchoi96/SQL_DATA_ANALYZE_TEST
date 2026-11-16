-- 4. 사용자별 구매 횟수와 총 구매 금액 / 충성 고객을 찾기 위해 사용자별 구매 현황을 요청했어.
select
	u.user_id,
    count(o.order_id) as count_order,
    sum(o.total_amount) as user_order_amount
from orders as o
left join users as u
	on u.user_id = o.user_id
group by u.user_id
order by user_order_amount desc;

-- 구매이력 없는 고객 찾지못함
select
	u.user_id,
    count(o.order_id) as count_order,
    coalesce(sum(o.total_amount),0) as user_order_amount
from orders as o
left join users as u
	on u.user_id = o.user_id
    and o.order_status = 'delivered'
group by u.user_id
order by user_order_amount desc;