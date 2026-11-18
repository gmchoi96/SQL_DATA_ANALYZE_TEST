-- 13. 사용자별 누적 구매 금액 계산 / 사용자가 시간의 흐름에 따라 얼마나 많은 금액을 구매했는지 분석
WITH cumulative AS (SELECT
	USER_ID,
    ORDER_ID,
    ORDER_DATE,
    TOTAL_AMOUNT,
    LAG(TOTAL_AMOUNT) OVER (partition by USER_ID ORDER BY USER_ID) AS PREVIOUS_AMOUNT
FROM ORDERS
where order_status = 'delivered'
ORDER BY USER_ID
)

SELECT
	USER_ID,
    ORDER_ID,
	TOTAL_AMOUNT,
    PREVIOUS_AMOUNT,
    sum(TOTAL_AMOUNT)
    over(partition by user_id order by user_id, order_id)
    as cumulative_amount
from cumulative;

-- rows between----
SELECT
    user_id,
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_purchase
FROM orders
WHERE order_status = 'DELIVERED'
ORDER BY user_id, order_date;