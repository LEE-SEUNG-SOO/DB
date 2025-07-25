/*******************************************************************
	조인(JOIN) : 두개 이상의 테이블을 연동해서 sql 실행
    ERD(Entity Relationship Diagream) : 데이터베이스 구조도(설계도)
    - 데이터 모델링 : 정규화 과정
    
    ** ANSI SQL : 데이터베이스 시스템들의 표준 SQL
    조인(JOIN) 종류
    (1) CROSS JOIN(합집합) : 테이블의 데이터 전체를 조인 - 테이블A * 테이블B
    (2) INNER JOIN(교집합) : 두 개이상의 테이블을 조인 연결 고리를 통해 조인 실행
    (3) OUTER JOIN : (INNER JOIN + 선택한 테이블의 조인 제외 ROW 포함)
    (4) SELF JOIN : 한 테이블을 두개 테이블처럼 조인 실행
    
*******************************************************************/
SELECT *
FROM employee;

-- [ CROSS JOIN ]
-- employee(20), department(7)
SELECT *
FROM employee, department;

SELECT count(*)
FROM employee 
CROSS JOIN department;

-- 사원(20), 부서(7), 휴가테이블(102) cross join
SELECT count(*)
FROM employee, department, vacation;
SELECT count(*)
FROM employee 
CROSS JOIN department 
CROSS JOIN vacation;

-- [ INNER JOIN ]
SELECT *
FROM employee, department
WHERE employee.dept_id = department.dept_id
ORDER BY emp_id;

-- ansi
SELECT *
FROM employee 
INNER JOIN department
	ON employee.dept_id = department.dept_id
ORDER BY emp_id;

-- 사원, 부서, 본부 테이블 3개를 INNER JOIN
SELECT *
FROM employee e, department d, unit u
WHERE e.dept_id = d.dept_id
AND d.unit_id = u.unit_id
ORDER BY e.emp_id;

-- ANSI
SELECT *
FROM employee e 
INNER JOIN department d 
	ON e.dept_id = d.dept_id
INNER JOIN unit u
	ON d.unit_id = u.unit_id
ORDER BY e.emp_id;

-- 사원, 부서, 본부, 휴가 테이블 4개를 INNER JOIN
SELECT *
FROM employee e, department d, unit u, vacation v
WHERE e.dept_id = d.dept_id
AND d.unit_id = u.unit_id
AND e.emp_id = v.emp_id;

SELECT *
FROM employee e
INNER JOIN department d
	ON e.dept_id = d.dept_id
INNER JOIN unit u
	ON d.unit_id = u.unit_id
INNER JOIN vacation v
	ON e.emp_id = v.emp_id
ORDER BY e.emp_id;

-- 사원들의 사번, 사원명, 부서아이디, 부서명, 입사일, 급여를 조회
SELECT e.emp_id, e.emp_name, e.dept_id, d.dept_name, e.hire_date, e.salary
FROM employee e, department d
WHERE e.dept_id = d.dept_id;

-- 영업부에 속한 사원들의 사번, 사원명, 입사일, 퇴사일, 폰번호, 급여, 부서아이디, 부서명 조회
SELECT e.emp_id, e.emp_name, e.hire_date, e.retire_date, e.phone, e.salary, d.dept_id, d.dept_name
FROM employee e, department d
WHERE e.dept_id = d.dept_id
AND d.dept_name = '영업';

-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들의 내역을 조회
SELECT *
FROM employee e, department d, vacation v
WHERE d.dept_name = '인사'
AND e.dept_id = d.dept_id
AND e.emp_id = v.emp_id
ORDER BY e.emp_id;

-- 영업부서 사원의 사원명 폰번호 부서명 휴가 사용이유 조회
SELECT e.emp_name, e.phone, d.dept_name, v.reason
FROM employee e, department d, vacation v
WHERE d.dept_name = '영업'
AND v.reason = '두통'
AND e.dept_id = d.dept_id
AND e.emp_id = v.emp_id
ORDER BY e.emp_id;

