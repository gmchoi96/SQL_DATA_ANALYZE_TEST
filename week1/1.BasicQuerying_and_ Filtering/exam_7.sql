-- 7. 유입 채널이 NULL인 사용자를 조회하라
select * from users
where acquisition_channel IS NULL;