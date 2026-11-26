<!-- 📊 # E-commerce SQL Analysis | Week 3
 Advanced SQL & Customer Behavior Analysis JOIN 심화, CTE, 서브쿼리, Window Function을 활용한 이커머스 고객 행동 분석
### 1. Project Overview

- **학습 주제:** 3주차 — KPI & Funnel Analysis (MySQL 8.0+)
- **학습 목적:** 원천 로그(`user_events`)와 트랜잭션 데이터(`orders`, `order_items`)를 결합해 서비스의 성장성, 전환 효율, 병목 구간을 수치로 정의하고 원인 가설을 세우는 역량을 기릅니다.
- **학습 방향:**
  - 단순히 쿼리를 작성하는 데 그치지 않고, **지표의 정의와 분모·분자 기준(전체 가입자 vs. 활동 사용자 vs. 세션)**이 결과 해석에 미치는 영향을 파악합니다.
  - 전체 평균(Aggregate) 뒤에 가려진 **세그먼트 차이(유입 채널, 디바이스, 신규/재방문 세션, 상품 카테고리)**를 쪼개어 보는 분석 습관을 기릅니다.
  - 수치 변화나 이상 징후를 발견했을 때 **현상 요약 → 원인 가설 도출 → 후속 액션/검증 포인트 연결**까지 이어가는 프로덕트 애널리틱스 관점을 훈련합니다.

### 2. Dataset

| 파일명 | 행 수 | 주요 컬럼 | 역할 |
|---|---:|---|---|
| `users.csv` | 2,000 | `user_id`, `signup_date`, `gender`, `age`, `acquisition_channel`, `primary_device` | 가입자 정보 (유입 채널, 주 사용 디바이스, 가입일) |
| `products.csv` | 30 | `product_id`, `product_name`, `category`, `unit_price` | 상품 정보 (카테고리, 단가) |
| `orders.csv` | 698 | `order_id`, `user_id`, `order_date`, `order_status`, `device_type`, `total_amount` | 주문 헤더 (주문 상태: COMPLETED/CANCELLED, 결제 기기, 총 주문액) |
| `order_items.csv` | 954 | `order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price` | 주문 상세 품목 (주문별 구매 상품, 수량, 구매 단가) |
| `user_events.csv` | 12,110 | `event_id`, `user_id`, `session_id`, `event_timestamp`, `event_date`, `event_name`, `device_type`, `product_id` | 행동 이벤트 로그 (signup, view_item, add_to_cart, begin_checkout, purchase) |

### 3. Learning Topics




### 4. SQL Practice



### 5. Business Insight




##### ! Note: 본 프로젝트에 사용된 모든 데이터는 SQL 학습을 위해 생성한 가상 데이터이며 실제 기업의 거래 데이터가 아닙니다.

 -->


📊 # E-commerce SQL Analysis | Week 3
KPI & Funnel Analysis — MySQL 8.0+ 환경에서 이벤트 로그와 주문 데이터를 활용한 핵심 지표 산출 및 전환 퍼널 분석

### 1. Project Overview

2주차에서 학습한 다중 JOIN, CTE, Window Function 역량을 바탕으로, 3주차에는 프로덕트 애널리틱스 관점의 핵심 비즈니스 KPI와 사용자 전환 퍼널(Funnel) 분석에 집중합니다.

단순한 주문 데이터 집계를 넘어 행동 이벤트 로그(`user_events`)와 주문 데이터(`orders`, `products`)를 연결하여, 서비스의 전환 효율과 이탈 구간을 수치로 정의하고 원인 가설을 도출하는 것을 목표로 합니다.

이번 주차의 핵심 목표
- 핵심 비즈니스 KPI(GMV, PU, ARPU, ARPPU, DAU/MAU, Stickiness) 정의 및 산출
- 사용자 단위 및 세션 단위 전환 퍼널(Funnel) 설계와 이탈 구간 파악
- 유입 채널, 디바이스, 신규/재방문 세션, 상품 카테고리별 세그먼트 전환율 비교
- 결제 전환 소요 시간(평균·중앙값) 및 주간 전환율 급락 이상 징후 추적
- 주문 취소율(`CANCELLED`) 및 취소 금액 분석을 통한 비즈니스 개선 가설 도출

---

### 2. Dataset

3주차에서는 기존 주문 테이블에 카테고리 및 사용자 행동 이벤트 로그(`user_events`)가 추가된 5개의 정규화된 가상 이커머스 테이블을 사용합니다.