-- 2014년부터 2016년까지 입사한 사원들중 퇴사하지않은 사원들의
-- 사원아이디, 사원명, 부서명, 입사일, 소속본부를 조회
-- 소속본부 기준으로 오름차순
SELECT e.emp_id, e.emp_name, d.dept_name, e.hire_date, u.unit_name
FROM employee e, department d, unit u
WHERE LEFT(e.hire_date,4) BETWEEN '2014' AND '2016'
AND e.retire_date IS NULL
AND e.dept_id = d.dept_id
AND d.unit_id = u.unit_id
ORDER BY u.unit_name ASC;

-- 부서별 총 급여, 평균급여, 총휴가사용일수를 조회
SELECT  d.dept_name,
		e.dept_id,
		format(sum(e.salary),0) as sum, -- 휴가사용이 여러개기 때문에 합계가 크게 나옴
		format(avg(e.salary),0) as avg, -- 휴가사용이 여러개기 때문에 합계가 크게 나옴
        sum(v.duration) as duration
FROM employee e, department d, vacation v
WHERE e.emp_id = v.emp_id
AND e.dept_id = d.dept_id
GROUP BY e.dept_id;

-- 본부별, 부서의 휴가사용일수
SELECT  u.unit_name,
		d.dept_name,
		e.dept_id,
		sum(v.duration) as duration
FROM employee e, department d, vacation v, unit u
WHERE e.emp_id = v.emp_id
AND e.dept_id = d.dept_id
AND u.unit_id = d.unit_id
GROUP BY u.unit_name, e.dept_id;

-- [ OUTER JOIN ]
-- INNER JOIN + 조인에서 제외된 row(테이블별 지정)
-- 오라클 형식의 OUTER JOIN은 사용불가, ANSI형식만 사용가능
-- SELECT [컬럼명] FROM [테이블명1] 
-- LEFT/RIGHT OUTER JOIN [테이블명2], ...
-- ON [테이블명1.조인컬럼 = 테이블명2.조인컬럼]

-- ** 오라클 방식 OUTER JOIN 사용불가
-- SELECT * FROM table1 t1, table2 t2
-- WHERE t1.a(+) = t2.a

-- 모든 부서의 부서아이디, 부서명, 본부명 조회
SELECT d.dept_id, 
	d.dept_name, 
	IFNULL(d.unit_id,"협의중") as unit_id, 
	d.start_date, 
	IFNULL(u.unit_name,"협의중") as unit_name
FROM department d
LEFT OUTER JOIN unit u
	ON d.unit_id = u.unit_id
ORDER BY d.unit_id;

-- SELECT *
-- FROM department d, unit u
-- WHERE d.unit_id(+) = u.unit_id -- 오라클 방식 X
-- ORDER BY d.unit_id;

-- 본부별, 부서의 휴가사용일수
-- 부서누락없이 출력
SELECT  u.unit_name,
		d.dept_name,
		e.dept_id,
		sum(v.duration) as duration
FROM employee e
LEFT OUTER JOIN vacation v
	ON e.emp_id = v.emp_id
LEFT OUTER JOIN department d
	ON e.dept_id = d.dept_id
LEFT OUTER JOIN unit u
	ON u.unit_id = d.unit_id
GROUP BY u.unit_name, e.dept_id
ORDER BY u.unit_name;

SELECT u.unit_name, d.dept_name, count(v.duration)
from employee e
LEFT OUTER JOIN vacation v
	ON e.emp_id = v.emp_id
RIGHT OUTER JOIN department d
	ON e.dept_id = d.dept_id
LEFT OUTER JOIN unit u
	ON d.unit_id = u.unit_id
GROUP BY u.unit_name, d.dept_name
ORDER BY u.unit_name;

-- 2017년도~2018년도 입사한 사원들의 사원명 입사일 연봉 부서명
-- 퇴사자 제외
-- 소속본부 모두 조회
SELECT *
FROM employee e
INNER JOIN department d
	ON e.dept_id = d.dept_id
LEFT OUTER JOIN unit u
	ON u.unit_id = d.unit_id
WHERE LEFT(e.hire_date,4) BETWEEN 2017 AND 2018
AND e.retire_date IS NULL;

-- [ SELF JOIN ] : 자기 자신의 테이블과 조인
-- SELF JOIN은 서브쿼리 형태로 실행하는 경우가 많다.
-- SELECT [컬럼명] FROM [테이블명1 t1], [테이블2 t2] where [t1.컬럼명] = [t2.컬럼명]
-- 사원테이블을 SELF JOIN
SELECT e1.emp_id, e1.emp_name, e2.emp_id, e2.emp_name
FROM employee e1, employee e2
WHERE e1.emp_id = e2.emp_id;

