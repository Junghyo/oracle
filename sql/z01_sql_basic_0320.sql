/*
 1. DML : Data Maniplulation Language
 	1) SELECT : 조회시 사용.
	2) INSERT : 데이터 입력시 사용.     INSERT INTO 테이블명 VALUES(데이터1, 데이터2, 데이터3);
*/
	select * from dept;
/*
 테이블 복사하기
 CREATE TABLE 새로운 테이블명 AS SELECT * FROM 복사할 테이블명;
*/
	create table dept01 as select * from dept;
	select * from dept01;

-- 데이터 입력1.  INSERT INTO DEPT01 VALUES(컬럼1데이터, '컬럼2데이터', '컬럼3데이터');	
	insert into dept01 values(50, '총무부','서울');
	select * from dept01;	
-- 이대로 하면 다시 껏다가 키면 입력된 데이터가 삭제됨. 그래서 다른 사용자도 변경된 데이터를 볼 수 있게 하려면 확정처리(COMMIT)을 해주어야 함.	
	commit; 


-- 데이터 입력2.   INSERT INTO 테이블명(변경할 컬럼명1, 변경할 컬럼명2) VALUES(첫번째 입력할 데이터, 두번째 입력할 데이터);
-- ex) DEPT01 테이블에서 DEPTNO 60만 입력한다. 
	insert into dept01(deptno) values(60);
	select * from dept01;
-- ex) DEPT01테이블에서 DEPTNO 70과 LOC 인천만 입력한다.	
	insert into dept01(deptno, loc) values(70, '인천');
	select * from dept01;

/* 3) UPDATE : 입력되어 있는 데이터 내용 중에서 변경이 필요한 부분을 수정처리한다.
		UPDATE 테이블명 SET 변경하고자 하는 컬럼명1=변경할 데이터1, 변경하고자 하는 컬럼명2=변경할 데이터2 WHERE 변경하고자하는 조건(컬럼명=조건데이터);
*/			
	select * from dept01;

-- ex) DEPT01에 DEPTNO가 60인 데이터를 DNAME 인사, LOC 대전으로 변경처리.	
	update dept01 set dname='인사', loc='대전' where deptno=60;
	select * from dept01;

/* 확인예제
 1) EMP01이라는 복사 테이블을 만들고 EMPNO가 가장 높은 번호보다 +1해서 ENAME과 JOB, SAL을 입력하세요.
 2) 그외의 테이블, MGR, HIREDATE(SYSDATE-현재날짜로 수정), DEPTNO는 40으로 수정처리하세요.
*/		
	select * from emp;
	create table emp01 as select * from emp;
	select * from emp01;
	select max(empno)+1 from emp01;
	insert into emp01(empno, ename, job, sal) values(7935, '홍길동', 'SUPERMAN', 5000);
	update emp01 set mgr=7777, hiredate=sysdate, deptno=40 where empno=7935;
	commit;
	select * from emp01;

/* 과제1. (homework 1)
 EMP03 복사테이블 생성
 1. 입력 EMPNO의 가장 작은수보다 -1, MGR : CLERK의 MGR입력, SAL : 평균연봉, COMM : 전체 COMM의 합게
 2. 수정 ENAME : '신길동', JOB은 SUPERMAN, HIREDATE는 최근에 입사일+1
*/ 
	create table emp03 as select  * from emp;
	select * from emp03;
	select min(empno)-1 from emp03;
	select mgr from emp03 where job='CLERK';
	select avg(sal) from emp03;
	select sum(nvl(comm,0)) from emp03;
	insert into emp03(empno, mgr, sal, comm) values(7368, 7902, 2073.21, 2200);
	select * from emp03;
	select max(hiredate) from emp;
	update emp03 set ename='신길동', hiredate=to_date('01/12/1983','MM/DD/YYYY')+1, job='SUPERMAN' where empno=7368;
	select * from emp03;

/* 4) DELETE : 특정 조건의 데이터를 삭제처리하는 구문.
		DELETE [없음] FROM 테이블명 WHERE 조건[컬럼명=조건데이터];
*/
	delete from dept01 where deptno=21;
	select * from dept01;

-- ex) DNAME이 'SALES'인 데이터를 DEPT01에서 삭제하세요.
	delete from dept01 where dname='SALES';
	select * from dept01;

-- 확인예제. DEPTNO가 50이상인 데이터를 모두 삭제하세요.
	delete from dept01 where deptno>=50;
	select * from dept01;

-- 확인예제. EMP01 테이블 COMM이 null이고 DEPTNO가 20인 데이터를 삭제하세요.
	delete from emp01 where comm is null and deptno=20;
	select * from emp01;

/* TRANSACTION : 데이터베이스에서 처리의 한 단위를 의미. 여러개의 SQL문에서 하나의 논리적 작업 단위를 처리하는 것을 의미하기도 한다.
 
 TCL(Transatction Control Language) : 이러한 트랜잭션을 제어하기 위한 명령어.
 
 COMMIT : 데이터의 DML을 통해 수정, 삭제, 입력된 내용을 확정처리.
 
 ROLLBACK : 데이터를 COMMIT 하기 전에 수정, 삭제, 입력된 내용을 원복처리. COMMIT하기전의 상태로 테이블을 되돌림.
 
 SAVEPOINT : 데이터를 특정시점으로 원복처리하고자 할 때, 시점을 SAVE하는 것을 말한다.
*/
	select * from dept01;
-- ex 1) DEPT01에서 DEPTNO 30 '총무' '강남'을 입력한 후에 ROLLBACK처리를 해본다.
	insert into dept01 values(30, '총무', '강남');
	select * from dept01;
	rollback;
	select * from dept01;

-- ex 2) DEPT01에서 DEPTNO 40 '인사' '대전'을 입력한 후에 COMMIT하고 재접속한 경우와 COMMIT을 하지 않고 재접속한 경우 데이터의 내용의 차이를 확인한다.	
	insert into dept01 values(40, '인사', '대전');
-- DB접속을 끊는다. (SCOTT계정 DISCONNECT) 외부에서 COMMIT하기 전에는 데이터가 변경 원복이 된다. TOOL에 따라 AUTOCOMMIT이 발생하는 경우가 있다.	
	select * from dept01;
	rollback;
	select * from dept01;								