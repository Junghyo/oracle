/*
 여러가지 고급 DML QUERY
 	1. 다중 테이블에 다중행 입력하기.
		INSERT 구문을 여러번 써서 데이터를 입력하는 경우가 많은 데이터를 입력할 때 번거러운 경우가 있다.
		한번은 SUB QUERY를 통해서 여러 동일한 구조의 테이블에 입력할 때 INSERT ALL 구문을 활용하면 손쉽게 처리할 수 있다.
		
		1) 형식
			INSERT ALL
				INTO 테이블1명 VALUES(컬럼1, 컬럼2, 컬럼3)
				INTO 테이블2명 VALUES(컬럼1, 컬럼2, 컬럼4)
				SELECT 컬럼1, 컬럼2, 컬럼3, 컬럼4 FROM 데이터를 불러올 테이블명 WHERE 조건				
*/
-- ex) emp테이블에서 구조복사테이블 생성. emp_hir(empno, ename, hiredate) , emp_mgr(empno, ename, mgr)을 만들되 deptno=20인 데이터만 입력처리
	create table emp_hir as select empno, ename, hiredate from emp where 1=0;
	create table emp_mgr as select empno, ename, mgr from emp where 1=0;
	
	insert all
		into emp_hir values(empno, ename, hiredate)
		into emp_mgr values(empno, ename, mgr)
		select ename, empno, mgr, hiredate from emp where deptno=20; 

	select * from emp_hir h, emp_mgr m where h.empno=m.empno;

/*
 SUB QUERY를 이용한 데이터 수정하기.
 UPDATE 테이블명
 	SET (변경할컬럼1, 변경할컬럼2) = (SELECT 컬럼1, 컬럼2 FROM 데이터를 불러올 테이블명) WHERE 조건
*/
-- ex) 20번 부서의 지역명을 40번 부서의 지역명으로 변경하려고 한다. SUB QUERY를 활용해보자
	create table dept01 as select * from dept;
	update dept01 set loc = (select loc from dept where deptno=40) where deptno=20;
	select * from dept01;
	update dept01 set (loc,dname) = (select loc, dname from dept where deptno=40) where deptno=20;
	select * from dept01;

-- 확인예제. 테이블 - emp 복사본 emp03 생성. job이 president인 sal과 deptno를 job이 clerk인 데이터로 변경하세요.
	create table emp03 as select * from emp;
	update emp03 set (sal,deptno) = ( select sal,deptno from emp where job='CLERK' and empno=7369 ) where job='PRESIDENT' ;
	select * from emp03;

/*
 MERGE 처리
 DATA MIGRATION(데이터 이관처리) 할때 많이 활용된다.
 	테이블A, 테이블B로 데이터를 이관처리시, 부서가 다르게 입력되어 있는 데이터도 있고
 	신규로 입력해야 될 데이터도 있으며 입력되어 있는 데이터는 특정 컬럼을 수정처리해야 될 경우에 많이 활용된다.
 
 1) 테이블A에 있으나 테이블B에는 없는 데이터는 INSERT 처리
  
 2) 테이블A에 있고 테이블B에도 있으나 특정한 컬럼을 수정하는 것은 UPDATE처리
 형식 : MERGE INTO 통합할테이블명                     								 -- 테이블B
 			USING 원본테이블 또는 참조할테이블	    								 -- 테이블A
			ON 조건처리 															 -- 일번적으로 두 테이블의 KEY값(공통컬럼)을 조건으로 처리. ex) 테이블A.동일컬럼=테이블B.동일컬럼
			WHEN MATCHED THEN 														 -- 두개의 테이블에 KEY데이터가 공통으로 있을때
				업데이트 관련 처리(UPDATE SET)
				UPDATE SET 통합할테이블명.변경할컬럼=원본및참조테이블.컬럼 			-- 해당 데이터가 동일한 경우 ex) 테이블B.변경컬럼=테이블A.컬럼
				
			WHEN NOT MATCHED THEN 				     								-- 한쪽 테이블에 데이터가 없는 경우 ex) 테이블A에는 있으나 테이블B에는 없는 경우
				입력 관련 처리(INSERT VALUES)
				INSERT VALUES(원본및참조테이블.컬럼1, .....)						-- ex) INSERT VALUES(테이블A.컬럼명.....)		
*/

/* 확인예제.
emp01과 emp02 데이터를 로딩해서 emp01에 데이터 MERGE처리
1). EMP01 복사테이블 만들기
2). EMP02 복사테이블 만들기. JOB='MANAGER'만...
	EMP02 JOB을 TEST로 UPDATE (empno는 동일하지만 job이 다름)
	EMP02 입력 7935, '홍길동', 'SUPERMAN', 7839, SYSDATE, 4000, 100, 40	
*/
	create table emp01 as select * from emp;
	create table emp02 as select * from emp where job='MANAGER';
	update emp02 set job='test';
	insert into emp02 values(7935,'홍길동','SUPERMAN',7839,sysdate,4000,100,40);
	
	merge into emp01 e1										-- 최종데이터는 emp01에 처리
		using emp02 e2										-- emp02데이터를 사용함
		on (e1.empno=e2.empno) 								-- 해당 key값이 empno가 있는지 여부에 따라 update/insert
		when matched then									-- empno값이 같을 때
			update set e1.job=e2.job							-- emp02.job이 test인 데이터를 emp01.job에 넣겠다.
		when not matched then								-- 동일한 empno값이 없을 경우
			insert values(e2.empno, e2.ename, e2.job, e2.mgr, e2.hiredate, e2.sal, e2.comm, e2.deptno);
	
	select * from emp01;
	
/* 확인예제.
 복사테이블 emp03
 복사테이블 emp04 (deptno=30만)
 emp04 hiredate->sysdate (update처리)
 emp04 (7370,'원더걸스','SUPERMAN',7839,sysdate,6000,400,40)입력
*/
	create table emp03 as select * from emp; 			
	create table emp04 as select * from emp where deptno=30;
	update emp04 set hiredate=sysdate;
	insert into emp04 values(7370,'원더걸','SUPERMAN',7839,sysdate,6000,400,40);
	merge into emp03 e3
		using emp04 e4 on (e3.empno=e4.empno)
		when matched then
			update set e3.hiredate=e4.hiredate
		when not matched then
			insert values(e4.empno, e4.ename, e4.job, e4.mgr, e4.hiredate, e4.sal, e4.comm, e4.deptno);
	
	select * from emp03;
	select * from emp04;

			 			