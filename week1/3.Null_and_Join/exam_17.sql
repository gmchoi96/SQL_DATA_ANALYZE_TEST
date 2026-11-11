-- 17.유입 채널별 사용자 수를 구하고, 채널이 없는 사용자는 UNKNOWN으로 표시하라.
select
 	coalesce(NULLIF(acquisition_channel, ''), "unknown1") as channel,
	count(*) as count_user
from users
group by channel
ORDER BY count_user DESC;