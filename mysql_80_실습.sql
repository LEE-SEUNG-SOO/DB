/**
* MySQL 실습
* MySQL : 정형 데이터를 저장하는 데이터베이스
* SQL 문법을 사용하여 데이터를 CRUD 한다.
*	C(Create) : insert 생성
*   R(Read)   : select 읽기
*   U(Update) : update 수정
*   D(Delete) : delete 삭제
* DML에 대한 CRUD 명령어를 잘 사용할 수 있어야한다.
* SQL은 대소문자 구분을 하지 않는다. 보통 소문자로 작성
* snake case 방식의 네이밍 규칙을 가진다.


* SQL은 크게 DDL, DML, DCL, DTL로 구분된다.
*	DDL(Data Definition Language) : 데이터 정의어
*		데이터를 저장하기 위한 공간을 생성하고 논리적으로 정의하는 언어
*        > create, alter, truncate, drop ..
*	DML(Data Manipulation Language) : 데이터 조작어
*		데이터를 CRUD하는 명령어
*		 > insert, select, update, delete
*	DCL(Data Control Language) : 데이터 제어어
*		데이터에 대한 권한과 보안을 정의하는 언어
*		 > grant, revoke ..
*	DTL(Data Transaction Language) : 트랜잭션 제어어
*		데이터베이스의 처리 작업 단위인 트랜잭션을 관리하는 언어
*		 > commit, rollback, save ..
*/

/* 반드시 기억해야할것 */ -- 워크벤치 실행시 마다 실행
	show databases; -- 모든 데이터 베이스 조회
    use hrdb2019; -- 사용할 데이터 베이스 오픈
	select database(); -- 데이터 베이스 선택
    show tables; -- 데이터 베이스의 모든 테이블 조회

/**************************************
	DESC(DESCRIBE) : 테이블 구조 확인
**************************************/
 show tables;
 desc employee;
 
/**************************************
	SELECT : 테이블 내용 조회
    형식 > SELECT [컬럼명] FROM 테이블명;
**************************************/
 SELECT emp_id, emp_name FROM employee;
 SELECT * FROM employee;
 SELECT emp_name, gender, hire_date FROM employee;
 
 -- 사원테이블의 사번, 사원명, 성별, 입사일, 급여를 조회
 SELECT emp_id, emp_name, gender, hire_date, salary 
 FROM employee;

 -- 부서테이블의 모든 정보를 조회
 SELECT * 
 FROM department;

-- AS : 컬럼명 별칭 부여(생략가능)
-- 형식> SELECT [컬럼명 AS 별칭] FROM 테이블명;
-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여 컬럼을 한글 컬럼명으로 출력
SELECT emp_id AS 사번, emp_name AS "사 원 명", gender AS 성별, hire_date 입사일, salary 급여
FROM employee;

-- 사원테이블의 사번 : ID, 사원명 : NAME,  성별 : GENDER, 입사일 : HDATE, 급여 : SALARY 로 출력
SELECT emp_id ID, emp_name NAME, GENDER, hire_date HADTE, SALARY
FROM employee;

-- 사원테이블의 사번, 사원명, 부서명, 폰번호, 이메일, 급여, 보너스(급여*10%)를 조회
-- 기존의 컬럼에 연산을 수행하여 새로운 컬럼을 생성할 수 있다.
SELECT * FROM employee;

SELECT emp_id, emp_name, dept_id, phone, email, salary, salary*0.1 as bonus
FROM employee;

-- 현재 날짜를 조회
-- dual 임시 테이블
SELECT curdate() as cur_date FROM dual;

/**************************************
	SELECT : 테이블 내용 상세 조회
    형식 > SELECT [컬럼명]
			FROM [테이블명]
			WHERE [조건절];
**************************************/

-- 정주고 사원의 정보를 조회
SELECT *
FROM employee
WHERE emp_name = '정주고'; -- "정주고" 또한 사용가능

-- SYS 부서에 속한 모든 사원을 조회
SELECT *
FROM employee
WHERE dept_id = "SYS";

-- 사번이 S0005인 사원의 사원명, 성별, 입사일, 부서아이디, 이메일, 급여를 조회
SELECT emp_name, gender, hire_date, dept_id, email,salary 
FROM employee
WHERE emp_id = "S0005";

-- SYS부서에 속한 모든 사원들을 조회, 단 출력되는 EMP_ID 컬럼은 '사원번호' 별칭으로 조회
SELECT emp_id as "사원번호", emp_name, eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary
FROM employee
WHERE dept_id = "SYS";

-- EMP_NAME 컬럼은 '사원명' 별칭으로 조회
SELECT emp_id as "사원번호", emp_name as "사원명", eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary
FROM employee
WHERE dept_id = "SYS";