SELECT emp_id, emp_name
FROM employee
WHERE emp_id = (SELECT emp_id FROM employee WHERE emp_name = "홍길동");



/*******************************************************************
-- 서버 환경에 따라 위,아래 쿼리중 효율적인 쿼리 사용.
-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들의 내역을 조회
SELECT *
FROM employee e, department d, vacation v
WHERE d.dept_name = '인사'
AND e.dept_id = d.dept_id
AND e.emp_id = v.emp_id
ORDER BY e.emp_id;

-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들의 내역을 조회
SELECT *
FROM employee e, department d, vacation v
WHERE e.dept_id = d.dept_id
AND e.emp_id = v.emp_id
AND d.dept_name = '인사'
ORDER BY e.emp_id;

*******************************************************************/

/*******************************************************************
	서브쿼리(SubQuery) : 메인 쿼리에 다른 쿼리를 추가하여 실행하는 방식
    형식 : SELECT [컬럼명 : (스칼라서브쿼리)] < 사용하지 말것
			FROM [테이블 : (인라인뷰)] < 별칭 반드시 필요
            WHERE [조건 (서브쿼리)]    
*******************************************************************/

-- [스칼라 서브쿼리]
-- 정보시스템 부서명의 사원들을 모두 조회
-- 사번, 사원명, 부서아이디, 부서명(부서테이블), 급여, 폰번호
SELECT emp_id,
		emp_name,
        dept_id,
        (SELECT dept_name FROM department WHERE dept_name = '정보시스템') AS dept_name, -- 권장X
        phone,
        salary
FROM employee
WHERE dept_id = 
(SELECT dept_id
FROM department
WHERE dept_name = '정보시스템');

-- [서브쿼리 : 단일행]
-- 정보시스템 부서명의 사원들을 모두 조회
SELECT *
FROM employee
WHERE dept_id = 
	(SELECT dept_id
		FROM department
		WHERE dept_name = '정보시스템');

-- 홍길동사원이 속한 부서명을 조회
-- '='로 조건절 비교하는 경우 :: 단일행 서브쿼리
SELECT *
FROM department
WHERE dept_id =
	(SELECT dept_id 
		FROM employee
		WHERE emp_name = '홍길동');

-- 홍길동 사원의 휴가사용 내역을 조회
SELECT *
FROM vacation
WHERE emp_id = 
	(SELECT emp_id
		FROM employee 
		WHERE emp_name ='홍길동');

-- 제 3본부에 속한 모든 부서를 조회
SELECT *
FROM department
WHERE unit_id =
	(SELECT unit_id
		FROM unit
		WHERE unit_name = '제3본부');

-- 급여가 가장 높은 사원의 정보 조회
SELECT *
FROM employee
WHERE salary = 
	(SELECT MAX(salary) AS salary
		FROM employee);

-- 가장 빨리 입사한 사원의 정보 조회
SELECT *
FROM employee
WHERE hire_date =
	(SELECT MIN(hire_date) AS hire_date
		FROM employee);

-- [서브 쿼리 : 다중행 - IN]
-- 제3본부에 속한 모든 사원 정보 조회
SELECT *
FROM employee
WHERE dept_id IN
	(SELECT dept_id
		FROM department
		WHERE unit_id =
			(SELECT unit_id
				FROM unit
				WHERE unit_name = '제3본부')
		);

-- 제3본부에 속한 모든 사원들의 휴가 사용 내역 조회
SELECT *
FROM vacation
WHERE emp_id IN
	(SELECT emp_id
		FROM employee
		WHERE dept_id IN
			(SELECT dept_id
				FROM department
				WHERE unit_id =
					(SELECT unit_id
						FROM unit
						WHERE unit_name = '제3본부')
				));
                