**Table Description**
| 파일명 | 행 수 | 주요 컬럼 | 역할 |
|---|---:|---|---|
| `users.csv` | 2,000 | `user_id`, `signup_date`, `gender`, `age`, `acquisition_channel`, `primary_device` | 가입자 정보 (유입 채널, 주 사용 디바이스, 가입일) |
| `products.csv` | 30 | `product_id`, `product_name`, `category`, `unit_price` | 상품 정보 (카테고리, 단가) |
| `orders.csv` | 698 | `order_id`, `user_id`, `order_date`, `order_status`, `device_type`, `total_amount` | 주문 헤더 (주문 상태: COMPLETED/CANCELLED, 결제 기기, 총 주문액) |
| `order_items.csv` | 954 | `order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price` | 주문 상세 품목 (주문별 구매 상품, 수량, 구매 단가) |
| `user_events.csv` | 12,110 | `event_id`, `user_id`, `session_id`, `event_timestamp`, `event_date`, `event_name`, `device_type`, `product_id` | 행동 이벤트 로그 (signup, view_item, add_to_cart, begin_checkout, purchase) |

분석 기준
- 매출 및 구매자 분석: `COMPLETED` 주문 기준 (`CANCELLED`는 별도 취소율 분석에서 분리 집계)
- 실제 활동 이벤트 기준: DAU/MAU 및 세션 분석 시 가입(`signup`) 이벤트 제외
- 날짜 및 시간 분석: MySQL 8.0+ `DATE`, `DATETIME` 형식 (`DATEDIFF`, `TIMESTAMPDIFF`, `DATE_SUB` 활용)
- 사용 데이터: SQL 학습을 위해 생성한 가상의 이커머스 데이터

---

### 3. Learning Topics

이번 주차는 크게 세 가지 프로덕트 데이터 분석 역량을 집중적으로 학습합니다.

- 1. 비즈니스 핵심 KPI 및 활성도 지표 설계

서비스의 매출 규모와 사용자 활성도를 정확히 측정하기 위한 분모·분자 기준을 학습합니다.

주요 개념
- `GMV`, `PU(Paying Users)`, `ARPU`, `ARPPU` 산출 및 `NULLIF`·`COALESCE` 방어 로직
- `DAU`, `MAU`, `Stickiness(DAU/MAU %)` 계산 시 `signup` 이벤트 제외 기준
- 주문 취소율(`CANCELLED`) 및 취소 금액 집계를 통한 순매출 누수 파악

학습 목적
- 지표의 정의(전체 가입자 기준 vs. 구매자 기준 vs. 실제 활동 유저 기준)에 따라 쿼리 구조와 해석이 어떻게 달라지는지 이해합니다.

- 2. 사용자 & 세션 단위 퍼널(Funnel) 전환율 분석

고객이 가입 후 탐색부터 결제 완료까지 도달하는 여정을 단계별로 쪼개어 병목 구간을 찾는 방법을 학습합니다.

주요 개념
- 5단계 풀 퍼널(`signup` → `view_item` → `add_to_cart` → `begin_checkout` → `purchase`)
- 전체 가입자 대비 전환율(`pct_from_start`) vs. 직전 단계 대비 전환율(`step_cvr`)
- 사용자(`user_id`) 기준 집계와 세션(`session_id`) 기준 집계 (`MAX(CASE WHEN ...)` 플래그화)

학습 목적
- 중복 이벤트로 인한 전환율 왜곡을 방지하고, 어느 단계에서 가장 큰 이탈(Drop-off)이 발생하는지 정확히 진단하는 능력을 기릅니다.

- 3. 세그먼트 비교 및 시간·이상 징후 분석 (MySQL 8.0+)

전체 평균 뒤에 숨은 세그먼트별 차이와 시간 흐름에 따른 이상 패턴을 추적합니다.

주요 개념 및 함수

| 함수 / 기법 | 기능 | 실무 활용 |
| :--- | :--- | :--- |
| `CASE WHEN` 조건부 집계 | 조건별 건수·플래그 분리 | 단계별 전환 세션 및 완료/취소 주문 분리 |
| `TIMESTAMPDIFF` | 두 시점 간 시간 차이 계산 | 첫 조회부터 결제 완료까지 소요 시간(분) |
| `ROW_NUMBER` / `COUNT OVER` | 그룹 내 정렬 순번 및 전체 행 수 | 디바이스별 결제 소요 시간 중앙값(Median) 산출 |
| `DATE_SUB` + `WEEKDAY` | 날짜를 해당 주 시작일(월요일)로 변환 | 주간 단위 결제 전환율 추이 및 급락 구간 추적 |
| `NULLIF` / `COALESCE` | 0 나누기 방지 및 `NULL` 대체 | 미전환·미구매 세그먼트의 안전한 비율 계산 |

