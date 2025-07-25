/*******************************************************************
	DDL(Data Definition Language) : 생성, 수정, 삭제 - 테이블기준
	DML : C(insert), R(select), U(update), D(delete)
*******************************************************************/
-- 모든 테이블 목록
show tables;

-- [테이블 생성]
-- 형식 : CREATE TABLE [테이블명] (
-- 컬럼명1 데이터타입(크기),
-- 컬럼명2 데이터타입(크기),
-- ...
-- );
-- 데이터 타입 : 정수형(int, long), 실수형(flaot, double)
-- 			  문자형(char, varchar, longtext)
-- 			  이진데이터(longblob), 날짜(date, datetime)
-- char(고정형 문자)    : 크기가 메모리에 고정되는 형식
-- varchar(가변형 문자) : 실제 저장되는 데이터 크기에 따라 메모리가 변경되는 형식
-- longtext : 문장형태로 다수의 문자열을 저장하는 형식
-- longblob : 이진데이터 타입의 데이터, 동영상 등 데이터를 저장
-- date : 년, 월, 일 -> curdate()
-- datetime : 년, 월, 일, 시, 분, 초 -> sysdate(), now()
desc employee;

-- emp 테이블 생성
-- emp_id : (char, 4)
-- ename : (varchar, 10)
-- gender : (char, 1)
-- hire_date : (datetime)
-- salary : (int)
show tables;
CREATE TABLE emp(
	emp_id		char(4),
    ename		varchar(10),
    gender		char(1),
    hire_date	datetime,
    salary		int
);

select * from information_schema.tables
where table_schema = 'hrdb2019';

-- [테이블 삭제]
-- 형식 : DROP TABLE [테이블명];
DROP TABLE emp;
show tables;

-- [테이블 복제]
-- 형식 : CREATE TABLE [테이블명]
-- 		AS [SQL 쿼리]
-- 제약사항(PRIMARYKEY, UNIQUEKEY등등)은 설정되지 않는다.
-- employee 테이블을 복제하여 emp테이블 생성

SELECT * FROM employee;
CREATE TABLE emp AS
SELECT * FROM employee;

desc emp;
desc employee;

select * from
emp;

-- 2016년도에 입사한 사원의 정보를 복제 : employee_2016
CREATE TABLE employee_2016
AS
SELECT * FROM employee WHERE LEFT(hire_date,4) = 2016;

SELECT * FROM
employee_2016;

DROP TABLE employee_2016;

/*******************************************************************
	데이터 생성(insert : C)
    형식 : INSERT INTO [테이블명] ({컬럼리스트..})
			VALUES(데이터1, 데이터2, 데이터3 ...);    
*******************************************************************/
show tables;

SELECT * from employee;

INSERT INTO emp (ename, emp_id, gender, hire_date, salary)
 values ('S001','홍길동','m', sysdate(), 1000);

INSERT INTO emp (ename, emp_id, gender, salary, hire_date)
 values ('S001','홍길동','m', 1000, null);

INSERT INTO emp (emp_id)
 values ('S002');

select * from emp;


-- [테이블 절삭 : 테이블의 데이터만 영구 삭제]
-- 형식 : truncate table [];
truncate table emp;
select * from emp;

CREATE TABLE emp(
	emp_id		char(4)		not null,
    ename		varchar(10) not null,
    gender		char(1)		not null,
    hire_date	datetime,
    salary		int
);

desc emp;
INSERT INTO emp (emp_id, ename, gender, hire_date, salary)
	VALUES('S101', '홍길동', 'm', now(), 1000);

select * from emp;

INSERT INTO emp 
	VALUES('s003','김유신', 'm', curdate(), 3000);

INSERT INTO emp 
	VALUES('s002', null, 'm', sysdate(), 2000);


-- [ 자동 행번호 생성 : auto_increment ]
-- 정수형으로 번호를 생성하여 저장한다. PK, UNIQUE 제약으로 설정된 컬럼에 주로 사용
create table emp2(
	emp_id		int			auto_increment		primary key,	-- unique + not null
    ename		varchar(10)	not null,
    gender		char(1)		not null,
    hire_date	date,
    salary		int	
);

show tables;
desc emp2;
select * from emp2;

insert into emp2 (ename, gender, hire_date, salary)
	values('홍길동', 'm', sysdate(), 1000);
select * from emp2;

/*******************************************************************
	테이블 변경 : ALTER TABLE
    형식 : ALTER TABLE [테이블명] 
			add column [신규컬럼명, 데이터타입] -- null 허용, 해당 테이블의 가장 마지막에 추가
            modify column [변경컬럼명, 데이터타입] -- 크기고려
            drop column [삭제컬럼명]
*******************************************************************/
show tables;

select * from emp;

-- phone(char, 13) 컬럼 추가, null 허용
alter table emp
	add column phone char(13);

desc emp;

-- phone 컬럼 삭제
alter table emp
	drop column phone;

select * from emp;

insert into emp
	values('s004', '홍', 'F',sysdate(), 2000, '010-1234-5679');

-- phone 컬럼 크기 조절
-- char(13) -> char(10)
alter table emp
	modify column phone char(10); -- 저장된 데이터보다 작은 값을 설정했기 때문에 에러

-- char(13) -> char(15)
alter table emp
	modify column phone char(15); -- 저장된 데이터보다 큰 값을 설정했기 때문에 에러 X
    
-- char(15) -> char(13)
alter table emp
	modify column phone char(13); -- 저장된 데이터보다 큰 값을 설정했기 때문에 에러 X

desc emp;

/*******************************************************************
	데이터 수정(update : U)
    형식 : UPDATE [테이블명]
			 SET [컬럼명] = 데이터값
             WHERE [조건절 ~ ]
	※※ set sql_safe_updates = 0 or 1; 디폴트 1		mySQL전용
		0 : 업데이트 가능
        1 : 업데이트 불가
*******************************************************************/

select * from emp;
set sql_safe_updates = 0; -- 업데이트 모드 해제

-- 홍길동의 급여를 6000으로 수정
UPDATE emp
	SET salary = 6000
    WHERE emp_id = 'S101';


-- 김유신의 입사날짜를 '20210725'으로 수정
UPDATE emp
	SET hire_date = cast('20210725' as datetime)
    WHERE emp_id = 'S003';
    
select * from emp;

-- emp2 테이블에 retire_date 컬럼 추가 : date
-- 기존 데이터에는 현재 날짜로 업데이트
-- 업데이트 완료 후 retire_date컬럼은 not null 설정 변경
select * from emp2;

-- retire_date 컬럼 추가
alter table emp2
	add column (retire_date date);

-- 기존 데이터 현재 날짜로 업데이트
UPDATE emp2
	SET retire_date = now()
    WHERE retire_date IS NULL;

-- retire_date컬럼 not null로 설정 변경
alter table emp2
	modify column retire_date date not null;
    
desc emp2;

/*******************************************************************
	데이터 삭제(DELETE : D)
    형식 : DELETE [테이블명]
             WHERE [조건절 ~ ]
	※※ set sql_safe_updates = 0 or 1; 디폴트 1		mySQL전용
		0 : 업데이트 가능
        1 : 업데이트 불가
*******************************************************************/

select * from emp;

-- 이순신 사원 삭제
DELETE FROM emp
	WHERE emp_id = 's002';

-- 홍 사원 삭제
DELETE FROM emp
	WHERE emp_id = 's004';
