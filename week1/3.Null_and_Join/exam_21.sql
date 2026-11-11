-- 21번 문제 동일 결과 확인
SELECT
  p.category,
  SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items AS oi
JOIN products AS p
  ON oi.product_id = p.product_id
JOIN orders AS o
  ON oi.order_id = o.order_id
WHERE o.order_status = 'DELIVERED'
GROUP BY p.category
ORDER BY revenue DESC;