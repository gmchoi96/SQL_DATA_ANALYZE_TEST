-- 20.상품별 주문 수량 합계를 구하라
select p.product_id, p.product_name, sum(oi.quantity) as count_quantity
from order_items as oi
left join products as p
	on p.product_id = oi.product_id
group by p.product_id, p.product_name;