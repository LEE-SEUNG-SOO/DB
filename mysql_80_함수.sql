/***********************************************
	내장 함수 : 숫자함수, 문자함수, 날짜함수
    호출되는 위치 - [컬럼명], [조건절의 컬럼명]
***********************************************/

-- [ 숫자함수 ]
-- 함수 실습을 위한 테이블 : DUAL 테이블
-- (1) abs(숫자) : 절대값
SELECT abs(100), abs(-100) 
FROM DUAL;

-- (2) floor(숫자) : 소수점 버리기
-- (2) truncate(숫자, 자리수) : 자리수 이후 소수점 버리기(반올림 X)
SELECT floor(123.456), truncate(123.456,2)
FROM DUAL;

-- 사원 테이블의 sys 부서 사원들이 보너스(급여의 25%)컬럼을 추가하여 조회
-- 보너스 컬럼은 소수점 1자리로 출력
SELECT emp_id, emp_name, eng_name, 
		gender, hire_date, retire_date, 
		dept_id, phone, email, 
        salary, truncate((salary * 0.25), 1) AS bonus
FROM employee
WHERE dept_id = 'SYS';

-- (3) RAND() : 임의의 수를 난수로 발생시키는 함수( 0~1 사이의 난수 생성)
SELECT RAND() 
FROM DUAL;

-- 정수 3자리 난수생성
SELECT floor(RAND()*1000) as number
FROM DUAL;

-- 정수 4자리 난수 발생, 소수점 2자리까지
SELECT truncate((RAND()*10000),2) as number
FROM DUAL;

-- (4) mod(숫자, 나누는 수) : 나머지를 구하는 함수
SELECT mod(123,2) AS odd, mod(124,2) AS even
FROM DUAL;

-- 3자리 수를 랜덤으로 발생시켜, 2로 나눈후 홀수, 짝수 구분.
SELECT mod(floor(rand()*1000),2) AS result
FROM DUAL;

-- [ 문자함수 ]
-- (1) concat(문자열1, 문자열2 ...) : 문자열을 합치는 함수(+)
SELECT concat('안녕하세요.'," 홍길동", ' 입니다.') AS str
FROM DUAL;

-- 사번, 사원명, S0001(홍길동)으로 조회
SELECT emp_id AS 사번, emp_name AS 사원명, concat(emp_id, '(', emp_name,')') AS 사원명2
FROM employee;

-- 사번, 사원명, 영어이름, 입사일, 폰번호, 급여를 조회
-- 영어이름의 출력 형식을 홍길동/hong 형식으로 출력
-- 영어이름이 NULL인 경우에는 smith를 기본값으로 설정한다.
SELECT emp_id, emp_name, concat(emp_name, '/', IFNULL(eng_name, "SMITH")) as eng_name, hire_date, phone, salary
FROM employee;

-- (2) substring(문자열, 위치, 갯수) : 문자열 추출 < 위치는 1번부터 시작. >, 공백도 한문자로 처리
SELECT substring('대한민국 홍길동', 1, 4), -- 대한민국
		substring('대한민국 홍길동', 1, 5), -- 대한민국 
		substring('대한민국 홍길동', 1, 6), -- 대한민국 홍
		substring('대한민국 홍길동', 6, 3) -- 홍길동
FROM DUAL;

-- 사원 테이블의 사번, 사원명, 입사년도, 입사월, 입사일, 급여를 출력
SELECT emp_id, emp_name, hire_date,
		substring(hire_date, 1, 4) as year,
		substring(hire_date, 6, 2) as month,
		substring(hire_date, 9, 2) as day,        
        salary
FROM employee;

-- 2015년도에 입사한 모든 사원 조회
SELECT *
FROM employee
WHERE substring(hire_date, 1, 4) = '2015';

-- 2018년도에 입사한 모든 사원 조회
SELECT *
FROM employee
WHERE substring(hire_date, 1, 4) = '2018'
AND dept_id = "SYS";

-- (3) left(문자열, 갯수), right(문자열, 갯수) : 왼쪽, 오른쪽 기준 갯수만큼 추출
SELECT curdate() as curdate,
		left(curdate(), 4) as year, -- year
		substring(curdate(),6,2) as month, -- month 
		right(curdate(), 2) as day -- day
FROM dual;

-- 2018년도에 입사한 모든 사원 조회
SELECT *
FROM employee
WHERE left(hire_date, 4) = '2018';

-- 2015년부터 2017년 사이에 입사한 모든 사원 조회
SELECT *
FROM employee
WHERE left(hire_date, 4) 
BETWEEN '2015' AND '2017';

-- 사원번호, 사원명, 입사일, 폰번호, 급여를 조회
-- 폰번호는 마지막 4자리만 출력
SELECT emp_id, emp_name, hire_date, right(phone,4), salary
FROM employee;

-- (4) upper(문자열), lower(문자열) : 문자열을 대문자, 소문자로 치환
SELECT upper('WelCome to MySql') as upper,
		lower('WelCome to MySql') as lower
