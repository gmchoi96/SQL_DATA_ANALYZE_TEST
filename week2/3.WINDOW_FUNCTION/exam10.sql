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