-- [ 인라인뷰 : 메인쿼리의 테이블 자리에 들어가는 서브쿼리 ]
-- 휴가를 사용한 사원정보만 사원별 휴가사용 일수를 그룹핑하여
-- 사원아이디, 사원명, 입사일, 연봉, 휴가사용일수를 조회
SELECT e.emp_id, e.emp_name, e.hire_date, e.salary, v.duration
FROM employee e, (SELECT emp_id, count(*) AS count , sum(duration) AS duration
					FROM vacation
					GROUP BY emp_id) v -- 별칭 반드시 필요
WHERE e.emp_id = v.emp_id;

-- 전체 사원별 휴가사용 일수를 그룹핑하여
-- 사원아이디, 사원명, 입사일, 연봉, 휴가사용일수를 조회
-- 휴가를 사용하지 않은 사원은 기본값 0
-- 사용 일수 기준 내림차순 정렬
SELECT e.emp_id, e.emp_name, e.hire_date, e.salary, IFNULL(v.duration,0) as duration
FROM employee e
LEFT OUTER JOIN (SELECT emp_id, count(*) AS count , sum(duration) AS duration
					FROM vacation
					GROUP BY emp_id) v -- 별칭 반드시 필요
ON e.emp_id = v.emp_id
ORDER BY duration DESC;

-- 2016 ~ 2017년도 입사한 사원들의 정보 출력
-- vacation 테이블을 인라인뷰 형태로 조인하여 휴가 사용 내역 출력
SELECT *
FROM (SELECT emp_id, emp_name, gender, hire_date, dept_id, phone, email, salary
		FROM employee
		WHERE LEFT(hire_date,4) 
		BETWEEN 2016 AND 2017) e, vacation v
WHERE e.emp_id = v.emp_id;

-- 부서별 총급여, 평균급여를 구하여 총 급여가 30000이상인 부서 조회
-- employee 테이블을 인라인뷰 형태로 조인
-- 사원아이디, 사원명, 급여, 부서아이디, 부서명, 부서별 총급여, 평균급여 출력
SELECT e.emp_id, e.emp_name, e.salary, e.dept_id, d.dept_name, t.sum, t.avg
FROM employee e, department d, 
		(SELECT dept_id, sum(salary) AS sum, avg(salary) AS avg
					FROM employee
					GROUP BY dept_id
                    HAVING sum >= 30000) t
WHERE e.dept_id = d.dept_id 
AND e.dept_id = t.dept_id;


/*******************************************************************
	테이블 결과 합치기 : union, union all
    형식 : 쿼리1 실행 결과 union 쿼리2 실행 결과
	형식 : 쿼리1 실행 결과 union all 쿼리2 실행 결과
    ※※ 실행결과 컬럼이 동일(컬럼명, 데이터타입)
    union = 중복 제거
    union all = 중복 허용
*******************************************************************/
-- 영업부, 정보시스템 부서의 사원 아이디, 사원명, 급여, 부서아이디 조회
-- union 중복 불가
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name ='영업')
union 
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name ='정보시스템')
union
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name ='영업');

-- union all 중복 허용
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name ='영업')
union all
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name ='정보시스템')
union all
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name ='영업');

/*******************************************************************
	논리적인 테이블 : VIEW(뷰), SQL을 실행하여 생성된 결과를 가상테이블로 정의
    뷰 생성 : CREATE VIEW [view 이름]
			AS [SQL쿼리];
	뷰 삭제 : DROP VIEW [view 이름]
	※※ 뷰 생성시 권한을 할당 받아야한다.
*******************************************************************/
SELECT *
FROM information_schema.views
WHERE TABLE_SCHEMA = 'hrdb2019';

-- 부서 총급여가 30000 이상인 테이블 생성
CREATE VIEW view_salary_sum
as SELECT e.emp_id, e.emp_name, e.salary, e.dept_id, d.dept_name, t.sum, t.avg
FROM employee e, department d, 
		(SELECT dept_id, sum(salary) AS sum, avg(salary) AS avg
					FROM employee
					GROUP BY dept_id
                    HAVING sum >= 30000) t
WHERE e.dept_id = d.dept_id 
AND e.dept_id = t.dept_id;

-- view_salary_sum 실행
SELECT *
FROM view_salary_sum;

-- view_salary_sum 삭제
DROP VIEW view_salary_sum;

-- view 확인
SELECT *
FROM information_schema.views
WHERE TABLE_SCHEMA = 'hrdb2019';

