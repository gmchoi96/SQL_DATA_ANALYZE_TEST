-- 2. 단계별 사용자 풀 퍼널& 이탈 구간 파악
-- signup → view_item → add_to_cart → begin_checkout → purchase 단계별 고유 사용자 수(UV),
-- 가입 전환율(%), 직전 단계 대비 전환율(%)
-- event name 에서 view_item, add_to_cart, begin_checkout, purchase 구분
with sum_event as(
	select
		count(distinct u.user_id) as s1,
		count(distinct case when UE.event_name = 'view_item' then u.user_id end) as s2,
		count(distinct case when UE.event_name = 'add_to_cart' then u.user_id end) as s3,
		count(distinct case when UE.event_name = 'begin_checkout' then u.user_id end) as s4,
		count(distinct case when UE.event_name = 'purchase' then u.user_id end) as s5
	from users as u
	left join user_events as ue
		on u.user_id = ue.user_id
)

select
	'1 singup' as step,
    s1 as users,
    100.00 as pct_from_start,
    100.0 as step_cvr
from sum_event
union all
select
	'2 view_item' as step,
    s2 as view_item,
    round(s2/nullif(s1, 0)*100,2) as pct_from_start,
    round(s2/nullif(s1, 0)*100,2) as step_cvr
from sum_event
union all
select
	'3 add2cart' as step,
    s3 as view_item,
    round(s3/nullif(s1, 0)*100,2) as pct_from_start,
    round(s3/nullif(s2, 0)*100,2) as step_cvr
from sum_event
union all
select
	'4 begin_checkout' as step,
    s4 as view_item,
    round(s4/nullif(s1, 0)*100,2) as pct_from_start,
    round(s4/nullif(s3, 0)*100,2) as step_cvr
from sum_event
union all
select
	'5 purchase' as step,
    s5 as view_item,
    round(s5/nullif(s1, 0)*100,2) as pct_from_start,
    round(s5/nullif(s4, 0)*100,2) as step_cvr
from sum_event;

-- ---------------------------
with user_event as(
	select
		distinct u.user_id,
		count(distinct u.user_id) as singup_users,
		max(case when UE.event_name = 'view_item' then 1 else 0 end) as just_view,
		max(case when UE.event_name = 'add_to_cart' then 1 else 0 end) as add2cart,
		max(case when UE.event_name = 'begin_checkout' then 1 else 0 end) as begin_checkout,
		max(case when UE.event_name = 'purchase' then 1 else 0 end) as purchase
	from users as u
	left join user_events as ue
		on u.user_id = ue.user_id
	group by u.user_id
),
sum_event as (
	select 
		sum(singup_users) as s1,
		sum(just_view) as s2,
		sum(add2cart) as s3,
		sum(begin_checkout) as s4,
		sum(purchase) as s5
	from user_event
)

select
	'1 singup' as step,
    s1 as users,
    100.00 as pct_from_start,
    100.0 as step_cvr
from sum_event
union all
select
	'2 view_item' as step,
    s2 as view_item,
    round(s2/nullif(s1, 0)*100,2) as pct_from_start,
    round(s2/nullif(s1, 0)*100,2) as step_cvr
from sum_event
union all
select
	'3 add2cart' as step,
    s3 as view_item,
    round(s3/nullif(s1, 0)*100,2) as pct_from_start,
    round(s3/nullif(s2, 0)*100,2) as step_cvr
from sum_event
union all
select
	'4 begin_checkout' as step,
    s4 as view_item,
    round(s4/nullif(s1, 0)*100,2) as pct_from_start,
    round(s4/nullif(s3, 0)*100,2) as step_cvr
from sum_event
union all
select
	'5 purchase' as step,
    s5 as view_item,
    round(s5/nullif(s1, 0)*100,2) as pct_from_start,
    round(s5/nullif(s4, 0)*100,2) as step_cvr
from sum_event;
