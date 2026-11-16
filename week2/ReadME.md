📊 Week 2. Advanced SQL & Customer Behavior Analysis
JOIN 심화, CTE, 서브쿼리, Window Function을 활용한 이커머스 고객 행동 분석
1. Overview
학습 목표

1주차에서 학습한 SQL 기본 문법과 데이터 집계 능력을 바탕으로, 2주차에는 복합적인 SQL 작성과 고객 행동 분석에 집중합니다.

단순히 데이터를 조회하고 집계하는 것을 넘어 여러 테이블을 연결하고, 고객의 구매 흐름과 매출 변화를 분석하는 것을 목표로 합니다.

이번 주차의 핵심 목표

다중 JOIN을 활용한 데이터 연결
서브쿼리와 CTE를 활용한 복합 쿼리 작성
Window Function을 활용한 순위 및 누적 데이터 분석
고객별 첫 구매 및 재구매 패턴 분석
월별 매출 추이 및 전월 대비 변화 분석
SQL 분석 결과를 비즈니스 관점에서 해석하기
2. Dataset

1주차에서 생성한 이커머스 가상 데이터 4개를 동일하게 사용합니다.

Table	Description
users	사용자 정보 및 유입 채널
orders	주문 정보 및 주문 상태
products	상품 정보 및 카테고리
order_items	주문별 상품 및 수량 정보

분석 기준

매출 분석: DELIVERED 주문 기준
구매 횟수: 별도 조건이 없다면 DELIVERED 주문 기준
날짜 분석: BigQuery DATE 형식 사용
데이터: 가상의 이커머스 데이터
3. Learning Topics

이번 주차는 크게 세 가지 SQL 역량을 집중적으로 학습합니다.

3-1. JOIN 심화

여러 테이블을 연결하여 분석 목적에 맞는 데이터를 추출하는 방법을 학습합니다.

주요 개념

INNER JOIN
LEFT JOIN
다중 JOIN
ON과 WHERE의 차이
COUNT와 SUM을 활용한 집계
COALESCE를 활용한 NULL 처리

학습 목적

단순한 테이블 연결을 넘어 분석 목적에 따라 적절한 JOIN 방식을 선택하고, 데이터 중복 및 집계 오류를 방지하는 방법을 익힙니다.

3-2. Subquery & CTE

복잡한 SQL을 여러 단계로 나누어 작성하는 방법을 학습합니다.

주요 개념

Subquery
WITH
CTE
다중 CTE
집계 결과를 활용한 조건 필터링

학습 목적

복잡한 분석 문제를 단계별로 분리하여 이해하고, 재사용하기 쉽고 가독성이 높은 SQL을 작성하는 능력을 기릅니다.

3-3. Window Function

이번 주차에서 가장 중요하게 학습하는 영역입니다.

주요 개념

함수	기능	실무 활용
ROW_NUMBER	행별 순번 부여	고객별 첫 구매 찾기
RANK	순위 계산	구매 금액 기준 VIP 선정
LAG	이전 행의 값 조회	재구매 간격 및 전월 매출
SUM OVER	누적 합계 및 전체 합계	누적 구매 금액 및 매출 비중
PARTITION BY	그룹별 계산 기준 설정	사용자별 구매 순위
ORDER BY	계산 순서 지정	시간순 구매 분석

학습 목적

GROUP BY만으로는 해결하기 어려운 고객별 구매 흐름, 순위, 누적 구매 금액 등을 분석하는 방법을 익힙니다.

4. SQL Practice

총 15개의 실습 문제를 통해 학습한 개념을 적용합니다.

Part 1. JOIN 심화 (01~04)
No.	Practice	SQL Concepts
01	구매 이력이 있는 사용자 찾기	INNER JOIN
02	구매하지 않은 사용자 찾기	LEFT JOIN, IS NULL
03	카테고리별 매출 계산	Multi JOIN, GROUP BY
04	사용자별 구매 횟수와 총구매 금액	LEFT JOIN, COUNT, COALESCE

핵심 학습: 분석 목적에 맞는 JOIN 방식 선택 및 다중 테이블 연결

Part 2. Subquery & CTE (05~08)
No.	Practice	SQL Concepts
05	평균보다 많이 구매한 사용자 찾기	CTE, Subquery
06	사용자별 첫 구매 날짜 구하기	MIN, GROUP BY
07	월별 신규 구매자 수 구하기	CTE, DATE_TRUNC
08	상품별 매출 기여도 계산	CTE, SUM OVER

핵심 학습: 복합 쿼리 작성 및 단계별 데이터 집계

Part 3. Window Function (09~13)
No.	Practice	SQL Concepts
09	사용자별 첫 구매 주문 찾기	ROW_NUMBER
10	구매 금액 기준 사용자 순위	RANK
11	사용자별 이전 구매일 및 구매 간격	LAG, DATE_DIFF
12	월별 매출 및 전월 대비 증감액	LAG, DATE_TRUNC
13	사용자별 누적 구매 금액	SUM OVER, PARTITION BY

핵심 학습: 고객 행동 흐름 및 시간에 따른 데이터 변화 분석

