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