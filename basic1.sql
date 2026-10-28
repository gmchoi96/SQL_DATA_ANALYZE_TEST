-- TEST 1~7 ---
-- 1. 사용자 테이블 전체 데이터 조회
select * from users;
-- 2. 상품의 상품명과 가격만 조회 --
select product_name, unit_price from products;
-- 3. 가격이 50,000원 이상인 상품을 조회
select product_name, unit_price from products
where unit_price>=50000;
-- 4. 2025년 6월에 발생한 주문을 조회하라
select order_id, order_date from orders
where order_date>= date '2025-06-01'
and order_date< date '2025-07-01';
-- 5. 주문 금액이 높은 순서로 주문 10건을 조회한다.
select * from orders
order by total_amount desc limit 10;
-- 6. 중복을 제외한 상품 카테고리 목록을 구하라
select distinct * from products
order by category;
-- 7. 유입 채널이 NULL인 사용자를 조회하라
select * from users
where acquisition_channel IS NULL;