-- 3. 실제 활동 기반 DAU / MAU 및 Stickiness
-- signup 을 제외한 실제 활동 이벤트 기준으로
-- 2026년 10월의 평균 DAU(일간 활성 사용자), MAU(월간 활성 사용자), Stickiness(DAU/MAU %)구하기
-- DAU : Daily Active Users, Monthly Active Users

with user_event as (
select
	distinct user_id, event_date
from user_events
where event_date between '2026-10-01' and '2026-10-31'
),

daily as (
select
	event_date,
	count(distinct user_id) as DAU
from user_event
group by event_date
order by event_date
),

monthly as (
select
	count(distinct user_id) as MAU
from user_event
)

select
	round(avg(d.DAU), 2),
    m.MAU,
    round(avg(d.DAU)/nullif(m.MAU, 0)*100, 2) as Stickiness
from daily d
cross join monthly m
group by m.MAU;

