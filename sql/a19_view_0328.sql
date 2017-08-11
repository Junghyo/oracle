/*
 뷰(VIEW)
 	- 뷰는 기본 테이블에서 파생된 객체로 기본 테이블에 대한 하나의 쿼리결과내용으로 이루어진 가상의 테이블
	- 뷰는 테이블에 대한 가상테이블로써 SELECT로 조회된 데이터들의 가상테이블이다.
    - 물리적인 구조에서 테이블과 달리 데이터 저장 공간이 없는 이유는 기존테이블을 호출하여 사용되기 때문이다.

 사용목적
 	1. 직접적인 테이블 접근을 제한하기 위해서 사용된다.(보안상의 목적)
		- 테이블의 컬럼 가운데 접근이 가능한 컬럼과 보안상 접근이 불가능한 컬럼이 있기에 이에 대한 효과적인 권한에 따른 접근처리를 하기 위해서 사용된다.
	
	2. 복잡한 질의를 쉽게 만들기 위해서 사용된다.
		- 여러 테이블에 걸쳐서 조인이나 복잡한 함수를 활용해서 결과물이 나오는 경우, 이 데이터를 다시 활요하기에는 가독성 문제가 발생할 수 있다.
		  이 때, 결과내용만 VIEW로 만든다면 보다 효과적으로 데이터를 로딩할 수 있게 된다.
 
 형식
 	CREATE [OR REPLACE] VIEW 뷰이름 AS SUBQUERY(SQL);		   		
*/

-- ex) emp테이블의 복사테이블(emp01)을 만들고 새로운 emp_view01을 만든다. 이 view는 emp01테이블의 empno, ename, sal, depno를 list하되 조회 조건으로 deptno=30만 나타나게 한다.
	create table emp01 as select * from emp;
	create or replace view emp_view01 as select empno, ename, sal, deptno from emp01 where deptno=30;

-- 데이터값 추가(INSERT)나 데이터값 변경(UPDATE) 가능	
	insert into emp_view01 values(8888,'홍길동',1700,30);
	update emp_view01 set ename='himan' where empno=7900;
	select * from emp_view01;

-- 입력시 에러가 발생하지는 않으나 실제로 VIEW에는 데이터값이 입력이 되지 않음
	insert into emp_view01 values(8888,'홍길동',1700,40);
-- VIEW 생성시 DEPTNO가 30인 데이터만 나오도록 처리하였기에 VIEW에는 DEPTNO 데이터값이 30이외에는 입력이 되지 않음. 그러나 VIEW의 원본테이블 EMP01에는 입력처리가 됨.
-- 1) VIEW 테이블 확인 2)원본테이블 확인	
	select * from emp_view01;
	select * from emp01;
	
/* 초기에 VIEW를 생성할 때, 이에 대한 VIEW 무결성 확보를 위해 VIEW 생성시 옵션을 설정.
	WITH CHECK OPTION
	VIEW의 생성시, 옵션 설정
	
	1. DROP VIEW EMP_VIEW01 	뷰테이블 삭제
	2. WITH CHECK OPTION 이 있는 뷰생성
*/	
	drop view emp_view01;
	create or replace view emp_view01 as select empno, ename, sal, deptno from emp01 where deptno=30 with check option;
-- VIEW 생성 단계에서 WHERE 조건을 걸고 WITH CHECK OPTION을 할 경우 WHERE 조건에 위반되는 데이터값 입력시 에러 발생.
	insert into emp_view01 values(8888,'홍길동',1700,50);

/* 특정한 권한이 있는 사람에게만 수정, 삭제 권한을 가지고 아래와 같은 일반사람에 대해서는 READ ONLY 권한이 있는 VIEW만 활용하게 함으로 보안적인 측면을 강화할 수 있다.
   WITH READ ONLY : 주로 조회만 처리하는 것이 필요한 계정이 접근해서 테이블을 검색할 때 활용된다
	
	CREATE VIEW EMP_VIEW02 AS SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP01 WHERE DEPTNO=30
		WITH READ ONLY
	
	INSERT INTO EMP_VIEW02 VALUE(8890,'홍길동',1700,30) -- 등록 수정이 안됨.(WHERE 조건에 맞음에도 읽기 권한만 주었기에 데이터 입력 및 수정처리가 안됨) 	
*/
	create or replace view emp_view02 as select empno, ename, sal, deptno from emp01 where deptno=30 with read only;
	insert into emp_view02 values(1234,'배튼맨',2400,30);		
	select * from emp_view02;

-- 확인예제
-- 1. emp02 복사테이블 생성
	drop table emp02;
	create table emp02 as select * from emp;

-- 2. 연봉이 3000이하이며 직책이 SALESMAN인 뷰테이블 emp_view03생성
	create or replace view emp_view03 as select * from emp02 where job='SALESMAN' and sal<=3000 with check option; 
	insert into emp_view03(job, sal) values('SALESMAN',2000); 
	insert into emp_view03(job, sal) values('SALESMAN',4000);	-- 등록 안됨(sal<=3000에 위배)
	select * from emp_view03;
	select * from emp02;
	 
-- 3. 보너스가 없는 데이터이며 검색만 가능한 뷰테이블 emp_view04생성
	create or replace view emp_view04 as select * from emp where comm is null with read only;
	insert into emp_view03(empno) values(1222);		-- 등록 안됨(with read only라 검색만 가능하고 데이터 입력, 삭제 및 수정 불가)
	
/*
 복합 VIEW
 	두개 이상의 기본 테이블에 의해 정의된 뷰를 말한다. 주로 복잡한 쿼리를 단순하게 나타나게 할 필요가 있을때 활용된다.
	
 특징
 	복합뷰는 여러테이블과 키에 의해 조인되어 해당 데이터 키에 대한 입력정보를 알 수 없기에 등록, 수정, 삭제가 불가능하다.
	ex) insert into emp03_dept_view values(8888,'홍길동','총무'); 		-- 입력불가	
	
 형식
 	CREATE VIEW 뷰이름 AS SELECT A.컬럼1, A.컬럼2, B.컬럼1 FROM 테이블1 A, 테이블2 B WHERE A.컬럼=B.컬럼 AND 조건......	
*/
-- ex) 기존에 만들어진 emp03과 dept를 조인하여 사원번호, 사원이름, 부서명을 출력하는 VIEW를 생성하자.
	create table emp03 as select * from emp;
	create or replace view emp03_dept_view as select e.empno 사원번호, nvl(e.ename,'데이터없음') 사원이름, d.dname 부서명 from emp e, dept d where e.deptno(+)=d.deptno;
	select * from emp03_dept_view;
	drop view emp03_dept_view; 
	