학습 목적
- 평균의 함정을 피하기 위해 중앙값(Median)과 세그먼트 분해(채널·디바이스·신규/재방문·카테고리)를 병행하고, 지표 급락 시 원인 가설을 도출하는 분석 사고력을 기릅니다.

---

### 4. SQL Practice

총 10개의 실습 문제를 통해 기초 KPI·퍼널부터 세그먼트 분해, 심화 전환 시간 및 이상 징후 분석까지 단계적으로 적용합니다.

##### Part 1. 기초 KPI & 퍼널 분석 (01~03)
- 핵심 학습: 핵심 매출·활성도 지표 산출 및 5단계 사용자 풀 퍼널 구축

| No. | Practice | SQL Concepts |
| :---: | :--- | :--- |
| 01 | 핵심 비즈니스 KPI 요약 추출 (GMV, PU, ARPU, ARPPU) | `LEFT JOIN`, `CASE WHEN`, `NULLIF`, `COALESCE` |
| 02 | 5단계 사용자 풀 퍼널 & 이탈 구간 파악 | `CTE`, `MAX(CASE WHEN)`, `UNION ALL` |
| 03 | 실제 활동 기반 DAU / MAU 및 Stickiness | `CTE`, `COUNT(DISTINCT)`, `CROSS JOIN` |

---

##### Part 2. 세그먼트별 전환율 비교 (04~07)
- 핵심 학습: 채널·디바이스·세션 유형·카테고리별 전환 효율 차이 분해

| No. | Practice | SQL Concepts |
| :---: | :--- | :--- |
| 04 | 유입 채널별 가입 → 첫 완료 주문 전환율 | `CTE`, `LEFT JOIN`, `GROUP BY` |
| 05 | 디바이스(`device_type`)별 세션 퍼널 비교 | `CTE`, `session_id` 단위 집계, 단계별 전환율 |
| 06 | 신규 세션 vs. 기존(재방문) 세션 구매 전환율 비교 | `JOIN`, `CASE WHEN` (`event_date` vs `signup_date`) |
| 07 | 상품 카테고리별 조회 → 장바구니 전환율 | `INNER JOIN`, 조건부 `COUNT`, `GROUP BY` |

---

##### Part 3. 심화 전환 속도 & 이상 징후 분석 (08~10)
- 핵심 학습: 결제 소요 시간 분포, 주간 전환율 급락 추적 및 주문 취소 리스크 파악

| No. | Practice | SQL Concepts |
| :---: | :--- | :--- |
| 08 | 디바이스별 결제 전환 소요 시간(평균 & 중앙값) 분석 | `TIMESTAMPDIFF`, `ROW_NUMBER`, `COUNT OVER` |
| 09 | 특정 기간(10월) 주간 결제 전환율 급락(이상 징후) 추적 | `DATE_SUB`, `WEEKDAY`, 주간·디바이스별 집계 |
| 10 | 유입 채널·디바이스별 주문 취소율 및 취소 금액 분석 | `INNER JOIN`, 조건부 `COUNT`/`SUM` |

---

### 5. Business Insight

퍼널과 KPI 분석 결과를 단순히 수치로 남기지 않고, 실제 프로덕트 및 마케팅 의사결정에 어떻게 연결할지 정리했습니다.

| 분석 결과 | 비즈니스 활용 방향 |
| :--- | :--- |
| 특정 퍼널 단계의 높은 이탈률 | 이탈 집중 구간(장바구니·결제 시작 등) UI/UX 개선 우선순위 설정 |
| 유입 채널별 가입 대비 구매 전환율 차이 | 단순 가입 수(Volume)가 아닌 실제 구매 전환(Quality) 기준 채널 예산 재배분 |
| 디바이스별 세션 퍼널 및 소요 시간 격차 | 전환율이 낮거나 결제 소요 시간이 긴 환경(예: Mobile Web)의 결제 동선 최적화 |
| 신규 세션 대비 재방문 세션의 높은 구매 전환율 | 첫 방문 이탈 고객 대상 리타겟팅 및 재방문 유도 넛지 설계 |
| 카테고리별 조회 → 장바구니 전환율 차이 | 조회 대비 담기 전환이 낮은 카테고리의 상품 상세 페이지·가격 경쟁력 점검 |
| 특정 주차 결제 완료율 급락 및 높은 취소율 | PG/결제 모듈 장애 점검, 배포 회귀 버그 확인 및 취소 다발 채널·기기 원인 분석 |

---

##### ! Note: 본 프로젝트에 사용된 모든 데이터는 SQL 학습을 위해 생성한 가상 데이터이며 실제 기업의 거래 데이터가 아닙니다.