-- 6. 신규 세션 vs 기존(재방문) 세션 구매전환율 비교
-- event_date = signup_date 인 new_session과
-- event_date > signup_date 인 returning_session의 조회 대비 구매 전환율(%)을 비교하세요.
-- purchase 전체 대비 purchase를 구하고 날짜별로 비중이 얼마나 되는지 비교문으로 거르기


with session_type as (
	select
		ue.session_id,
		CASE
			WHEN ue.event_date = u.signup_date THEN 'New_session'
			else 'Returning_session'
		end as session_group,
        max(case when event_name='view_item' then 1 else 0 end) as has_view,
        max(case when event_name='purchase' then 1 else 0 end) as has_purchase
	from user_events ue
	left join users u
		on ue.user_id= u.user_id
	group by ue.session_id,
		case
			WHEN ue.event_date = u.signup_date THEN 'New_session'
			else 'Returning_session'
		end
)

select
	session_group,
	sum(has_view),
	sum(has_purchase),
    100*sum(has_purchase) / nullif(sum(has_view), 0) as pct_session
from session_type
group by session_group

