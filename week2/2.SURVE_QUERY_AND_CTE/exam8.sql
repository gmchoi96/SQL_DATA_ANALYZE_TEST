    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON o.order_id = oi.order_id
    INNER JOIN products AS p
        ON oi.product_id = p.product_id
    WHERE o.order_status = 'DELIVERED'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
	order by p.category
-- with product_amount as (
-- 	select
-- 		p.product_id,
-- 		p.product_name,
-- 		p.category,
-- 		sum(oi.quantity * oi.unit_price) as amount_product,
--         o.total_amount
-- 	from products as p
-- 	left join order_items as oi
-- 		on p.product_id = oi.product_id
--     left join orders as o
-- 		on oi.order_id = o.order_id
-- 	WHERE o.order_status = 'DELIVERED'
-- 	group by 
-- 		p.product_id,
--         p.product_name,
--         p.category
-- 	)

-- select
-- 	p.product_name,
--     p.category,
--     p.amount_product,
--     sum(o.total_amount)
-- from product_amount 

-- select
-- 	*
-- -- 	product_name,
-- --     category,
-- --     amount_product
-- from product_amount
-- order by category