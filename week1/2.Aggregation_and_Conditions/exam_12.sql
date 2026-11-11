-- 12. 카테고리별 평균 상품 가격을 구하라
select category,avg(unit_price) as category_avg_price from products
group by category
order by category_avg_price desc;	