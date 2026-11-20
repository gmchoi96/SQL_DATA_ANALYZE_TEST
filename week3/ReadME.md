📊 # E-commerce SQL Analysis | Week 3
 Advanced SQL & Customer Behavior Analysis JOIN 심화, CTE, 서브쿼리, Window Function을 활용한 이커머스 고객 행동 분석
### 1. Project Overview



### 2. Dataset

| 파일명 | 행 수 | 주요 컬럼 | 역할 |
|---|---:|---|---|
| `users.csv` | 2,000 | `user_id`, `signup_date`, `gender`, `age`, `acquisition_channel`, `primary_device` | 가입자 정보 (유입 채널, 주 사용 디바이스, 가입일) |
| `products.csv` | 30 | `product_id`, `product_name`, `category`, `unit_price` | 상품 정보 (카테고리, 단가) |
| `orders.csv` | 698 | `order_id`, `user_id`, `order_date`, `order_status`, `device_type`, `total_amount` | 주문 헤더 (주문 상태: COMPLETED/CANCELLED, 결제 기기, 총 주문액) |
| `order_items.csv` | 954 | `order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price` | 주문 상세 품목 (주문별 구매 상품, 수량, 구매 단가) |
| `user_events.csv` | 14,110 | `event_id`, `user_id`, `session_id`, `event_timestamp`, `event_date`, `event_name`, `device_type`, `product_id` | 행동 이벤트 로그 (signup, view_item, add_to_cart, begin_checkout, purchase) |

### 3. Learning Topics




### 4. SQL Practice



### 5. Business Insight




##### ! Note: 본 프로젝트에 사용된 모든 데이터는 SQL 학습을 위해 생성한 가상 데이터이며 실제 기업의 거래 데이터가 아닙니다.
