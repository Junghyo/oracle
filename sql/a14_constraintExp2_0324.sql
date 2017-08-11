/*
 NOT NULL 제약조건
 	해당 컬럼에 데이터값이 반드시 입력이 되어야 처리되게끔 설정.	
*/
-- notnull_ex 테이블 생성. (empno,ename,job) not null설정
	create table notnull_ex(
		empno number not null,  	-- 제약조건 not null 설정(데이터값이 반드시 입력되게)
		ename varchar2(20) not null,
		job varchar2(20)
	);
	
-- null_ex 테이블 생성. (empno,ename) 	
	create table null_ex(
		empno number,
		ename varchar2(20),
		job varchar2(20)
	);	
	
-- 테이블을 만들고 데이터를 입력, 수정할 때 어떤 영향이 있는지 확인
	select * from notnull_ex;
	select * from null_ex;
	
-- 1) 데이터를 입력시, 묵시적 null값 입력.  묵시적 : INSERT INTO 테이블명(컬럼명을 명시)
-- 		# notnull_ex 테이블 경우
	insert into notnull_ex values('10','','왕자');
	insert into notnull_ex values('0',null,'왕자');
	insert into notnull_ex values('','김','왕자');
	insert into notnull_ex(job) values('왕자'); 
-- null값을 설정하지 않은 컬럼을 지정하고 데이터값을 입력을 시도해도 처리가 안됨. not null 조건을 걸어둔 empno와 ename 데이터값을 반드시 입력해야 한다.
	insert into notnull_ex values('1', '오', '공주');
	insert into notnull_ex values('2','null','에이스');
	insert into notnull_ex values('3','신',null);
	insert into notnull_ex values(4,'신','');
	insert into notnull_ex(empno,ename) values(5,'김');	
--	'' 사이에 들어간 null은 null값이 아닌 null이라는 문자처리. job에 ''로 공백이나 null값을 적어도 입력처리 가능 

--	  # null_ex 테이블 경우 
	insert into null_ex(job) values('왕자');
	insert into null_ex values('10','','왕자');
	insert into null_ex values('0',null,'왕자');
	insert into null_ex values('','김','왕자');
	insert into null_ex(empno,ename)   values('',null);   
-- 처리가능. 입력 안된 컬럼의 데이터값은 null로 표시

-- 2). 명시적 null 값 입력. INSERT INTO 테이블명( 컬럼명 명시를 하지 않음)  VALUES(전체컬럼에 들어갈 데이터를 명시) -- 전체 컬럼에 대한 입력을 처리하겠다.
	insert into null_ex values(null,null,'프로그래머2');
	insert into notnull_ex values(null,'김','왕자');
-- 명시적으로 null값에 데이터입력을 호출하더라도 컬럼의 제약조건에 하나라도 충족이 되지 않으면 입력이 되지 않는다.

/* 데이터 딕셔너리(DATA DICTIONARY)를 통해 CONSTRAINTS 확인하기
 USER_CONSTRIANTS : 전체 테이블에 대한 제약조건 내용 확인하기
 
 CONSTRAINTS_TYPE : 제약조건의 유형에 대한 내용을 선언하는 부분.
 	
	1) P : PRIMARY KEY -- 제약조건에 NOT NULL과 UNIQUE를 설정한다. 보통 메인테이블에서 KEY로 정의하는 컬럼설정.
 	
	2) R : FOREGIN KEY -- 외래키. 자식테이블에 해당 데이터를 입력할 때 참조한 부모테이블에 해당되는 데이터값이 입력되어 있어야 처리가 되는 경우.
						  ex) DEPT(부모테이블)의 컬럼명 DEPTNO에 데이터값이 존재해야만 EMP(자식테이블)의 DEPTNO에 데이터가 입력될 수 있게 해서 무결성을 지킬 수 있다.
	
	3) U : UNIQUE -- 단일키 설정. 해당 컬럼의 데이터가 다른 컬럼의 데이터와 비교해서 반드시 하나의 유일한 데이터가 되게 할 때 설정하는 옵션(중복값 입력 불가)
					 ex) DEPT테이블에 각 DEPTNO에 해당하는 DNAME(부서이름)을 입력할 경우, 동일한 DEPTNO에 다른 DNAME(부서이름)이 입력되게 하면
					 	 데이터 무결성에 문제가 발생하기에 사전에 UNIQUE제약조건을 적용하여 무결성을 확보한다.	
	
	4) C : CHECK -- 특정한 컬럼에 특정한 데이터만 들어오게 처리하는 제약 조건을 말한다. 
					ex) EMP에 컬럼으로 GENDER(성별)을 설정했을 때 사전에 F(여자), M(남자) 입력값을 설정해서 해당 컬럼에 F, M 데이터만 입력이 되도록 처리하여 무결성을 확보한다.					 			  
*/
	select * from user_constraints;

/*
	UNIQUE 제약 조건 :  유일키 설정 처리
	1. 연습용테이블만들기(EMP03)
	2. 컬럼에 유일키 설정하기(UNIQUE)
	3. 데이터 입력 TEST - 데이터가 동일할때, 어떤 에러가 발생하는지 확인
	4. 데이터 딕셔너리에서 해당 제약사항 확인하기.
*/	
	drop table emp03;
	create table emp03(
		empno number unique,             -- empno에 데이터가 중복입력이 되지않도록 제약조건 설정
		ename varchar2(20),
		job varchar2(30)
	);
	
	select * from emp03;
