/*
 데이터 무결성 제약 조건
 	- 데이터의 신뢰성을 확보하기 위하여 테이블 생성시, 컬럼 속성값으로 지정하는 것을 말한다.(중복값이나 null값 방지 등...)

 제약조건 5가지
 	1.   NOT NULL  : null값을 허용하지 않는다.
	2.   UNIQUE    : 중복값의 입력을 허용하지 않는다.
	3. PRIMARY KEY : NOT NULL과 UNIQUE를 동시에 적용.
	4. FOREIGN KEY : 참조되는 테이블의 컬럼값이 존재해야 입력이 가능.
	5.   CHECK     : 저장 가능한 데이터값의 범위나 조건을 지정하여 설정한 값만을 입력 허용.	
*/

-- 1. NOT NULL : 사원 테이블에 사원의 정보를 저장할 때 반드시 사원번호와 사원이름이 저장되어야 입력이 되도록 처리하고자 할 경우.
-- 			형태 : CREATE TABLE 테이블명(컬럼명 DATA-TYPE NOT NULL, .....);
	create table emp02( empno number(4) not null, ename VARCHAR2(10) not null, job VARCHAR2(9), deptno NUMBER(4) );
	select * from emp02;
	
	insert into emp02(job,deptno) values('대리',30);  
	/*empno와 ename에 값이 입력되지 않아 오류 발생*/
	
	insert into emp02 values(1000,'홍길동','대리',30);
	select * from emp02;
	
	insert into emp02 values(null,'홍길동','대리',30);
	/*empno에 null값이 입력되어 오류 발생*/
	insert into emp02 values(1002,'','대리',30); 
	/*empno에 공백값이 입력되어 오류 발생 공백은 null값으로 처리*/
	
-- 2. UNIQUE : D데이터 입력에 있어서, 중복인 데이터 입력을 허용하지 않는 것을 말한다.
-- ex) emp03 테이블의 컬럼 empno에 unique제약조건을 넣어 동일한 사번이 입력되지 않도록 처리하세요.
	create table emp03( empno number(4) unique, ename VARCHAR2(25), mgr number(4) );	
	insert into emp03 values(1000,'himan1',null);	
	insert into emp03 values(1001,'himan2',7788);	
	insert into emp03 values(1002,null,null);	
	insert into emp03 values(1003,'himan3',8888);
	insert into emp03 values(1000,'himan4',8888);  /*empno '1000'값이 이미 입력이 되었기에 중복처리가 되어 오류 발생*/
	select * from emp03;	

-- 3. PRIMARY KEY : NOT NULL(반드시 데이터 입력)과 UNIQUE(중복값 불가)의 조건을 모두 가지고 있는 것. 주로 메인테이블의 key값을 설정할 때 활용된다.	
-- ex) MEMBER테이블에 MEMBERID값을 PRIMARY KEY로 설정하세요.
	create table member( memberid VARCHAR(20) primary key, pass VARCHAR(20), name VARCHAR(50), loc VARCHAR(100) );
	insert into member values('1111', '7777', '홍길동', '서울강남');
	insert into member values('1112', '7777', '홍길동', '서울강남');
	
	insert into member values('1111', '7777', '홍길동', '서울강남');  
	/*memberid값이 1111이 이미 있기 때문에 오류 발생*/
	
	insert into member values(null, '7777', '홍길동', '서울강남'); 
	/* memberid값에 null값이 있기 때문에 오류 발생*/
	select * from member; 

-- 4. FOREIGN KEY : 참조되는 테이블에 반드시 값을 입력해야 하는 경우를 말한다.
	CREATE TABLE DEPT_REF(
   DEPTNO   NUMBER (2) PRIMARY KEY,
   DNAME    VARCHAR2 (14),
   LOC      VARCHAR2 (13) );	
	
	CREATE TABLE EMP_REF(
   EMPNO      NUMBER (4) PRIMARY KEY,
   ENAME      VARCHAR2 (10),
   JOB        VARCHAR2 (9),
   MGR        NUMBER (4),
   HIREDATE   DATE,
   SAL        NUMBER (7, 2),
   COMM       NUMBER (7, 2),
   DEPTNO     NUMBER (2) REFERENCES DEPT_REF(DEPTNO) );
   
-- 컬럼명 DATA-TYPE REFERENCES 참조할테이블명(참조할컬럼명)
	insert into DEPT_REF values(10,'인사','서울');
	insert into DEPT_REF values(20,'총무','경기');
	select * from DEPT_REF;
	
	insert into EMP_REF(empno, ename, deptno) values(1000,'홍길동',10);
	select * from EMP_REF;
	
	insert into EMP_REF(empno, ename, deptno) values(1001,'신길동',30); 
	/*deptno 20은 테이블 DEPT_REF에 없기 때문에 오류 발생*/
	insert into EMP_REF(empno, ename, deptno) values(1001,'신길동',20);
	select * from EMP_REF; 
	
/* 과제3. (homework 3)
참조키 관계에 있는 테이블 구성하기
 
 메인테이블 student_main(id, pass, name) : 아이디, 패스워드, 이름
 서브테이블 student_point(id, subject, point) : 아이디, 과목, 점수
 메인테이블과 서브테이블을 id로 foreign key 관계를 설정하고 메인테이블에 데이터가 있어야만 서브테이블에 입력할 수 있게끔 처리
*/	

-- 5. CHECK : 입력되는 값을 체크하여 설정된 값 이외의 값이 들어오지 못하게 조건을 설정하는 것을 말한다.
-- ex) 사원테이블에 gender라는 컬럼을 구성하고 여기에 'M', 'F' 두개의 값 외에는 입력되지 목하게 처리하세요.
	create table emp04( empno number(4), ename VARCHAR2(10), gender VARCHAR2(1) check(gender in('M', 'F')) );
	insert into emp04 values(9999,'홍길동', 'M');
	select * from emp04;
	
	insert into emp04 values(9998,'신길동', 'D');
	/* check 설정으로 gender컬럼에 'M', 'F'만 입력가능하도록 설정했기 때문에 오류 발생 */
	insert into emp04 values(9998,'신길동', 'F');
	select * from emp04;