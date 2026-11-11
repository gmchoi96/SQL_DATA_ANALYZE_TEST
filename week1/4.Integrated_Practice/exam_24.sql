SELECT order_id, total_amount from orders
where total_amount > 
	(select avg(total_amount) from orders);