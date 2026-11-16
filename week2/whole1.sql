select * from order_items;
-- 1. 구매 이력이 있는 사용자 주문 내역 조회
select u.user_id, u.signup_date, o.order_id, o.order_date
from users as u
left join orders as o
	on u.user_id = o.user_id
where order_status = "delivered"
order by o.order_date;

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

-- 3. 카테고리별 매출 계산하기 /어떤 상품 카테고리가 가장 많은 매출을 발생시키는지 알고 싶음
-- order_items와 product의 product_id 조인
-- orders와 order_items order_id 조인
select category, SUM(total_amount) AS CATEGORY_TATAL_AMOUNT
FROM PRODUCTS AS P
LEFT JOIN ORDER_ITEMS AS OI
	ON P.PRODUCT_ID = OI.PRODUCT_ID
LEFT JOIN ORDERS AS O
	ON OI.ORDER_ID = O.ORDER_ID;

-- 4. 사용자별 구매 횟수와 총 구매 금액 / 충성 고객을 찾기 위해 사용자별 구매 현황을 요청했어.
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
