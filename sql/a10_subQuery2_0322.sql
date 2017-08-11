/*
 데이터의 구조만 복사하고자 할 때 (기존 테이블의 내부 데이터는 복사하지 않고 컬럼 및 DATA-TYPE만 복사하고자 할 경우)
 기존 테이블에 WHERE 1=0 조건문으로 데이터를 초기화 한 후 테이블 생성
*/		 
	select * from emp where 1=0;
	create table emp_structor as select * from emp where 1=0;
	select * from emp_structor;	
	
/*
 서브쿼리를 이용한 데이터 추가.
 INSERT 구문을 SELECT와 혼합해서 데이터 입력 처리가 가능
 
 형식 : INSERT INTO 생성된테이블명 SELECT [선택컬럼명] FROM 복사할테이블명 WHERE 조건;   -- 해당 SQL로 여러 라인의 데이터를 한번에 입력할 수 있다.
 		주의할 점) 생성된테이블의 컬럼과 SELECT [선택컬럼명]의 컬럼 갯수와 TYPE이 동일하여야 한다.
*/
	select * from emp_structor;
-- EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO 
	insert into EMP_STRUCTOR select * from emp where sal>=3000;	

-- 컬럼 지정 및 변경. 
-- 형식 : INSERT INTO 생성된테이블명(컬럼1, 컬럼2, 컬럼3) SELECT 컬럼1, 컬럼1+컬럼2, 함수(컬럼3) FROM 복사할테이블명 WHERE 조건;
	insert into emp_structor(comm) select empno-mgr from emp;
	select * from emp_structor;
	truncate table emp_structor;
	insert into emp_structor(empno, sal, ename) select empno, sal+nvl(comm,0), rpad(ename,7,'^^') from emp;

/* 확인예제. dept_sub 테이블을 생성(dept 테이블 이용). 추가컬럼 : kdname(한글이름), membercnt(등록된 인원)
	1) 구조만 있는 공백테이블 생성
	2) dept테이블을 이용해서 기존데이터와 추가된 데이터를 입력하세요.
		-처음 : 한글이름-없음, membercnt=0	

*/	
	create table dept_sub as select deptno, dname, loc, '           ' kname, 0 membercnt from dept where 1=0;
	insert into dept_sub select deptno, dname, loc, '없음' kdname, 0 membercnt from dept;
	select * from dept_sub;
	truncate table dept_sub;
	select * from dept;

-- kdname에 대한 처리. 
-- DECODE(deptno,10,'회계', 20,'감사', 30,'영업', 40,'운영', '없음') kname          -- 부서번호에 따라 직책부여

/* membercnt에 대한 처리                
	emp테이블에 데이터를 확인해서 처리
	(SELECT COUNT(*) FROM EMP WHERE deptno=d.deptno) membercnt                   -- emp테이블 사원수를 부서별로 카운팅
	
*/	
	insert into dept_sub
		select deptno, dname, loc, decode(deptno,10,'회계', 20,'감사', 30,'영업', 40,'운영', '없음') kname, (select count(*) from emp where deptno=d.deptno) membercnt from dept d;
	
	select count(*) from emp e ,dept d where e.deptno=d.deptno group by e.deptno;	/* 이부분 진짜 모르겠네  다시 체크*/
	
-- 1단게
	select * from dept;

-- 2단게
	select a.*, decode(deptno,10,'회계', 20,'감사', 30,'영업', 40,'운영', '없음') kname from dept a;


/*
 수정 서브쿼리 : 수정하는 MAIN SQL에서도 SUB QUERY로 해당 내용의 결과를 처리하는 것을 말한다.
 UPDATE 테이블명 SET 컬럼명 = 데이터 WHERE 조건 -- 가존
 UPDATE 테이블명 SET 컬럼명 = 데이터( SELECT 컬럼명 FROM 테이블 WHERE 조건 ) WHERE 조건  -- SUB QUERY 적용
*/

-- ex) empno가 7369인 사람의 보너스를 전체 보너스의 평균을 할당하려고 한다.
-- 	1) 서브쿼리	
	select avg(comm) from emp;
--	2) 메인쿼리
	update emp set comm =() where empno=7369;
--	3) 결합	
	update emp set comm =(select avg(comm) from emp) where empno=7369;
	select * from emp;

/*
	확인예제.
	1. emp_copy라는 emp의 복사테이블을 생성.
	2. emp_copy에서 comm이 null값인 데이터에 sal의 최저값으로 수정하세요.
	
*/	
	create table emp_copy as select * from emp;
	update emp_copy set comm=( select min(sal) from emp_copy) where comm is null;
	select * from emp_copy;