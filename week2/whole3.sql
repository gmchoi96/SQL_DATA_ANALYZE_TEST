-- 9. 사용자별 첫 구매 주문 찾기 / 고객별 첫 구매 주문 정보를 확인
with ranked_orders as (
    SELECT
        user_id,
        order_id,
        order_date,
        total_amount,
        row_number() over (partition by user_id order by order_date, order_id) as rn
    FROM orders
	WHERE order_status = 'DELIVERED'
)

select
	user_id,
	order_id,
	order_date,
    total_amount
from ranked_orders
where rn = 1;

-- 10. 구매 금액 기준 사용자 순위 / 구매 금액이 높은 VIP 고객 선정

with VIP AS (
select
	user_id,
	sum(total_amount) as total
    -- row_number() over (partition by user_id order by sum(total_amount))
from orders
where order_status = 'delivered'
group by user_id
),

user_ranking as (
	SELECT 
		user_id,
		total,
		RANK() OVER (ORDER BY total DESC) AS RN
	FROM VIP
)

select
	user_id,
    total,
    rn
from user_ranking
where rn <= 10
order by rn;


-- 11. 사용자별 이전 구매일과 구매 간격 계산 /고객의 재구매 주기 파악
WITH DATE_DIFF AS(
	select 
		USER_ID,
		ORDER_ID,
		ORDER_DATE,
		ORDER_STATUS,
		LAG(ORDER_DATE) OVER(partition by USER_ID ORDER BY USER_ID, ORDER_DATE)  AS PREVIOUS_DATE
	FROM ORDERS
	WHERE ORDER_STATUS = 'DELIVERED'
	)

SELECT
	USER_ID,
    ORDER_ID,
    ORDER_DATE,
    PREVIOUS_DATE,
    DATEDIFF(ORDER_DATE, PREVIOUS_DATE) AS DIFF_DATE
FROM DATE_DIFF
ORDER BY USER_ID, ORDER_DATE;


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


-- 13. 사용자별 누적 구매 금액 계산/ 사용자가 시간의 흐름에 따라 얼마나 많은 금액을 구매했는지 분석
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
