	select * from emp;
-- 주석 단축기 ctrl+/
-- 안녕하세요
-- 주석문입니다.

-- select : 특정테이블의 컬럼명을 선택하는 명령어.
-- 1) * : 전체컬럼을 생성된 순서로 list할 때.
-- 2) 컬럼명 : 해당 데이터를 보기 위한 명령어.(deptno, job, ename, sal 등...)
-- 3) from 테이블명: 테이블을 list하기 위하여

	select * from emp; 						 -- emp테이블의 전체 컬럼 내용을 list하세요
	select empno, job from emp;				 -- emp테이블의 컬럼 중에 empno와 job 순으로 list
	select deptno, ename, sal from emp; 	 -- 부서번호, 이름, 급여 순으로 list

-- 실제 프로그램과 로딩 부분은 컬럼명이 중요함.
-- empno : 사원번호, ename : 사원이름, job : 직책, mgr : 관리자의 사번,
-- hiredata : 입사날짜, sal : 연봉, comn : 보너스, deptno : 부서번호

-- 문제 : 사원 이름과 직책, 부서번호 순으로 데이터를 list하세요
	select ename, job, deptno from emp;

-- 산술 연산자
-- 데이터베이스의 컬럼단위로 연산을 처리할 수 있다. 기본적인 +, -, *, /
-- %(없음) : 함수를 활용해야함.

	select * from emp;
-- 현재 연봉에 +100을 더한 값을 출력하세요.(이름, 급여)
	select ename, sal, sal+100, sal-100, sal*10, sal/10 from emp;

-- 컬럼 간의 연산처리 : 컬럼명1+컬럼명2

-- ex) 부서번호와 연봉을 합산한 내용을 출력하세요.
	select deptno, sal, deptno+sal from emp;

-- 문제1) 연봉이 올해 전진원을 대상으로 10% 올랐다.
-- 사원명, 기존연봉, 인상분, 연상된 영봉 총합을 출력하세요.
	select ename, sal, sal*0.1, sal+sal*0.1 from emp;
	
-- 문제2) 부서별로 연봉 인상분을 다르게 책정하세요.
-- 부서번호가 10번인 경우에는 10%, 20번인 경우는 20%, 30번인 경우는 30%
-- 사원명, 부서번호, 연봉, 연봉 인상분, 인상된 연봉 출력
	select ename, deptno, sal, sal*deptno*0.01, sal+(sal*deptno*0.01) from emp;		

-- 문자열 표현은 어떻게 할까?
-- database 문자열 연결처리는 '||'를 활용한다.
	select '사원의 이름은'||ename||'이고, 부서번호는 '||deptno||'입니다.' from emp;	
	select * from emp;

-- 확인 예제. 사원번호가 @@@인 @@@@의 올해 연봉은 @@@@입니다!! 출력
	select '사원번호가 '||empno||'인 '||ename||'의 올해 연봉은 '||sal||'만원입니다!!' from emp;

/*
 과제
 아래의 형식으로 데이터를 나타내세요.
 1. ename은 현재 연봉은 @@@만원인데, 최근에 10%인상된 금액이며 작년 연봉은 @@@만원이었습니다.
 2. ename의 입사일은 hiredate입니다.
 3. 직책이 @@@인 @@@는 부서번호가 @@@입니다.
 4. @@@님은 현재 연봉과 보너스(comm)의 합산액이 @@@입니다. 
 */

-- nvl()
-- null : 데이터베이스에는 데이터가 없는 값을 null값이라고 한다. 공백('')도 아니면서 0도 아닌 말 그대로 데이터가 입력되어 있지 않은 것을 말한다.
-- 프로그램에서 쓰이는 초기값과 구분해서 알고 있어야 한다.
-- 주의 : 화면과 연동될 때는 null이 표시되어있으나, nullpointerException이라는 에러가 발생한다.
-- 또한 데이터 컬럼간의 연산도 정상적으로 되지 않는다.

	select sal, sal+1, sal+0, sal+null from emp;
-- 그래서 데이터베이스에서는 null에 대한 연산의 정상적인 처리를 위해 함수를 만들어서 활용한다.
-- nvl을 활용하면 null값일 때, 초기값에 대한 정의를 해서 정상처리가 가능하게 한다.
-- nvl(컬럼명, 데이터가 null일 때 처리할 데이터)
	select comm, comm+10, nvl(comm, 0), nvl(comm,0)+10 from emp;	