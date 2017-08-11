/*
 SUB QUERY : 하나의 SELECT문장의 절 안에 포함된 또 하나의 SELECT 문장을 만한다.
			 서브쿼리를 포함하고 있는 쿼리문을 메인쿼리(MAIN QUERY), 포함된 또 하나의 쿼리를 서브쿼리(SUB QUERY)라고 한다.

ex) EMPNO테이블에서 연봉이 최고로 많은 사람의 이름과 연봉을 LIST하세요.
 	SELECT ENAME, SAL FROM EMP					 	--> 메인쿼리
		WHERE SAL = ( SELECT MAX(SAL) FROM EMP ) 	--> 서브쿼리

# 작성시 주의점
	1. 서브쿼리는 비교 연산자(=, >, <...)의 오른쪽에 기술해야 하고 괄호로 묶어주는 것이 일반적이다.
	
	2. 서브쿼리는 메인쿼리가 실행되기 이전에 실행된다. 서브쿼리 먼저 처리 -> 메인쿼리 처리
	
# 서브쿼리의 유형
	1. 조건의 값으로 처리되는 경우.
		SELECT * FROM 테이블명 WHERE 컬럼명 = ( SELECT 컬럼명 FROM 테이블명 WHERE 조건 )
			- 단일값 조건 : =, >, <....(비교연산자 활용)
			- 다중값 조건 : IN, EXIST, ANY, ALL....
	
	2. 테이블 자체로 SUB QUERY처리 가능
		SELECT * FROM ( SELECT 컬럼명1, 컬럼명2, 함수(컬럼명3) FROM 테이블명 WHERE 조건 ) WHERE 조건
		SELECT 컬럼명1+컬럼명2, .... FROM ( SELECT 컬럼명1, 컬럼명2, 함수(컬럼명3) FROM 테이블명 WHERE 조건 ) WHERE 조건 
	
	3. 스칼라 서브쿼리
		SELECT ( SELECT 컬럼명1 FROM 테이블명 WHERE 조건=메인조건1), 컬럼명2, 컬럼명3 FROM 테이블명 WHERE 조건 			 					
*/

-- 1. 조건값으로 SUB QUERY가 사용되는 경우(단일값)
-- ex) 평균연봉보다 많은 사람들의 이름과 연봉을 출력하세요.
	select ename 이름, sal 연봉 from emp where sal> ( select avg(sal) from emp );

-- ex) 보너스가 있는 사람들 중에서 최고인 사람의 이름과 연봉과 보너스를 출력하세요.
	select ename 이름, sal 연봉, comm 보너스 from emp where comm = ( select max(comm) from emp where comm is not null );

-- ex) 평균 보너스보다 높은  사람의 이름과 연봉과 보너스를 출력하세요.
	select avg(comm) from emp where comm is not null;  -- null값을 배제하고 처리
	select ename 이름, sal 연봉, comm 보너스 from emp where comm >= (select avg(comm) from emp where comm is not null );
	select avg(nvl(comm,0)) from emp;  -- null값에 0을 입력하여 처리
	select ename 이름, sal 연봉, comm 보너스 from emp where comm >= (select avg(nvl(comm,0)) from emp );	
	
-- 확인예제
-- 1). 부서번호가 가장 높은 사람의 이름과 부서번호가 출력하세요.
	select ename 이름, deptno 부서번호 from emp where deptno = ( select max(deptno) from emp );
	
	select e.ename 이름, d.dname 부서명 from emp e, dept d where e.deptno=d.deptno and e.deptno=(select max(deptno) from emp);

-- 2). 가장 최근에 입사한 사람의 이름과 직책, 입사일을 출력하세요 
	select ename 이름, job 직책, hiredate 입사일 from emp where hiredate = ( select max(hiredate) from emp );

-- 1-2. SUB QUERY의 결과값이 2개 이상인 경우
-- SUB QUERY로 결과값이 두개 이상 나올 경우 해당 컬럼의 갯수에 맞는 컬럼을 선언하여 결과처리가 가능하게 한다. (컬럼1, 컬럼2) IN ( SELECT 컬럼1, 함수(컬럼2) FROM .... )	

-- ex) 부서별로 입사일이 최고인 사람들의 이름과 입사일을 출력하세요.
	select deptno, max(hiredate) from emp group by deptno;

-- 1) 다중 조건에 대한 처리
-- IN 구문을 SUB QUERY에 넣어서 해당하는 다중의 데이터 내용을 처리할 수 있다.
	select * from emp where deptno in(10, 20); 
	select * from emp where deptno in( select deptno from emp where deptno<30);

-- 연봉이 3000, 그리고 부서번호 20
	select * from emp where sal=3000 and deptno=20;	

-- DEPTNO, HIREDATE의 조건을 둘다 SUB QUERY에 의해서 처리할 경우.
	SELECT ENAME, DEPTNO, HIREDATE FROM EMP WHERE (DEPTNO, HIREDATE) IN ( SELECT DEPTNO, MAX(HIREDATE) FROM EMP GROUP BY DEPTNO );	



-- 확인예제.
-- 1. 직책별로 가장 낮은 연봉을 받는 사람의 이름, 직책, 연봉을 출력하세요.
	select ename 이름, job 직책, sal 연봉 from emp where (job, sal) in ( select job, min(sal) from emp group by job );
	select ename, job, sal from emp order by job, sal;
	select job, min(sal) from emp group by job;

