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
	create or replace view emp_view01 as select empno, ename, sal, deptno from emp where deptno=30;
	select * from emp_view01;
	
	grant create view to scott;  -- scott계정에 view 생성 권한 주기