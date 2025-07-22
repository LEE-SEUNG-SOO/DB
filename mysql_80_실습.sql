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














