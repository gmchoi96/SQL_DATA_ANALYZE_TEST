-- 8. 상품별 매출이 전체 매출에서 차지하는 비율 / 각 상품이 전체 매출에 얼마나 기여하는지

with product_sales as (
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
)

select
	product_id,
    product_name,
    category,
    total_sales,
	(total_sales/nullif(sum(total_sales) OVER (),0))*100 as percent
from product_sales
order by percent desc;