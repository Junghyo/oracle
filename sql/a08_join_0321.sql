-- EMP테이블 X DEPT테이블. 크로스 조인
	select * from emp;			-- MGR과 EMPNO JOIN관계. ex) ALLEN의 MGR:7698  // BLAKE의 EMPNO: 7698 
	select * from dept;
	select * from emp, dept;
	select count(*) from emp;   
	select count(*) from dept;
	select count(*) from emp, dept;

/*
 EQUAL JOIN : 두개 이상의 테이블에서 각 테이블에 소속되어 있는 컬럼의 데이터가 같은 값이 있을 때 연관하여 처리할 수 있는 JOIN을 말한다.
 	- 형식 : SELECT 표현할컬럼 FROM 테이블1, 테이블2 WHERE 테이블1.공통컬럼 = 테이블2.공통컬럼;   ## 공통컬럼 : 같은 데이터가 있는 컬럼
*/	
	select * from emp, dept where emp.deptno=dept.deptno;

-- ex) 사원의 이름과 직책, 소속부서명을 출력하세요.
	select emp.ename, emp.job, dept.dname from emp, dept where emp.deptno=dept.deptno;

-- ex) 사원명과 부서위치를 출력하세요.
	select emp.ename, dept.loc from emp, dept where emp.deptno=dept.deptno;	

-- ex) 보너스가 있는 사원의 이름과 부서명을 출력하세요.
	select emp.ename, dept.dname, emp.comm from emp, dept where emp.deptno=dept.deptno and emp.comm is not null;	

/* 과제 (homework)
 부서위치별 사원의 수를 아래 형식으로 출력허세요.
 부서위치		사원수		
*/

/*
 NON-EQUI JOIN : 2개 이상의 테이블에서 컬럼의 값이 직접적으로 일치하지 않을 시 사용하는 조인으로 '='를 제외한 연산자를 사용한다.
*/
	select * from salgrade;
-- 급여 등급을 5개로 나누고 이 등급을 표시하시오.
-- WHERE SAL BETWEEN [LOSAL] AND [HISAL]
-- 이름과 연봉등급을 출력하세요

/* 테이블 ALIAS 사용하기 : 테이블의 컬럼에 같은 이름이 없으면 의미가 없지만 같은 이름이 있으면 구분하기위해 테이블명[공백]ALIAS를 활용한다.
						  또한, 데이터 컬럼의 명이 ㅁ낳아, 가독성을 위해 기술하는 경우도 있다.
     테이블ALIAS.컬럼명
*/

-- ex) 이름과 연봉 연봉등급을 출력하세요.
	select a.ename, a.sal, b.grade from emp a, salgrade b where a.sal between b.losal and b.hisal;	

/*
 과제(homework)
 student10 아이디, 이름
 studentPoint 아이디, 과목, 점수
 gradeCheck 최저점수lopoint, 최고점수hipoint, 학점등급(A~F)
 1) 아이디를 조인해서(equal join)
 	이름 과목 점수 출력
 2) 점수를 조인해서(not equal join)
 	과목 점수 학점등급
 3) student10 studentPoint gradeCheck 조인을 하여
 	이름 과목 학점등급	 	
*/	

/*
 OUTER JOIN : 두 개의 조인 관계에 있는 테이블에 있어서 데이터가 한쪽 또는 양쪽 테이블의 조건에 만족하지 않아도 데이터 결과를 출력해야 하는 경우에 활용되는 조인이다.
 	EMP DEPTNO: 30번까지 // DEPT DEPTNO: 40번까지 있는데 조인한 후 DEPTNO 40엔 데이터가 없다는 표시를 해야함
	
 WHERE 데이터가 없는 테이블.컬럼명(+) = 데이터가 있는 테이블.컬럼명
*/
-- ex)부서번호별로 매칭되는 사원이름을 출력하되, 이름이 없으면 없다는 표시가 필요  
-- 이름, 부서번호, 부서명 표시
	select a.ename, b.deptno, b.dname from emp a, dept b where a.deptno=b.deptno order by b.deptno; -- dept테이블에 deptno가 40이 있으나 list되지 않음
	select a.ename, b.deptno, b.dname from emp a, dept b where a.deptno(+)=b.deptno order by b.deptno; -- 40번에 null값으로 list됨
-- nvl 사용으로 null값을 '인원없음'으로 처리	
	select nvl(a.ename,'인원없음'), b.deptno, b.dname from emp a, dept b where a.deptno(+)=b.deptno order by b.deptno;
	select b.deptno, count(a.ename) from emp a, dept b where a.deptno(+)=b.deptno group by b.deptno order by b.deptno;
	

/* 과제(homework)
 outer join, group을 활용하여 부서명별 인원을 확인하려고 한다. 아래의 형식으로 출력하세요. 인원이 없는 곳은 0으로 표시
 부서명 인원수 
*/
	
/*
 SELF JOIN : 말 그대로 자기 자신과 조인을 맺는 것을 말한다.
 			 FROM절에 같은 이름의 테이블을 나열하여 다른 테이블인 것처럼 인식해서 조인하여 그 결과물을 출력하는 것을 말한다.
			 
 SELECT * FROM 테이블명 ALIAS01, 동일테이블명 ALIAS02 WHERE ALIAS01.연관컬럼=ALIAS02.연관컬럼		 			 
*/	
-- ex) EMP 테이블에서 사원명과 이 사원을 관리하는 관리자명을 출력하세요
	select work.ename, work.mgr, manager.ename, manager.empno from emp work, emp manager where work.mgr=manager.empno;


/* 계층형 JOIN관계 정보 테이블 만들기(SELF JOIN)
 1. 구조를 정리한다.
 	- ID와 상위ID를 입력하는 KEY를 만든다.
	  NUMID, PARENTNUMID, ROLE01, NAME
	  아이디, 상위아이디   , 역할   , 이름
	
 2. 테이블을 생성한다.
  	- 
 3. 데이터를 입력한다. (위에 세워놓은 계층형 구조에 의한 데이터 입력처리)
 4. 입력된 데이터 내용이 정상적으로 되어 있는지 확인한다. - 조회처리
*/ 

-- 2. 테이블 생성
	create table family(
		numid number,
		parentnumid number,
		role01 varchar2(100),
		name VARCHAR2(500)
	);	
	
-- 3. 데이터 입력	
	insert into family values(1, 0, '할아버지', '홍길동');
	insert into family values(2, 1, '아버지', '홍정길');
	insert into family values(3, 2, '아들', '홍현호');
	insert into family values(4, 1, '삼촌', '홍정호');
	insert into family values(5, 2, '딸', '홍진영');
	insert into family values(6, 1, '고모', '홍진경');
	truncate table family;
	
-- 4. 조회
	select * from family;
	select b.name, a.role01, a.name from family a, family b where a.parentnumid=b.numid;
	
