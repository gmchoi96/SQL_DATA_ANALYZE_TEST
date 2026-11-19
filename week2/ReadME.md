📊 # E-commerce SQL Analysis | Week 2
 Advanced SQL & Customer Behavior Analysis JOIN 심화, CTE, 서브쿼리, Window Function을 활용한 이커머스 고객 행동 분석
### 1. Project Overview

1주차에서 학습한 SQL 기본 문법과 데이터 집계 능력을 바탕으로, 2주차에는 복합적인 SQL 작성과 고객 행동 분석에 집중합니다.

단순히 데이터를 조회하고 집계하는 것을 넘어 여러 테이블을 연결하고, 고객의 구매 흐름과 매출 변화를 분석하는 것을 목표로 합니다.

이번 주차의 핵심 목표

다중 JOIN을 활용한 데이터 연결 서브쿼리와 CTE를 활용한 복합 쿼리 작성 Window Function을 활용한 순위 및 누적 데이터 분석 고객별 첫 구매 및 재구매 패턴 분석 월별 매출 추이 및 전월 대비 변화 분석 SQL 분석 결과를 비즈니스 관점에서 해석하기 

### 2. Dataset

1주차에서 생성한 이커머스 가상 데이터 4개를 동일하게 사용합니다.

Table Description
- users: 사용자 정보 및 유입 채널
- orders: 주문 정보 및 주문 상태
- products: 상품 정보 및 카테고리
- order_items: 주문별 상품 및 수량 정보

분석 기준

매출 분석: DELIVERED 주문 기준
구매 횟수: 별도 조건이 없다면 DELIVERED 주문 기준
날짜 분석: BigQuery DATE 형식
사용 데이터: 가상의 이커머스 데이터

### 3. Learning Topics

이번 주차는 크게 세 가지 SQL 역량을 집중적으로 학습합니다.

- 1. JOIN 심화

여러 테이블을 연결하여 분석 목적에 맞는 데이터를 추출하는 방법을 학습합니다.

주요 개념

INNER JOIN, LEFT JOIN, 다중 JOIN에서 ON과 WHERE의 차이
COUNT와 SUM을 활용한 집계 COALESCE를 활용한 NULL 처리

학습 목적

단순한 테이블 연결을 넘어 분석 목적에 따라 적절한 JOIN 방식을 선택하고, 데이터 중복 및 집계 오류를 방지하는 방법을 익힙니다.

- 2. Subquery & CTE

복잡한 SQL을 여러 단계로 나누어 작성하는 방법을 학습합니다.

주요 개념

Subquery WITH CTE 다중 CTE 집계 결과를 활용한 조건 필터링

학습 목적

복잡한 분석 문제를 단계별로 분리하여 이해하고, 재사용하기 쉽고 가독성이 높은 SQL을 작성하는 능력을 기릅니다.

- 3. Window Function

이번 주차에서 가장 중요하게 학습하는 영역입니다.

주요 개념

| 함수 | 기능 | 실무 활용 |
| :--- | :--- | :--- |
| `ROW_NUMBER` | 행별 순번 부여 | 고객별 첫 구매 찾기 |
| `RANK` | 순위 계산 | 구매 금액 기준 VIP 선정 |
| `LAG` | 이전 행의 값 조회 | 재구매 간격 및 전월 매출 |
| `SUM OVER` | 누적 합계 및 전체 합계 | 누적 구매 금액 및 매출 비중 |
| `PARTITION BY` | 그룹별 계산 기준 설정 | 사용자별 구매 순위 |
| `ORDER BY` | 계산 순서 지정 | 시간순 구매 분석 |

학습 목적

GROUP BY만으로는 해결하기 어려운 고객별 구매 흐름, 순위, 누적 구매 금액 등을 분석하는 방법을 익힙니다.

### 4. SQL Practice

총 15개의 실습 문제를 통해 학습한 개념을 적용합니다.

##### Part 1. JOIN 심화 (01~04)
* 핵심 학습 : 분석 목적에 맞는 JOIN 방식 선택 및 다중 테이블 연결

| No. | Practice | SQL Concepts |
| :---: | :--- | :--- |
| 01 | 구매 이력이 있는 사용자 찾기 | `INNER JOIN` |
| 02 | 구매하지 않은 사용자 찾기 | `LEFT JOIN`, `IS NULL` |
| 03 | 카테고리별 매출 계산 | `Multi JOIN`, `GROUP BY` |
| 04 | 사용자별 구매 횟수와 총구매 금액 | `LEFT JOIN`, `COUNT`, `COALESCE` |

---

##### Part 2. Subquery & CTE (05~08)
* 핵심 학습 : 복합 쿼리 작성 및 단계별 데이터 집계

| No. | Practice | SQL Concepts |
| :---: | :--- | :--- |
| 05 | 평균보다 많이 구매한 사용자 찾기 | `CTE`, `Subquery` |
| 06 | 사용자별 첫 구매 날짜 구하기 | `MIN`, `GROUP BY` |
| 07 | 월별 신규 구매자 수 구하기 | `CTE`, `DATE_TRUNC` |
| 08 | 상품별 매출 기여도 계산 | `CTE`, `SUM OVER` |

---

##### Part 3. Window Function (09~13)
* 핵심 학습 : 고객 행동 흐름 및 시간에 따른 데이터 변화 분석

| No. | Practice | SQL Concepts |
| :---: | :--- | :--- |
| 09 | 사용자별 첫 구매 주문 찾기 | `ROW_NUMBER` |
| 10 | 구매 금액 기준 사용자 순위 | `RANK` |
| 11 | 사용자별 이전 구매일 및 구매 간격 | `LAG`, `DATE_DIFF` |
| 12 | 월별 매출 및 전월 대비 증감액 | `LAG`, `DATE_TRUNC` |
| 13 | 사용자별 누적 구매 금액 | `SUM OVER`, `PARTITION BY` |

---

##### Part 4. Comprehensive Analysis (14~15)
* 핵심 학습 : 여러 SQL 개념을 조합하여 실제 비즈니스 질문 해결

| No. | Practice | SQL Concepts |
| :---: | :--- | :--- |
| 14 | 첫 구매 후 재구매까지 걸린 기간 | `CTE`, `ROW_NUMBER`, `CASE WHEN` |
| 15 | 유입 채널별 고객 매출 분석 | `JOIN`, `CTE`, `GROUP BY` |

### 5. Business Insight

SQL을 작성하고 결과를 도출하는 것에서 끝내지 않고, 분석 결과가 비즈니스에 어떤 의미를 가지는지 생각합니다.

| 분석 결과 | 비즈니스 활용 방향 |
| :--- | :--- |
| 구매 이력이 없는 고객 | 첫 구매 유도 프로모션 |
| 구매 금액이 높은 고객 | VIP 고객 관리 및 혜택 제공 |
| 재구매 간격이 긴 고객 | 재구매 유도 캠페인 |
| 매출 기여도가 높은 상품 | 핵심 상품 중심의 마케팅 |
| 전월 대비 매출 감소 | 매출 하락 원인 분석 |
| 유입 채널별 구매 성과 차이 | 마케팅 예산 배분 검토 |


##### ! Note: 본 프로젝트에 사용된 모든 데이터는 SQL 학습을 위해 생성한 가상 데이터이며 실제 기업의 거래 데이터가 아닙니다.
