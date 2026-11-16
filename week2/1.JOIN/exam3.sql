-- 3. 카테고리별 매출 계산하기 /어떤 상품 카테고리가 가장 많은 매출을 발생시키는지 알고 싶음
-- order_items와 product의 product_id 조인
-- orders와 order_items order_id 조인
select p.category, SUM(oi.quantity*oi.unit_price) AS CATEGORY_TATAL_AMOUNT,
sum(oi.quantity) as sell_quantit_ycount 
FROM PRODUCTS AS P
LEFT JOIN ORDER_ITEMS AS OI
	ON P.PRODUCT_ID = OI.PRODUCT_ID
LEFT JOIN ORDERS AS O
	ON OI.ORDER_ID = O.ORDER_ID
where order_status = 'delivered'
GROUP BY p.category
ORDER BY CATEGORY_TATAL_AMOUNT DESC;
-- 다만 이번 문제는 배송 완료 주문만 분석해야 하므로,
-- orders부터 시작하면 주문 상태를 먼저 필터링한다는 사고 흐름을 만들기 좋아.

SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales,
    SUM(oi.quantity) AS total_quantity
FROM orders AS o
INNER JOIN order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'DELIVERED'
GROUP BY p.category
ORDER BY total_sales DESC;