FROM dual;

-- 사번, 사원명, 영어이름, 부서명, 이메일, 급여를 조회
-- 영어이름은 전체 대문자, 부서아이디는 소문자, 이메일은 대문자
SELECT emp_id, emp_name, 
		upper(eng_name) as eng_name, 
		lower(dept_id) as dept_id, 
		upper(email) as email, salary
FROM employee;

-- (5) trim() : 양옆 공백 제거
SELECT trim('       대한민국') as t1,
		trim('대한      민국') as t2,
		trim('대한민국      ') as t3,
		trim('   대한 민국  ') as t4
FROM dual;

-- (6) format(문자열, 소수점자리) : 문자열 포맷 ,구분
SELECT 
	format(123456, 0) as format1,
    format('123456', 0) as format2
FROM dual;

-- 사번, 사원명, 입사일, 폰번호, 급여, 보너스(급여의 20%)
-- 급여, 보너스는 소수점 없이 3자리 ,로 구분
-- 급여가 NULL인 경우 기본값 0
-- 2015년부터 2017년 사이에 입사한 사원 출력
-- 사번기준 내림차순
SELECT emp_id, 
	emp_name, 
	hire_date, 
    phone, 
    format(IFNULL(salary,0),0) as salary, 
    format((IFNULL(salary,0)*0.2),0) as bonus
FROM employee
WHERE left(hire_date,4) BETWEEN '2015' AND '2017'
ORDER BY emp_id desc;

-- [ 날짜함수 ]
-- curdate() : 현재 날짜(년, 월, 일)
-- sysdate(), now() : 현재 날짜(년, 월, 일, 시, 분, 초)
SELECT
	curdate(),
	sysdate(),
	now()
FROM dual;

-- [ 형변환 함수 ]
-- cast(변환하고자하는 값 as 데이터타입)
-- convert(변환하고자하는 값 as 데이터타입) : old버전
SELECT 1234 as number,
		cast(1234 as char) as string
FROM dual;

SELECT '1234' as string,
		cast('1234' as signed integer) as num
FROM dual;

SELECT 
	'20250723' as String,
	cast('20250723' as date) as date
FROM dual;

SELECT now() as date,
	cast(now() as char) as cast_string,
    cast(cast(now() as char) as date) as cast_date,
    cast(cast(now() as char) as datetime) as cast_datetime,
    cast(curdate() as datetime) as cast_curdate
FROM dual;

SELECT '12345' as string,
		cast('12345' as signed integer) as cast_int, -- 부호있는 정수
      	cast('12345' as unsigned integer) as cast_unsigned, -- 부호없는 정수
       	cast('12345' as decimal(10,2)) as cast_decimal -- 소수
FROM dual;

-- [ 문자 치환 함수 ]
-- replace(문자열, 치환대상문자, 치환문자)
SELECT '홍-길-동' as old,
		replace('홍-길-동', '-', '/') as new
FROM dual;

-- 사번, 사원명, 입사일, 퇴사일, 부서명, 폰번호, 급여
-- 입사일, 퇴사일 출력은 '-'을 '/'로 치환하여 출력
-- 재직중인 사원은 현재날짜를 출력
-- 급여 출력시 3자리 ,로 구분
SELECT emp_id, 
		emp_name,
        replace(hire_date, '-', '/') as hire_date,
        replace(IFNULL(retire_date, curdate()), '-', '/') as retire_date,
        dept_id,
        phone,
        format(salary,0) as salary
FROM employee;

-- '20150101' ~ '20171231' 형식으로 입력된 날짜를 기준으로 해당 날짜 사이에 입사한 사원들을 모두 조회
-- 모든 mysql 데이터베이스에서 적용가능한 형태로 작성
SELECT *
FROM employee
WHERE hire_date
BETWEEN cast('20150101' as date) 
AND cast('20171231' as date);

/*********************************************************
	그룹 함수 :  sum(), avg(), min(), max(), count()..
    group by - 그룹함수를 적용하기 위한 그룹핑 컬럼 정의
    having - 그룹함수에서 사용하는 조건절
    ※※※ 그룹함수는 그룹핑이 가능한 반복된 데이터를 가진 컬럼과 사용 권장 ※※※
*********************************************************/
-- (1) sum(숫자) : 총합을 구하는 함수
-- 사원들 전체의 급여 총액을 조회, 3자리 구분, '만원' 추가
SELECT concat(format(sum(salary),0),'만원')as total_salary
FROM employee;

-- 일반 컬럼과 그룹함수를 같이 사용하는건 불가(group by 사용시 가능)
SELECT emp_id, sum(salary)
FROM employee;

-- (2) avg(숫자) : 평균을 구하는 함수
-- 사원들 전체의 급여 평균을 조회, 3자리 구분, 앞에 '$'표시 추가
-- 소수점 버림
SELECT concat('$',format(avg(salary),0)) as avg
FROM employee;