-- 입력 가능	
	insert into emp03 values(1000,'찐따','백수');
	insert into emp03 values(1001,'존스','에이스');
-- 입력 불가. empno에 UNIQUE 제약 조건을 설정했기 때문에 기존에 입력된 1000값을 중복으로 입력이 불가.	
	insert into emp03 values(1000,'하이맨','4번타자');  

-- 데이터 딕셔너리를 통해서 제약사항을 확인할 수 있다.
	select constraint_name, constraint_type, table_name from user_constraints where table_name='EMP03';	

-- 확인예제. student라는 테이블 생성. 학번(unique), 이름, 학과 컬럼 생성
	create table student(
		no number unique,
		name varchar2(20),
		major varchar2(20)
	);
	
	insert into student values(1,'설리','토목공학과');	
	insert into student values(2,'솔지','전기공학과');	
	insert into student values(3,'백수','기계공학과');	
	insert into student values(4,'찐따','산업공학과');
	select * from student;
	select constraint_name, constraint_type, table_name from user_constraints where table_name='STUDENT';

/* 
 제약조건의 사용자 정의하기(CONSTRAINT_NAME 이름 정의하기)
	1. 테이블 생성시, 설정
		형식 : CREATE TABLE 테이블명
					제약조건선언할컬럼 DATA-TYPE 												-- ex) empno number
					CONSTRAINT 제약조건명(테이블명_컬럼명_제약조건유형축약) 제약조건			-- EX) constraint emp_empno_pk primary key
*/	
	create table emp05(
		empno number constraint emp_empno_pk primary key,
		ename varchar2(20)		
	);
	
	select * from user_constraints where table_name='EMP05';
	select * from emp05;
	
	create table emp06(
		empno number primary key,
		enmae varchar2(20)
	);
	select * from user_constraints where table_name='EMP06';
	
/*
 확인예제.
 PROFESSOR 테이블 생성. PROID, NAME 컬럼 생성(NOT NULL, UNIQUE)
 UNIQUE로 생성시 헤당 컬럼에 대한 INDEX가 자동으로 생성
*/	
	create table professor(
		proid varchar2(20) constraint professor_proid_notnull not null,
		name varchar2(20) constraint professor_name_unique unique
	);
	select * from user_constraints where constraint_name like '%NOTNULL%';
	select * from user_constraints where table_name='PROFESSOR';


/* 두개 이상의 컬럼으로 제약조건을 선언하는 경우(복합키)
 다중의 컬럼을 한꺼번에 제약조건을 선언함으로 해당 내용에 대한 KEY 컬럼을 신규작성할 필요가 없을 때 활용된다. 단, 위제약조건 해당 내용에 한꺼번에 처리하지 않으면 에러가 발생.
 ex) 학생테이블의 KEY 생성시 컬럼을 신규로 생성하는 것이 아니라
 GRADE(학년)	PART(반)	NO(번호)	이름
 	
	형식
		CREATE TABLE 테이블명(
			컬럼명1 DATA-TYPE,
			컬럼명2 DATA-TYPE,
			컬럼명3 DATA-TYPE,
			CONSTRAINT 제약조건명(테이블_컬럼복합_제약조건유형축약) 제약조건(컬럼1,컬럼2)
			);
 	
*/
	create table highschool(
		grade number,
		part number,
		no number,
		name varchar2(20),
		constraint highschool_dist_pk primary key(grade,part,no)		-- highschool테이블에서 primary key를 3개의 컬럼으로 잡을 경우 grade, part, no를 동시에 조합해서 동일한 데이터가 안 나오게 처리.
	);	
	insert into highschool values(1,1,2,'김길동');
	insert into highschool values(1,2,3,'김길동');
	insert into highschool values(1,1,3,'김길동');
	insert into highschool values(1,2,1,'김길동');
-- grade,part,no(1,1,2)가 이미 있기 때문에 입력이 안됨
	insert into highschool values(1,1,2,'부엉이');
	insert into highschool values(1,2,3,'부엉이');
	select * from user_constraints where table_name='HIGHSCHOOL';	
	select * from highschool;
	select * from user_constraints;

/* 확인예제
	ADDRESS라는 테이블 생성. 
	도/광역시 시/구군 동 번지 세대주(PRIMARY KEY를 도/광역시, 시/구군, 동, 번지 복합키로 설정)
*/	
	create table address(
		do varchar2(20),
		si varchar2(20),
		dong varchar2(20),
		bunzi varchar2(20),
		sedeju varchar2(20),
		constraint address_dist_pk primary key(do, si, dong, bunzi)
	);	
	
	insert into address values('서울','송파구', '가락동', 2, 3);
	insert into address values('서울','송파구', '송파동', 2, 3);
	insert into address values('서울','송파구', '오금동', 2, 3);
	insert into address values('서울','송파구', '오금동', 1, 4);
	insert into address values('서울','송파구', '거여동', 1, 6);
	insert into address values('서울','송파구', '  ', 2, 16);
	select * from address;
	select * from user_constraints where table_name=upper('address');

/*
 2. 제약조건을 따로 지정하여 설정하는 방법
 	1) 테이블 생성
	2) ALTER TABLE 테이블명
			ADD CONSTRAINT 제약조건명 제약조건유형(컬럼명)
			MODIFYT 컬럼명 CONSTRAINT 제약조건명 제약조건유형
			DROP CONSTRAINT 제약조건명
*/ 