-- WHERE 조건절 컬럼을 별칭으로 사용가능한가?   결과 : X
-- 사원명이 홍길동인 사원을 별칭으로 조회
SELECT emp_id as "사원번호", emp_name as "사원명", eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary
FROM employee
-- WHERE 사원명 = "홍길동"; < X
WHERE emp_name = "홍길동";

-- 전략기획(STG) 부서의 모든 사원들의 사번, 사원명, 입사일, 급여 조회
SELECT * 
FROM DEPARTMENT;

SELECT emp_id, emp_name, hire_date, salary
FROM employee
WHERE dept_id = 'STG'; 

-- 입사일이 2014년 8월 1일인 사원 조회
SELECT *
FROM employee
WHERE hire_date = '2014-08-01'; -- DATA 타입은 표현은 문자열처럼, 처리는 숫자
-- WHERE hire_date = '20140801'; < 가능은 하다.
-- WHERE hire_date = 20140801; < 가능은 하다.
-- WHERE hire_date = 2014/08/01; < 가능은 하다.

-- 급여가 5000인 사원 조회
SELECT *
FROM employee
WHERE salary = 5000;

-- 성별이 남자인 사원들을 조회
SELECT *
FROM employee
WHERE gender = 'M';

-- 성별이 여자인 사원들을 조회
SELECT *
FROM employee
WHERE gender = 'F';

-- NULL : 아직 정의되지 않은 미지수
-- 숫자에서는 가장 큰 수로 인식된다. 
-- 논리적인 의미를 포함하고 있으므로 등호(=)로는 검색이 불가, IS 키워드로 검색 가능

-- 급여가 NULL인 값을 가진 사원들을 조회
SELECT *
FROM employee
WHERE salary IS NULL;
-- WHERE salary = NULL; < 검색시 아무것도 나오지않음

-- 영어이름이 정해지지 않은 사원들을 조회
SELECT *
FROM employee
WHERE eng_name IS NULL;

-- 퇴사하지 않은 사원들을 조회
SELECT *
FROM employee
WHERE retire_date IS NULL;

-- 퇴사하지 않은 사원들의 보너스 칼럼(급여*20%)을 추가하여 조회
SELECT emp_id, emp_name, eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary, salary*0.2 AS bonus
FROM employee
WHERE retire_date IS NULL;

-- 퇴사한 사원들의 사번, 사원명, 이메일, 폰번호, 급여를 조회
SELECT emp_id, emp_name, email, phone, salary, retire_date
FROM employee
WHERE retire_date IS NOT NULL;

-- IFNULL 함수 : NULL값을 다른 값으로 대체하는 방법
-- 형식> IFNULL(컬럼명, 대체값)
-- STG부서에 속한 사원들의 정보를 조회, 단 급여가 NULL인 사원은 0으로 치환
SELECT emp_id, emp_name, dept_id, email, phone, IFNULL(salary,0) as salary
FROM employee
WHERE dept_id = 'STG';

-- 사원 전체 테이블의 내용을 조회, 단 영어 이름이 정해지지않은 사원들은 'SMITH' 이름으로 치환
SELECT emp_id, emp_name, IFNULL(eng_name,'SMITH') as eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary
FROM employee;

-- MKT 부서의 사원들을 조회, 재직중인 사원들의 RETIRE_DATE 컬럼은 현재 날짜로 치환
SELECT emp_id, emp_name, eng_name, gender, hire_date, IFNULL(retire_date, CURDATE()) as retire_date, dept_id, phone, email, salary
FROM employee
WHERE dept_id = 'MKT';

/**************************************
	DISTINCT : 중복된 데이터를 배제하고 조회
    형식 > SELECT DISTINCT [컬럼명]
			FROM [테이블명]
			WHERE [조건절];
**************************************/

SELECT DISTINCT dept_id
FROM employee; 

-- 주의 두 항목일 경우 두항목다 일치할경우 배제
-- ex) a b, a a 중복 X -> 둘다 출력
SELECT DISTINCT dept_id, EMP_ID
FROM employee; 
-- dept_id와 gender둘다 중복된 값들은 배제
SELECT DISTINCT dept_id, gender
FROM employee; 

/***********************************************
	ORDER BY : 데이터 정렬
    형식 > SELECT [컬럼명]
			FROM [테이블명]
			WHERE [조건절]
            ORDER BY [컬럼명, 컬럼명2...] ASC(오름차순) or DESC(내림차순)
***********************************************/

-- 급여를 기준으로 오름차순 정렬
SELECT *
FROM employee
ORDER BY salary ASC;

-- 급여를 기준으로 내림차순 정렬
SELECT *
FROM employee
ORDER BY salary DESC;

-- 급여와 성별을 기준으로 오름차순
SELECT *
FROM employee
ORDER BY salary, gender DESC;

-- ENG_NAME이 NULL인 사람들을 입사일 기준으로 내림차순
SELECT *
FROM employee
WHERE eng_name IS NULL
ORDER BY hire_date DESC;

