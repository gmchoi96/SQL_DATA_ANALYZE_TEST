-- 2. 구매하지 않은 사용자 찾기
-- join에 order status 조건을 걸어 주문이 지연되거나 캔슬된 주문자도 확인 가능 
select u.user_id, u.signup_date, u.acquisition_channel
from users as u
left join orders as o
	on u.user_id = o.user_id
where order_status is null;

SELECT
    u.user_id,
    u.signup_date,
    u.acquisition_channel
FROM users AS u
LEFT JOIN orders AS o
    ON u.user_id = o.user_id
    AND o.order_status = 'DELIVERED'
WHERE o.order_id IS NULL
ORDER BY u.user_id;