-- 정보시스템(SYS) 부서 전체의 급여 총액과 평균을 조회
SELECT concat(format(sum(salary),0),'만원') as sum, 
		concat(format(avg(salary),0),'만원') as avg
FROM employee
WHERE dept_id = 'SYS';

-- (3) max(숫자) : 최대값을 구하는 함수
-- 가장 높은 급여를 받는 사원의 급여를 조회
SELECT concat(format(max(salary),0),'만원') as max
FROM employee;

-- (4) min(숫자) : 최소값을 구하는 함수
-- 가장 적은 급여를 받는 사원의 급여를 조회
SELECT concat(format(min(salary),0),'만원') as max
FROM employee;

-- 사원들의 총급여, 평균급여, 최대급여, 최소금여를 조회
SELECT format(sum(salary),0) as sum,
		format(avg(salary),0) as avg,
		format(max(salary),0) as max,
		format(min(salary),0) as min	
FROM employee;

-- (5) count(컬럼) : 조건에 맞는 데이터의 row 수를 구하는 함수(null은 갯수로 취급하지 않는다)
-- 전체 row수
SELECT count(*) as count
FROM employee;

-- 급여 컬럼의 row count
SELECT count(salary)
FROM employee;

-- 재직중인 사원과 퇴사한 사원의 row count
SELECT count(*) as 총사원,
		count(retire_date) as 퇴직자,
        count(*) - count(retire_date) as 재직자
FROM employee;

-- '2015'년도에 입사한 입사자 수
SELECT count(*) as 입사자수
FROM employee
WHERE left(hire_date, 4) = '2015';

-- 정보시스템(sys) 부서의 사원수
SELECT count(*) as 사원수
FROM employee
WHERE dept_id = 'SYS';

-- 가장 빠른 입사자, 가장 늦은 입사자 : min, max
SELECT min(hire_date) as min,
		max(hire_date) as max
FROM employee;

-- 가장 빨리 입사한 사람의 정보 조회
SELECT *
FROM employee
WHERE hire_date = min(hire_date); -- having 사용

-- [ group by ] : 그룹함수와 일반 컬럼을 함께 사용할 수 있도록 해주는 것
-- ~~별 그룹핑이 가능한 컬럼으로 쿼리를 실행
-- 부서별 총급여, 평균급여, 사원수, 최대급여, 최소급여 조회
SELECT dept_id, 
		sum(salary) as sum,
        avg(salary) as avg,
        count(*) as count,
        max(salary) as max,
        min(salary) as min
FROM employee
GROUP BY dept_id;

-- 연도별 총급여, 평균급여, 사원수, 최대급여, 최소급여 조회
SELECT LEFT(hire_date, 4) AS hire_date,
		FORMAT(sum(salary), 0) AS sum,
		FORMAT(avg(salary), 0) AS avg,
        FORMAT(max(salary), 0) AS max,
        FORMAT(min(salary), 0) AS min,
        FORMAT(count(emp_id), 0) AS count
FROM employee
GROUP BY LEFT(hire_date,4);

-- [ having 조건절 ] : 그룹함수를 적용한 결과에 조건을 추가
-- 부서별 총급여, 평균 급여를 조회
-- 부서의 총 급여가 30000 이상인 부서만 출력
-- 급여가 null인 경우 제외
SELECT dept_id,
		format(sum(salary),0) as sum,
        format(avg(salary),0) as avg
FROM employee
WHERE salary IS NOT NULL
GROUP BY dept_id
HAVING sum(salary) >= 30000;

-- 연도별 총급여, 평균급여, 사원수, 최대급여, 최소급여 조회
-- 총 급여가 30000 이상인 연도만 조회
SELECT LEFT(hire_date, 4) AS hire_date,
		FORMAT(sum(salary), 0) AS sum,
		FORMAT(avg(salary), 0) AS avg,
        FORMAT(max(salary), 0) AS max,
        FORMAT(min(salary), 0) AS min,
        FORMAT(count(emp_id), 0) AS count
FROM employee
where salary IS NOT NULL
GROUP BY LEFT(hire_date,4)
HAVING sum(salary) >= 30000;

-- rollup 함수 : 리포팅을 위한 함수
-- 부서별 사원수, 총급여, 평균급여
SELECT dept_id,
		count(dept_id) as count,
        format(sum(IFNULL(salary,0)), 0) as sum,
        format(avg(IFNULL(salary,0)), 0) as avg		
FROM employee
GROUP BY dept_id with rollup;

-- rollup한 결과의 부서아이디를 추가
SELECT if(grouping(dept_id),'총합계', ifnull(dept_id, '-')) as dept_id,
		count(dept_id) as count,
        format(sum(IFNULL(salary,0)), 0) as sum,
        format(avg(IFNULL(salary,0)), 0) as avg		
FROM employee
GROUP BY dept_id with rollup;

-- limit : 출력갯수 제한 함수
SELECT *
FROM employee
limit 3;

-- 급여 기준 5순위 출력
SELECT *
FROM employee
ORDER BY salary DESC
limit 5
;