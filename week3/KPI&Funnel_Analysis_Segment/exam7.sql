-- 7. 상품 카테고리별 조회 → 장바구니 전환율
-- products와 user_events를 조인하여 category별 view_item 건수, add_to_cart 건수,
-- 조회 대비 장바구니 전환율(%)을 구하기

select
    p.category,
    count(case when event_name = 'view_item' then 1 end) as just_view,
    count(case when event_name = 'add_to_cart' then 1 end) as add_cart,
    round(100*count(case when event_name = 'add_to_cart' then 1 end)
    /
    nullif(count(case when event_name = 'view_item' then 1 end),0), 2) as pct_view_to_cart
     
from products p
left join user_events ue
	on ue.product_id = p.product_id
group by p.category
order by pct_view_to_cart desc;

