-- 12. 월별 매출과 전월 대비 증감액 계산 / 월별 매출이 전월에 비해 얼마나 증가하거나 감소했는지 확인
WITH PREVIOUS_AMOUNT AS (
	SELECT
		DATE_FORMAT(ORDER_DATE, '%Y-%m') month,
		sum(TOTAL_AMOUNT) as amount
	FROM ORDERS
	where order_status = 'delivered'
	GROUP BY month
	ORDER BY MONTH
),

DIFF_AMOUNT AS (
SELECT
	month,
    AMOUNT,
    LAG(AMOUNT) OVER (ORDER BY AMOUNT) AS PREVIOUS_AMOUNT
FROM PREVIOUS_AMOUNT
)

SELECT
	month,
    AMOUNT,
    PREVIOUS_AMOUNT,
	FORMAT((AMOUNT - PREVIOUS_AMOUNT), 0) AS revenue_change
FROM DIFF_AMOUNT
ORDER BY month;
