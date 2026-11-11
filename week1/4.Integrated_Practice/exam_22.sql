-- 22. 월별 배송 완료 주문 건수와 주문 금액 합계를 구하라
select month(order_date) as month_date, count(order_status) as count_delivered, sum(total_amount) as delivered_amount
from orders
where order_status = "delivered"
group by month_date
order by month_date;