-- 퇴직한 사람들을 급여 기준으로 내림차순, SALARY컬럼을 급여로 치환
-- 급여 별칭으로 ORDER BY가 가능한가?  결과 : O
SELECT emp_id, emp_name, eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary as 급여
FROM employee
WHERE retire_date IS NOT NULL
ORDER BY 급여 DESC;

-- 정보시스템(SYS) 부서 사원들 중 일사일이 빠른순서, 급여를 많이 받는 순서로 정렬
SELECT *
FROM employee
WHERE dept_id = 'SYS'
ORDER BY hire_date ASC, salary ASC;

/***********************************************
	WHERE 조건절 + 비교연산자 : 특정 범위 혹은 데이터 검색
    형식 > SELECT [컬럼명]
			FROM [테이블명]
			WHERE [비교연산자 조건절]
***********************************************/

-- 급여가 5000이상인 사원들을 조회, 급여를 오름차순 정렬
SELECT * 
FROM employee
WHERE salary >= 5000
ORDER BY salary;

-- 입사일이 2017-01-01 이후 입사한 사원들을 조회
SELECT * 
FROM employee
WHERE hire_date >= '2017-01-01'
ORDER BY salary;

-- 입사일이 2017-01-01 이후거나, 급여가 6000 이상인 사람들을 조회
-- ~~이거나 ~~또는 : OR
SELECT * 
FROM employee
WHERE hire_date >= '2017-01-01'
OR salary >= 6000;

-- 입사일이 2017-01-01 이후이고, 급여가 6000 이상인 사람들을 조회
-- ~~이고 : AND
SELECT * 
FROM employee
WHERE hire_date >= '2017-01-01'
AND salary >= 6000;

-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 사원 조회
-- 부서 기준 오름차순 정렬
SELECT * 
FROM employee
WHERE hire_date >= '2015-01-01'
AND hire_date <= '2017-12-31'
ORDER BY dept_id ASC;

-- 급여가 6000이상 8000이하인 사원들을 조회
SELECT * 
FROM employee
WHERE salary >= 6000
AND salary <= 8000;

-- MKT 부서의 사원들의 사번, 사원명, 입사일, 이메일, 급여, 보너스(급여의 20%) 조회
-- 급여가 NULL인 사원의 보너스는 기본 50
-- 보너스가 1000이상인 사원조회
-- 보너스 기준 내림차순
SELECT emp_id, emp_name, hire_date, email, salary, IFNULL(salary*0.2, 50) AS bonus
FROM employee
WHERE DEPT_ID = 'MKT'
AND salary*0.2 >= 1000
ORDER by bonus DESC;

-- 사원명이 '일지매','오삼식','김삼순' 인 사원들을 조회
SELECT *
FROM employee
WHERE emp_name = '일지매'
OR emp_name = '오삼식'
OR emp_name = '김삼순';

/***********************************************
	논리곱 : BETWEEN ~ AND
    형식 > SELECT [컬럼명]
			FROM [테이블명]
			WHERE [컬럼명] BETWEEN 값1 AND 값2
            
    논리합 : IN
    형식 > SELECT [컬럼명]
			FROM [테이블명]
			WHERE [컬럼명] IN (값1, 값2...)
***********************************************/

-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 사원 조회
-- 부서 기준 오름차순 정렬
SELECT * 
FROM employee
WHERE hire_date 
BETWEEN '2015-01-01'
AND '2017-12-31'
ORDER BY dept_id ASC;

-- 급여가 6000이상 8000이하인 사원들을 조회
SELECT * 
FROM employee
WHERE salary
BETWEEN 6000
AND 8000;

-- 사원명이 '일지매','오삼식','김삼순' 인 사원들을 조회
SELECT *
FROM employee
WHERE emp_name IN('일지매', '오삼식', '김삼순');

-- 부서아이디가 MKT, SYS, STG에 속한 모든 사원 조회
SELECT *
FROM employee
WHERE dept_id IN('MKT', 'SYS', 'STG')
ORDER BY dept_id;

/***********************************************
	특정 문자열 검색 : 와일드 문자(%, _), LIKE 연산자
				% : 전체 글자 , _한글자
    형식 > SELECT [컬럼명]
			FROM [테이블명]
			WHERE [컬럼명] LIKE '검색어';
***********************************************/

-- '한'씨 성을 가진 모든 사원을 조회
SELECT *
FROM employee
WHERE emp_name LIKE '한%';
-- WHERE emp_name LIKE '한__'; < 한XX 3글자의 값을 가진 데이터 검색

-- 영어 이름이 f로 시작하는 사원을 조회
SELECT *
FROM employee
WHERE eng_name LIKE 'f%';

-- 이메일 이름 중 두번째 자리에 'a'가 들어가는 사원 조회
SELECT *
FROM employee
WHERE email LIKE '_a%';

-- 이메일 아이디가 4자인 모든 사원을 조회
SELECT *
FROM employee
WHERE email LIKE '____@%';




