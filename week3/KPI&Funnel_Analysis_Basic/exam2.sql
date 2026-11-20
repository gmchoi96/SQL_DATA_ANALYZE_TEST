-- 2. 단계별 사용자 풀 퍼널& 이탈 구간 파악
-- signup → view_item → add_to_cart → begin_checkout → purchase 단계별 고유 사용자 수(UV),
-- 가입 전환율(%), 직전 단계 대비 전환율(%)
-- event name 에서 view_item, add_to_cart, begin_checkout, purchase 구분

select
	count(distinct u.user_id) as singup_users,
    count(case when UE.event_name = 'view_item' then UE.event_name end) as just_view,
    count(DISTINCT case when UE.event_name = 'view_item' then U.USER_ID end) as just_view2
from users as u
left join user_events as ue
	on u.user_id = ue.user_id;
    