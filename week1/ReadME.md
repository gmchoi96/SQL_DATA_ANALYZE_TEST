# E-commerce SQL Analysis | Week 1
가상의 이커머스 데이터를 활용한 SQL 기초 및 데이터 분석 실습 프로젝트
### 1. Project Overview

본 프로젝트는 이커머스 서비스의 가상 데이터를 활용하여 SQL을 학습하고, 데이터 조회부터 다중 테이블 분석까지 데이터 분석의 기본 역량을 익히기 위해 진행한 프로젝트입니다.

Python을 활용해 가상의 이커머스 데이터를 생성하고, 총 25개의 SQL 실습 문제를 통해 데이터 조회, 집계, 필터링, JOIN 및 매출 분석을 수행했습니다.

Project Objectives
- SQL 기본 문법 및 데이터 조회 능력 습득
- GROUP BY와 HAVING을 활용한 데이터 집계
- JOIN을 활용한 다중 테이블 분석
- NULL 데이터 처리 및 예외 상황 이해
- 이커머스 데이터를 활용한 매출 분석 경험

### 2. Project Information
항목	내용
프로젝트	E-commerce SQL Analysis
학습 주차	Week 1
데이터 도메인	E-commerce
데이터베이스	Google BigQuery
데이터 생성	Python
쿼리 언어	SQL (BigQuery Standard SQL)
실습 문제	총 25개
데이터 유형	가상 데이터
### 3. Dataset Description

실제 기업의 고객 및 거래 정보가 아닌 학습 목적으로 **Chat-GPT**를 통해 생성한 가상 데이터입니다.

## Table Description

| Table | Rows | Description |
|---|---:|---|
| users | 500 | 사용자 정보 |
| orders | 2,500 | 주문 정보 |
| products | 40 | 상품 정보 |
| order_items | 주문별 상품 | 주문 상품 상세 정보 |


Data Characteristics
- 사용자 500명 중 70명은 주문 이력이 없는 구조
- 성별 및 유입 채널 컬럼에 일부 NULL 데이터 포함
- 주문 상태는 DELIVERED, SHIPPED, CANCELLED로 구분
- 주문별 상품 수량은 1~3개
- 주문당 상품 종류는 1~4개
- 주문 금액과 주문 상품 상세 금액의 합계 일치 여부 검증
### 4. Tech Stack
Category	Technology
Programming	Python
Database	Google BigQuery
Query Language	SQL
Data Format	CSV
Development Environment	Google Colab
Version Control	GitHub
### 5. SQL Practice


총 25개의 SQL 문제를 난이도별로 구성하여 실습했습니다.
| Level | Topics | Problems |
|---|---|---:|
| Level 1 | SELECT, WHERE, ORDER BY, DISTINCT | 1~7 |
| Level 2 | COUNT, SUM, AVG, GROUP BY, HAVING | 8~16 |
| Level 3 | COALESCE, NULL, LEFT JOIN, JOIN | 17~21 |
| Level 4 | DATE_TRUNC, Subquery, Multi-table JOIN | 22~25 |

Key SQL Skills
- SELECT / WHERE / ORDER BY / LIMIT
- DISTINCT / IS NULL / COALESCE
- COUNT / SUM / AVG
- GROUP BY / HAVING
- CASE WHEN
- INNER JOIN / LEFT JOIN
- Subquery
- DATE_TRUNC
- COUNT DISTINCT
### 6. Analysis Tasks
1) 사용자 분석
전체 사용자 수 확인
유입 채널별 사용자 수 집계
주문 이력이 없는 사용자 추출
2) 주문 분석
주문 상태별 주문 건수 확인
사용자별 주문 횟수 집계
평균 주문 금액 계산
3) 상품 분석
카테고리별 평균 상품 가격
상품별 총 주문 수량
카테고리별 매출 집계
4) 매출 분석
월별 배송 완료 주문 금액 집계
사용자별 배송 완료 주문 금액 분석
유입 채널별 배송 완료 매출 분석
### 7. Data Validation

데이터 생성 후 다음 항목을 검증했습니다.

사용자 데이터 500건 확인
주문 데이터 2,500건 확인
상품 데이터 40건 확인
주요 ID의 중복 여부 확인
외래키 참조 관계 확인
주문 금액과 주문 상품 금액 합계 일치 여부 확인

##### ! Note: 본 프로젝트에 사용된 모든 데이터는 SQL 학습을 위해 생성한 가상 데이터이며 실제 기업의 거래 데이터가 아닙니다.
