/**
	테이블 조인 : 기본 SQL 방식, ANSI SQL
*/

use myshop2019;

-- Q01) 전체금액이 8,500,000 이상인 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 전체금액을 조회하세요.
SELECT order_id, customer_id, employee_id, order_date, total_due
FROM order_header
WHERE total_due >= 8500000;

-- Q02) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 고객이름도 같이 조회되게 수정하세요.
SELECT c.customer_name, o.order_id, o.customer_id, o.employee_id, o.order_date, o.total_due
FROM customer c, order_header o
WHERE total_due >= 8500000
AND c.customer_id = o.customer_id;

-- Q03) Q01 쿼리를 복사해 붙여 넣은 후 직원이름도 같이 조회되게 수정하세요.
SELECT o.order_id, o.customer_id, o.employee_id, e.employee_name, o.order_date, o.total_due
FROM order_header o, employee e
WHERE total_due >= 8500000
AND o.employee_id = e.employee_id;

-- Q04) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 고객이름, 직원이름도 같이 조회되게 수정하세요.
SELECT c.customer_name, o.order_id, o.customer_id, o.employee_id, e.employee_name, o.order_date, o.total_due
FROM customer c, order_header o, employee e
WHERE total_due >= 8500000
AND c.customer_id = o.customer_id
AND o.employee_id = e.employee_id;

-- Q05) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 전체금액이 8,500,000 이상인 '서울' 지역 고객만 조회되게 수정하세요.
SELECT c.customer_name, c.city, o.order_id, o.customer_id, o.employee_id, e.employee_name, o.order_date, o.total_due
FROM customer c, order_header o, employee e
WHERE total_due >= 8500000
AND c.city = '서울'
AND c.customer_id = o.customer_id
AND o.employee_id = e.employee_id;

-- Q06) 위에서 작성한 쿼리문을 복사해 붙여 넣은 후 전체금액이 8,500,000 이상인 '서울' 지역 '남자' 고객만 조회되게 수정하세요.
SELECT c.customer_name, c.city, c.gender, o.order_id, o.customer_id, o.employee_id, e.employee_name, o.order_date, o.total_due
FROM customer c, order_header o, employee e
WHERE total_due >= 8500000
AND c.city = '서울'
AND c.gender = 'M'
AND c.customer_id = o.customer_id
AND o.employee_id = e.employee_id;

-- Q07) 주문수량이 30개 이상인 주문의 주문번호, 상품코드, 주문수량, 단가, 지불금액을 조회하세요.
SELECT order_id, product_id, order_qty, unit_price, discount, line_total
FROM order_detail
WHERE order_qty >= 30;

-- Q08) 위에서 작성한 쿼리문을 복사해서 붙여 넣은 후 상품이름도 같이 조회되도록 수정하세요.
SELECT o.order_id, o.product_id, p.product_name, o.order_qty, o.unit_price, o.discount, o.line_total
FROM order_detail o, product p
WHERE o.order_qty >= 30
AND o.product_id = p.product_id;

-- Q09) 상품코드, 상품이름, 소분류아이디를 조회하세요.
SELECT *
FROM product;



-- Q10) 위에서 작성한 쿼리문을 복사해서 붙여 넣은 후 소분류이름, 대분류아이디가 조회되게 수정하세요.
SELECT p.product_id, s.sub_category_id, s.sub_category_name, s.category_id
FROM product p, sub_category s
WHERE p.sub_category_id = s.sub_category_id;

-- Q11) 다정한 사원이 2019년에 주문한 상품명을 모두 출력해주세요.
SELECT e.employee_name, oh.order_date ,p.product_name
FROM order_header oh, employee e , order_detail od, product p
WHERE oh.employee_id = e.employee_id
AND oh.order_id = od.order_id
AND od.product_id = p.product_id
AND LEFT(oh.order_date,4) = 2019
AND e.employee_name = '다정한';

-- Q12) 청소기를 구입한 고객아이디, 사원번호, 주문번호, 주문일시를 조회하세요.
select od.order_id, -- 주문번호
		e.employee_id, -- 사원번호
		e.employee_name, -- 사원이름
        c.customer_id, -- 고객아이디
		c.customer_name, -- 고객이름
        od.product_id, -- 제품번호
		p.product_name, -- 제품이름
        oh.order_date -- 주문일시
from order_detail od, order_header oh, product p, customer c, employee e
WHERE od.order_id = oh.order_id
AND p.product_id = od.product_id
AND oh.customer_id = c.customer_id
AND oh.employee_id = e.employee_id
AND p.product_name LIKE '%청소기%';