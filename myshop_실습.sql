/******************************************************
		실습 데이터베이스 연결 : myshop2019
		실습 내용 - 기본적인 데이터 조회 	 
******************************************************/
show databases;
use market_db;
show tables;

-- Q01) customer 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc customer;

-- Q02) employee 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc employee;

-- Q03) product 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc product;

-- Q04) order_header 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc order_header;

-- Q05) order_detail 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
desc order_detail;

-- Q06) 모든 고객의 아이디, 이름, 지역, 성별, 이메일, 전화번호를 조회하세요.
SELECT customer_id, customer_name, city, gender, email, phone
FROM customer;

-- Q07) 모든 직원의 이름, 사원번호, 성별, 입사일, 전화번호를 조회하세요.
SELECT employee_name, employee_id, gender, hire_date, phone
FROM employee;

-- Q08) 이름이 '홍길동'인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE customer_name = "홍길동";

-- Q09) 여자 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE gender = 'F';

-- Q10) '울산' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE city = "울산";

-- Q11) 포인트가 500,000 이상인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE point >= 500000;

-- Q12) 이름에 공백이 들어간 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE customer_name like '% %';

-- Q13) 전화번호가 010으로 시작하지 않는 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE phone not like'010%';

-- Q14) 포인트가 500,000 이상 '서울' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE point >= 500000
AND city = "서울";

-- Q15) 포인트가 500,000 이상인 '서울' 이외 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE point >= 500000
AND city != "서울";

-- Q16) 포인트가 400,000 이상인 '서울' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE point >= 400000
AND city = "서울"
AND gender = 'M';

-- Q17) '강릉' 또는 '원주' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE city = "강릉"
or city = '원주';

-- Q18) '서울' 또는 '부산' 또는 '제주' 또는 '인천' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE city IN("서울", "부산", "제주", "인천");

-- Q19) 포인트가 400,000 이상, 500,000 이하인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, point
FROM customer
WHERE point BETWEEN 400000 AND 500000;

-- Q20) 1990년에 출생한 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, birth_date, point
FROM customer
WHERE birth_date like '1990%';

-- Q21) 1990년에 출생한 여자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, birth_date, point
FROM customer
WHERE birth_date like '1990%'
AND gender = 'f';

-- Q22) 1990년에 출생한 '대구' 또는 '경주' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
SELECT customer_name, customer_id, gender, city, phone, birth_date, point
FROM customer
WHERE birth_date like '1990%'
AND city IN('대구','경주')
AND gender = 'M';

-- Q23) 1990년에 출생한 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
--      단, 홍길동(gildong) 형태로 이름과 아이디를 묶어서 조회하세요.
SELECT distinct customer_name, customer_id, gender, city, phone, birth_date, point
FROM customer
WHERE birth_date like '1990%'
AND gender = 'M';

-- Q24) 근무중인 직원의 이름, 사원번호, 성별, 전화번호, 입사일를 조회하세요.
SELECT employee_name, employee_id, gender, phone, hire_date
FROM employee
WHERE retire_date IS NULL;

-- Q25) 근무중인 남자 직원의 이름, 사원번호, 성별, 전화번호, 입사일를 조회하세요.
SELECT employee_name, employee_id, gender, phone, hire_date
FROM employee
WHERE gender = 'M';


-- Q26) 퇴사한 직원의 이름, 사원번호, 성별, 전화번호, 입사일, 퇴사일를 조회하세요.
SELECT employee_name, employee_id, gender, phone, hire_date
FROM employee
WHERE retire_date IS NOT NULL;

-- Q28) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 고객아이디를 기준으로 오름차순 정렬해서 조회하세요.
SELECT order_id, customer_id, employee_id, order_date, sub_total, delivery_fee, total_due
FROM order_header
WHERE order_date BETWEEN "2019-01-01" AND "2019-01-07"
ORDER BY customer_id ASC;

-- Q29) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 전체금액을 기준으로 내림차순 정렬해서 조회하세요.
SELECT order_id, customer_id, employee_id, order_date, sub_total, delivery_fee, total_due
FROM order_header
WHERE order_date BETWEEN "2019-01-01" AND "2019-01-07"
ORDER BY total_due;

-- Q30) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 사원번호를 기준으로 오름차순, 같은 사원번호는 주문일시를 기준으로 내림차순 정렬해서 조회하세요.
SELECT order_id, customer_id, employee_id, order_date, sub_total, delivery_fee, total_due
FROM order_header
WHERE order_date BETWEEN "2019-01-01" AND "2019-01-07"
ORDER BY order_id ASC, order_date DESC;

