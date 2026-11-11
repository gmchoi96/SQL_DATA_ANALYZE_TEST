-- 16. 주문 금액을 30,000원 미만, 30,000~99,999원, 100,000원 이상으로 분류하라(case when)
select order_id, total_amount,
case
	when total_amount < 30000 then "low"
    when total_amount < 100000 then 'medium'
    else 'high'
    end as amount_group
from orders;