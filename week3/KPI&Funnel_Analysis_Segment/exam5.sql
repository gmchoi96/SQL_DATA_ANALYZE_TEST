-- 5. 디바이스(device_type) 별 세션 퍼널 비교
-- 세션(session_id) 단위로 device_type별
-- view_item > add_to_cart > begin_checkout > purchase
-- 세션 수와 각 단계 전환율 구하기

with session_funnel as (
	select
		session_id,
		device_type,
		max(case when event_name = 'view_item' then 1 else 0 end) as s1,
		max(case when event_name = 'add_to_cart' then 1 else 0 end) as s2,
		max(case when event_name = 'begin_checkout' then 1 else 0 end) as s3,
		max(case when event_name = 'purchase' then 1 else 0 end) as s4
	from user_events
	group by session_id, device_type
)

select
    device_type, sum(s1) as view_count, sum(s2) as a_t_c_count,
    round(sum(s2)/sum(s1)*100, 2) as view_to_cart_pct,
    sum(s3) as checkout_count,
    round(sum(s3)/sum(s2)*100, 2) as cart_to_checkout_pct,
    sum(s4) as purchase_count,
    round(sum(s4)/sum(s3)*100, 2) as checkout_to_pur_pct,
    round(sum(s4)/sum(s1)*100, 2) as overall_cvr_pct
from session_funnel
group by device_type
order by overall_cvr_pct desc;


