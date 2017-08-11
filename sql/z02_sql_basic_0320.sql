/*
 DDL(Data Definition Language) : 테이블 구조 생성, 변경 및 삭제하는 것을 말한다.
 	1. CREATE TABLE : 테이블 구조를 신규로 생성.
	2.  ALTER TABLE : 테이블 구조를 변경
	3.  DROP TABLE  : 테이블 구조를 삭제(컬럼 삭제).
	4. 기타 : TRUNCATE, RENAME 테이블명 
*/

/* 1. CREATE TABLE : 테이블 생성
		CREATE TABLE 테이블 명(컬럼명 DATA-TYPE 기타제약조건,...);

 	DATA-TYPE
		1)   CHAR(size)   : 고정형 문자열 데이터타입. 문자열의 크기가 고정된 것으로 큰 데이터가 들어올 수 없지만 작은 데이터는 지정된 크기로 저장된다.
		
		2) VARCHAR2(size) : 가변형 문자열 데이터타입. 데이터의 최대크기를 지정하면 그 데이터 이하의 크기가 가변적으로 저장될 수 있다.
		
		3) NUMBER(전체자리수, 소수점이하자리수) : 숫자를 저장하는 데이터타입.
			- NUMBER(숫자), NUMBER(숫자, 0) : 정수형 데이터타입
			- NUMBER(숫자, 2) : 실수형 데이터타입. 소수점 둘째짜리까지 저장가능
		
		4) DATE : 날짜를 저장하는 데이터타입.(날짜+시분초)
		
		5) LONG : 4000byte 이상의 문자열을 저장 할때 활용되는 데이터타입. 최고치 2GB
		
		6) LOB : 2G 이하 바이너리(모든 데이터저장가능) 데이터 저장.	
*/

-- 1. 테이블 생성하기. CREATE TABLE 테이블명(컬럼명 DATA-TYPE,..); 
-- ex) emp10이라는 테이블에 컬럼명 empno 정수형, ename 가변문자형, sal 실수형으로 테이블을 만드려고 한다.
	create table emp10( empno number(4), ename varchar2(20), sal number(7,2) );

/*
 과제2. (homework 2)
 login인 하는 화면을 만들고 id와 password를 체크하고, 다음화면에서 'id@@@님 환영합니다. 남은 point는 @@@입니다.' 라는 내용이 나타난다고 한다.
 이에 필요로 하는 테이블과 테이블 구조를 만드세요.
*/	

-- 2. 테이블 구조 변경하기

-- 1) ADD COLUMN : 테이블의 새로운 컬럼을 추가 할 때. ALTER TABLE 테이블명 ADD(컬럼명 DATA-TYPE)
-- ex) emp10에 job이라는 이름으로 가변형문자(9)가 들어가는 컬럼을 새로 추가하려고 한다.
	alter table emp10 add(job varchar2(9));
	select * from emp10;

-- 확인예제. emp10에 날짜형 데이터 creatdate, 실수형데이터(7,3)을 추가하려고 한다.
	alter table emp10 add( createdate date, sal12 number(7,3) );
	select * from emp10;
	
-- 2) MODIFY COLUNN : 테이블 컬럼 수정. ALTER TABLE 테이블명 MODIFY(변경할 컬럼명 DATA-TYPE);	
-- ex) emp10의 sal12를 문자형으로 변경하고자 한다.
	alter table emp10 modify( sal12 varchar2(10) );
	select * from emp10;

/*
 테이블에서 DATA=TYPE 변경의 한계
 	1. 해당 컬럼의 데이터가 있는 경우
		- 다른 DATA-TYPE으로 변경 불가.
		- 같은 DATA-TYPE이라도 현재 크기보다 작은 데이터 크기로의 변경은 불가. 컬럼안에 'HIMAN'이라는 데이터가 있을 때 5이하로 줄일수가 없다.
	2. 해당 컬럼의 데이터가 없는 경우
		- DATA-TYPE과 크기 변경이 자유롭다.
*/

-- 3) DROP COLUMN : 테이블의 컬럼 삭제. ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
-- ex) emp10의 sal12 컬럼을 삭제하려고 한다.
	alter table emp10 drop column sal12;
	select * from emp10; 

-- 3. RENAME  
-- 1) 테이블 명 변경.	ALTER TABLE 기존테이블명 RENAME TO 새로운테이블명;
-- ex) 테이블명 emp10을 empxp10으로 변경하려고 한다.
	alter table emp10 rename to empxp10;
	select * from empxp10;

-- 2) 컬럼명 변경.	ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 새로운 컬럼명;
-- ex) empxp10에서 createdate컬럼을 hiredate로 변경 처리
	alter table empxp10 rename column createdate to hiredate;
	select * from empxp10;

-- 확인예제. dept01 테이블을 dept10Exp라는 테이블로 변경하고 컬럼명 loc를 location으로 변경하시오. 크기는 13에서 25로.
	alter table dept01 rename to dept10Exp;
	select * from dept10Exp;
	alter table dept10Exp rename column loc to location;
	alter table dept10Exp modify( location varchar2(25) );
	select * from dept10Exp;

-- 4. DDL로 데이터의 모든 내용 삭제. TRUNCATE TABLE 테이블명
-- ex) dept10Exp에 있는 모든 데이터를 DDL로 삭제 처리.
	truncate table dept10Exp;
	select * from dept10Exp;

-- 5. 테이블 구조 자체를 삭제. DROP TABLE 테이블명;
-- ex) dept10Exp 테이블을 완전히 삭제하세요.
	drop table dept10Exp;
	select * from dept10Exp;

/*
 DROP
 테이블의 정의 자체를 완전히 삭제함
 ROLLBACK 불가능
 테이블이 사용했던 Storage를 모두 Release

 DELETE
 데이터만 삭제
 Commit 이전에는 ROLLBACK이 가능
 데이터를 모두 DELETE해도 사용했던 Storage는 Release 되지 않음

 TRUNCATE
 테이블을 최초 생성된 초기상태로 만듬
 ROLLBACK 불가능
 테이블이 사용했던 Storage 중 최초 테이블 생성시 할당된 Storage만 남기고 Release

*/								