-- 7. 월별 신규 구매자 수 구하기 / 매월 새롭게 구매를 시작한 고객이 얼마나 되는지
-- date를 월별로 구분을 하고 월별로 그룹화해야될 듯

    
WITH first_purchase AS (
    SELECT
        user_id,
        MIN(order_date) AS first_order_date
    FROM orders
    WHERE order_status = 'DELIVERED'
    GROUP BY user_id
)

SELECT
    DATE_FORMAT(first_order_date, '%y-%m-01') AS purchase_month,
    COUNT(user_id) AS new_buyers
FROM first_purchase
WHERE first_order_date >= '2025-01-01'
  AND first_order_date < '2026-01-01'
GROUP BY purchase_month
ORDER BY purchase_month;