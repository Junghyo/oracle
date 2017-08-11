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
-- 1) 데이터를 입력시, 묵시적 null값 입력.
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