Part 4. Comprehensive Analysis (14~15)
No.	Practice	SQL Concepts
14	첫 구매 후 재구매까지 걸린 기간	CTE, ROW_NUMBER, CASE WHEN
15	유입 채널별 고객 매출 분석	JOIN, CTE, GROUP BY

핵심 학습: 여러 SQL 개념을 조합하여 실제 비즈니스 질문 해결

5. Key Analysis Questions

이번 주차에서 중요하게 다루는 비즈니스 분석 질문입니다.

Analysis Category	Business Question
Customer Analysis	구매 이력이 없는 고객은 누구인가?
Customer Analysis	평균보다 많이 구매한 고객은 누구인가?
Customer Analysis	고객별 첫 구매일은 언제인가?
Customer Analysis	고객별 누적 구매 금액은 얼마인가?
Repurchase Analysis	첫 구매 이후 재구매까지 얼마나 걸리는가?
Repurchase Analysis	고객들은 평균적으로 얼마나 자주 재구매하는가?
Revenue Analysis	상품별 매출 기여도는 어떻게 다른가?
Revenue Analysis	월별 매출은 전월 대비 어떻게 변화하는가?
Marketing Analysis	어떤 유입 채널에서 구매 성과가 높은가?
6. Key SQL Techniques

이번 주차에서 중점적으로 익혀야 할 SQL 작성 패턴입니다.

① CTE를 활용한 단계별 집계
sql
WITH user_purchase AS (
    SELECT
        user_id,
        COUNT(order_id) AS purchase_count
    FROM orders
    WHERE order_status = 'DELIVERED'
    GROUP BY user_id
)

SELECT
    user_id,
    purchase_count
FROM user_purchase
WHERE purchase_count >= 3;

② ROW_NUMBER를 활용한 첫 구매 분석
sql
SELECT
    user_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY order_date, order_id
    ) AS purchase_rank
FROM orders
WHERE order_status = 'DELIVERED';

③ LAG를 활용한 이전 구매일 분석
sql
SELECT
    user_id,
    order_date,
    LAG(order_date) OVER (
        PARTITION BY user_id
        ORDER BY order_date, order_id
    ) AS previous_order_date
FROM orders
WHERE order_status = 'DELIVERED';

④ SUM OVER를 활용한 누적 구매 금액
sql
SELECT
    user_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_purchase
FROM orders
WHERE order_status = 'DELIVERED';

7. Learning Outcomes

이번 주차를 통해 다음과 같은 역량을 확보하는 것을 목표로 합니다.

여러 테이블을 연결하여 분석에 필요한 데이터를 추출할 수 있다.
INNER JOIN과 LEFT JOIN의 차이를 설명할 수 있다.
JOIN 이후 발생할 수 있는 중복 집계 문제를 이해한다.
CTE와 서브쿼리를 활용하여 복합 SQL을 작성할 수 있다.
ROW_NUMBER와 RANK의 차이를 설명할 수 있다.
PARTITION BY를 활용하여 그룹별 순위를 계산할 수 있다.
LAG를 활용하여 이전 구매일과 구매 간격을 계산할 수 있다.
SUM OVER를 활용하여 누적 구매 금액을 계산할 수 있다.
첫 구매와 재구매 패턴을 분석할 수 있다.
월별 매출 및 전월 대비 변화를 분석할 수 있다.
8. Business Insight

SQL을 작성하고 결과를 도출하는 것에서 끝내지 않고, 분석 결과가 비즈니스에 어떤 의미를 가지는지 생각합니다.

분석 결과	비즈니스 활용 방향
구매 이력이 없는 고객	첫 구매 유도 프로모션
구매 금액이 높은 고객	VIP 고객 관리 및 혜택 제공
재구매 간격이 긴 고객	재구매 유도 캠페인
매출 기여도가 높은 상품	핵심 상품 중심의 마케팅
전월 대비 매출 감소	매출 하락 원인 분석
유입 채널별 구매 성과 차이	마케팅 예산 배분 검토

※ 실제 분석 결과를 확인한 뒤 구체적인 수치와 인사이트를 추가할 예정입니다.

9. Weekly Retrospective
What I Learned
새롭게 익힌 SQL 개념:
가장 중요하다고 생각한 개념:
실무에서 활용할 수 있다고 생각한 분석:
Challenges
가장 어려웠던 SQL 문제:
해결 과정:
추가로 학습이 필요한 부분:
Business Perspective
분석을 통해 발견한 점:
비즈니스 관점에서의 의미:
추가로 분석해 보고 싶은 내용:
10. Next Step
Week 3. Business Metrics & Customer Analytics

2주차에서 학습한 CTE와 Window Function을 바탕으로 다음 단계에서는 이커머스 핵심 지표를 분석할 예정입니다.

주요 학습 예정 내용:

RFM Analysis
Customer Segmentation
Repurchase Rate
Cohort Analysis
Retention Rate
Month-over-Month Growth
Moving Average

Next Goal: SQL을 활용하여 고객 행동을 분석하고, 데이터 기반의 비즈니스 의사결정에 필요한 인사이트를 도출하는 역량을 발전시키는 것을 목표로 합니다.

Project: E-commerce SQL Data Analysis
Week: 02
Database: Google BigQuery
Focus: JOIN / CTE / Subquery / Window Function