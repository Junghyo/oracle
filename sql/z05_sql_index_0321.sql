/*
 인덱스란?
 	데이터에 빠르게 접근하는 것을 도와줌으로서 데이터베이스의 성능 향상에 도움을 주는 객체.
	1) 장점
		- 검색 속도가 빨라진다.
		- 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킨다.
	
	2) 생성시점
		- 설계(논리설계, 물리설계), 테이블 생성, 데이터 입력 및 생성
		- 운영단 데이터 부하시 생성
	
	3) 사용여부
		- 테이블의 행의 수가 많은 경우(데이터 건수가 많을 경우)
		- WHERE 문으로 INDEX에 해당 컬럼이 많이 사용될 때.(조회문에 사용한다)
			ps) 테이블에 입력, 수정, 삭제가 자주 일어나면 사용하지 않는 것이 일반적이다.
		- 검색 결과가 전체 데이터의 2~4%정도 일 경우.
			ex) 1000만건의 인사정보 관련 데이터에서 검색에 20~40만건 사이의 데이터를 로딩해서 사용할 때 INDEX 처리함.
	
	4) 단점
		- 인덱스를 위한 추가 공간이 필요
		- 인덱스를 생성하는데 시간이 걸린다.		 			
*/

/*
 인덱스 생성 예제 만들기.
 1. 복사 테이블 만들기
	CREATE TABLE EMP_IDX_EXP AS SELECT * FROM EMP;
 
 2. 인덱스 처리할 컬럼 지정
	EMP_IDX_EMP에서 EMPNO를 INDEX로 지정

 3. 인덱스 생성(해당테이블에 인덱스 매핑) ##
	CREATE INDEX 인덱스이름 ON 생성할테이블명(생성대상컬럼 ASC/DESC)
	CREATE INDEX INDEX_EMPNO_EMP_IDX_EXP ON EMP_IDX_EMP(EMPNO);

 4. 테이블스페이스
 	CREATE INDEX 인덱스이름 ON 생성할테이블명(생성대상컬럼) TABLESPACE 저장할테이블스페이스명	
*/ 
	create table emp_idx_exp as select * from emp;    -- 복사된 테이블의 경우 CONSTRAINTS나 INDEX는 복사가 되지않고 데이터만 복사됨.
	select * from emp_idx_exp;

-- EMP_idx_EXP 테이블에서 EMPNO 컬럼에 INDEX를 설정한다.	
	create index index_empno_emp_idx_exp on emp_idx_exp(empno);		-- Object Explorer의 Indexes에 파일 생성(index_empno_emp_idx_exp)
	
-- 인덱스 삭제. DROP INDEX 인덱스 이름
	drop index index_empno_emp_idx_exp;	


-- 확인예제. DEPT 테이블 복사본 DEPT_IDX_EXP를 만들고 인덱스 이름은 IDX_DEPTNO_DEPT로 해서 생성, 확인 및 삭제처리...
	create table dept_idx_exp as select * from dept;
	select * from dept_idx_exp;
	create index idx_deptno_dept on dept_idx_exp(deptno);
	drop index idx_deptno_dept;

-- emp테이블의 empno컬럼에 대한 인덱스를 생성. 인덱스 오름차순 내림차순 설정시 컬럼명 뒤에 ASC/DESC
	create index idx_emp_empno on emp(empno asc) tablespace exp_tab_space;
	create index idx_emp_empno on emp(empno desc) tablespace exp_tab_space;
	



	