/* 과제1. (homework 1)
 1. 입사일 분기별로 가장 높은 연봉을 받는 사람을 출력하세요.
 2. 연봉이 3000 이상인 사람 중에 등급(테이블 활용도 가능)을 나누어서 해당 등급별 최고 연봉을 받는 사람을 이름, 등급 연봉을 출력하세요.
*/ 	

/* EMP테이블에서 부서번호 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원보다 많은 급여를 받는 사람의 이름과 급여를 출력하세요.
 1) 30번 소속 사원들 중에서 급여를 가장 많이 받는 사원  --> GROUP 함수 이용.
 2) 전체데이터를 SUBQUERY로  로딩하여 사용
 		== ALL, ANY..(SUB QUERY)
			ALL : SUB QUERY에 모든 내용이 합치될 때
			ANY, SOME : SUB QUERY의 결과값이 하나 이상 일치하면 
*/ 
 -- 부서번호 30번의 모든 사람 연봉보다 큰 사람들만 list
	select ename, sal, deptno from emp where sal >= all( select sal from emp where deptno=30 );
-- 부서번호 30번의 사람들 중에서 아무나 연봉이 크기만 하면 list(30번 사람들중 연봉이 제일 낮은 사람이 JAMES 950인데 이 사람보다 연봉이 높으면 무조건 list)
	select ename, sal, deptno from emp where sal >= any( select sal from emp where deptno=30 );

	select ename, sal, deptno from emp where sal> ( select max(sal) from emp where deptno=30 group by deptno );
	select * from emp;

-- 확인예제. 연봉이 3000미만인 사람 중에 최근에 입사한 사람의 사원번호, 연봉, 입사일을 출력하세요.
	select ename, empno, sal, hiredate from emp where hiredate >= all( select hiredate from emp where sal<3000 );

-- 과제2.(homework2)
-- 1. 부서번호가 30인 사람중에 가장 나중에 입사한 사람보다 연봉이 많으면 출력하세요
-- 2. 직책이 SALESMAN인 사원이 받는 급여들의 최소 급여보다 많이 받는 사원들의 이름과 급여를 출력하되 부서번호 20번인 사원은 제외한다 (ANY 연산자 이용)
 	
/*
 WHERE EXISTS(SUB QUERY) : 해당 SUB QUERY에서 데이터가 있는지 여부를 체크해서 메인 SQL을 처리하고자 할때 활용
 						   특정 조건에 의해서 전체 데이터 로딩 여부를 확인하고자 할 때 활용 
 ex) 부서번호가 30인 데이터가 있으면 전체 사원테이블을 list하세요. (부서번호 30번이 없으면 사원테이블을 list 로딩 안됨)
*/		
	select * from emp where exists(select * from emp where deptno=30);
	select * from emp where exists(select * from emp where deptno=40); -- list 처리가 안됨

-- 확인예제. 관리자번호의 데이터 중에 null값이 있으면 이름, 관리자번호, 직책을 출력하고자 한다.
	select ename, mgr, job from emp where exists( select * from emp where mgr is null );

/*
 서브쿼리를 활용한 테이블 생성, 데이터 입력, 수정, 삭제..
 
 1. 테이블 생성하기
 	1) 데이터 + 구조
		CREATE TABLE 생성테이블명 AS SELECT 컬럼1, 컬럼2 FROM 기존테이블 WHERE 조건..
*/
-- ex) EMP테이블에서 연봉이 2000 이상인 데이터 중에 사원번호(no), 사원명(name), 연봉(salary)로 EMP001을 만드려고 한다.		

	create table emp01 as select empno no, ename name, sal salary from emp where sal>=2000;
	select * from emp01;

-- ex) EMP테이블에서 연봉이 2000 이상인 데이터 중에 사원번호(no), 사원명(name), 연봉(salary), 부서이름(dname)으로 EMP001을 만드려고 한다.(JOIN 적용)		
	create table emp02 as select e.empno no, e.ename name, e.sal salary, d.dname from emp e, dept d where e.deptno=d.deptno and sal>=2000;
	select * from emp02;

-- 확인예제. emp, salgrade를 활용하여 다음과 같은 신규 테이블을 구성하세요.
-- 연봉이 1000이상 되는 데이터를 사원명(name), 부서번호(partno), 연봉(salary), 급여등급(salgrade)로 된 empgrade 테이블을 생성
	create table empgrade
		as select e.ename name, e.deptno partno, e.sal salary, g.grade grade from emp e, salgrade g
		where sal>=1000 and (e.sal between g.losal and g.hisal);
	select * from empgrade;

/* 과제3. (homework 3)
 다음과 같은 형태의 테이블 NEW_EMP을 구성하세요.
 이름(name), 번호(no), 입사일(credate)-문자열(@@@@년 @@@월 @@@일) 올해기준근무연수(workyears)
*/
	create table new_emp
		as select ename name, empno no, to_char(hiredate, 'YYYY"년" MM"월" DD"일"') credate, to_number(to_char(sysdate, 'YYYY'))-to_number(to_char(hiredate,'YYYY')) workyears from emp; 
	select * from new_emp;

/*
 데이터의 구조만 복사하고자 할 때 (기존 테이블의 내부 데이터는 복사하지 않고 컬럼 및 DATA-TYPE만 복사하고자 할 경우)
 기존 테이블에 WHERE 1=0 조건문으로 데이터를 초기화 한 후 테이블 생성
*/		 
	select * from emp where 1=0;
	create table emp_structor as select * from emp where 1=0;
	select * from emp_structor;	
	
	
	