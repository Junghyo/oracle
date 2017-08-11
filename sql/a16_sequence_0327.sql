/*
 SEQUENCE : 오라클에서 중복된 값을 넣지 않기 위해 기본 키(PRIMARY KEY)를 테이블의 하나의 컬럼에 설정한다.
 이 컬럼에 중복되지 않는 값을 넣기 위해서 오라클에서는 SEQUENCE라는 객체를 지원하고 있다.
 시퀸스는 테이블 내의 유일한 숫자를 자동으로 생성하여 자동으로 번호를 입력할 수 있게 하기에 사용자의 유일키 생성에 대한 부담을 줄여준다.
 
 SEQUENCE
 	- 유일한(UNIQUE) 값을 생성해주는 오라클 객체
	- 시퀸스를 생성하면 기본키와 같이 순차적으로 증가하는 컬럼을 자동적으로 생성가능
	- 보통 PRIMARY KEY 값을 생성하기 위해 사용
	- 메모리에 CACHE 되었을 때 SEQUENCE값의 엑세스 효율이 증가
	- SEQUENCE는 테이블과는 독립적으로 저장되고 생성. 하나의 SEQUENCE를 여러 테이블에서 사용가능

 ex) 학생 테이블에 번호를 입력한다.
 	no 이름
	no 컬럼에 1, 2, 3, 4, 5, .... 으로 자동으로 입력을 해야할 경우
	
	사번 테이블에 번호를 입력한다.
	empno ename
	1000부터 시작 1001, 1002, 1003, 1004....
	
	학번 입력
	studId name
	C020001 시작 C02002, C02003, ....
	[단과코드][SEQUENCE] : 합성번호
	
	입력시 자동으로 NUMBERING 처리
	INSERT INTO 테이블 VALUES(SEQUENCE명.NEXTVAL,...)
	INSERT INTO 테이블 VALUES('C0'||SEQUENCE명.NEXTVAL,...)      --> 문자와 조합된 SEQUENCE 처리
	
	형식 : CREATE SEQUENCE 시퀸스명 
				START WITH N  			--> 시퀸스의 시작 번호를 지정. ex) 1로 지정하면 1부터 순차적으로 증가
				INCREMENT BY N			--> 시퀸스의 증감 단위 설정. ex) 2로 지정하면 2단위로 증가. -1로 지정하면 -1단위로 감소
				MAXVALUE N 				--> 시퀸스가 증가할 수 있는 최대값 설정. ex) 999999  1~999999 까지 데이터를 NUMBERING 처리 (NOMAXVALUE - 시퀸스 최대값을 무한대로)
	
	데이터 입력이나 활용시
		시퀸스명.NEXTVAL : 시퀸스를 증가시키며 현재값을 출력 (현재 시퀸스값의 다음 값을 반환)
		시퀸스명.CURRVAL : 시퀸스의 현재값을 출력 (현재 값을 반환)			
*/
-- ex) 시작값이 1이고 1씩 증가하고, 최대값이 999999인 시퀸스 exp01_seq를 만들어 보자 ##
	create sequence exp01_seq
		start with 1
		increment by 1
		maxvalue 999999;
	select exp01_seq.nextval from dual;		-- 호출할때 마다 NUMBERING 증가. 현재 서버의 유일한 NUMBER
	select exp01_seq.currval from dual;	    -- 현재 번호 호출.

-- ex) 학생테이블(student_seq_exp) 생성. no		이름
	create table student_seq_exp(
		no number constraint student_seq_exp_no_pk primary key,
		name varchar2(50)
	);	
	create sequence student_seq
		start with 1
		increment by 1
		maxvalue 999999;
	
	insert into student_seq_exp values( student_seq.nextval, '박길동'); 
-- 실행할 때마다 no가 1씩 증가하면서 데이터가 입력처리
	insert into student_seq_exp values( student_seq.currval, '김길동');
-- 현재 no 7까지 입력이 되있는데 CURRVAL로 입력할 경우 가장 최근에 입력한 시퀸스값을 입력하는 로직이기 때문에 입력이 불가(테이블 생성시 NO에 PK로 중복값 입력이 불가능하게 선언했기 때문)	
	commit;	
	select * from student_seq_exp;

/* 확인예제.
	1) emp_seq_exp 테이블 생성.(empno ename)
	emp_seq10 시퀸스 생성. 1000부터 시작.

*/	
	create table emp_seq_exp(
		empno number,
		ename varchar2(20)
	);
	create sequence emp_seq10
		start with 1000
		increment by 1;
	
	insert into emp_seq_exp values(emp_seq10.nextval,'김길동');

	insert into emp_seq_exp values(emp_seq10.currval,'홍길동'); 
-- 테이블 생성시 PK나 UNIQUE 제약조건을 걸지 않았기에 현재 시퀸스값을 재입력해도 입력이 됨(중복입력 가능)	
	select * from emp_seq_exp;	

/* 확인예제.
 2) COLLEGE 테이블 생성(studid, name)
 	college_seq 시퀸스 생성. C020001, C020002,...
*/	
	create table college(
		stuid varchar2(20),
		name varchar2(20)
	);
	
	create sequence college_seq
		start with 20001
		increment by 1;	
	insert into college values('C0'||college_seq.nextval, '김길동');
	select * from college;
	delete from college; 				-- 테이블에 입력된 데이터를 전부 날리고 시퀸스를 입력해도 초기화되서 1번부터 입력되는 것이 아니라 데이터를 날리기전 입력된 시퀸스 번호 이후부터 NUMBERING처리되어 입력됨.	
	
/*
 SEQUENCE 삭제
 형식 : DROP SEQUENCE 시퀸스명
 
 1) 시퀸스 생성: exp_seq
 2) 시퀸스 내용 딕셔너리에서 확인 : SELECT * FROM USER_SEQUENCES;
 3) 시퀸스 삭제 : DROP SEQUENCE 시퀸스명
 4) 시퀸스 내용 딕셔너리에서 재확인
*/	
	create sequence exp_seq
		start with 10
		increment by 10
		maxvalue 70;
	select * from user_sequences;
	drop sequence exp_seq;
	select * from college;
	delete from college;
	insert into college values(exp_seq.nextval,'김'); 
	insert into college values(exp_seq.currval,'김'); 
/* maxvalue(최대값)이 70까지이기 때문에 70까지 입력이 되면 nextval로는 입력 불가. currval일 경우 현재값인 70으로 계속 입력가능
   SEQUENCE는 변경된 CURRVAL값은 변경을 할 수 없기에 해당값을 원하는 값에서부터 시작하려면 DROP(삭제)시키고 START WITH부터 다시 설정해야한다.
   시퀸스 삭제 후 다시 생성해서 입력시엔 최대값까지 또 입력이 가능하다.
*/
	create sequence exp_seq
		start with 50			-- 원하는 CURRVAL값을 START WITH으로 할당한 후 해당 SEQUENCE 생성
		increment by 10
		maxvalue 70;
	select * from user_sequences where sequence_name='EXP_SEQ';
/*
 최대치가 너무 작고 넘버링 부분도 최대치 이후에 다시 초기값으로 변경하는 것이 필요한 경우 SEQUENCE 수정 처리
 
 형식 : ATLER SEQUENCE 시퀸스명
 			START WITH를 제외한 모든 옵션 설정 가능 

 넘버링 부분 최대치 이후 다시 초기값으로 시작 : CYCLE | NOCYCLE(default값) 			
 CACHE : 빠른 처리를 위해 메모리 설정 1보다 크게 설정하며 CYCLE옵션을 적용할 떄 설정해주는 것이 일반적이다.

 ex) exp_seq 시퀸스 설정 변경 
*/		
	alter sequence exp_seq
		minvalue 50  			-- 최소값. 최소값 조정시 입력된 NEXTVAL값이 조정하려는 값보다 작을 경우 에러발생. 반드시 조정하려는 값이 현재 NEXTVAL값보다 커야된다.
		maxvalue 100
		cycle
		cache 5;	
	select exp_seq.nextval from dual;

/* 확인예제.*/
-- 1. 초기값 1000, 최대값 2000, STEP 100인 시퀸스를 생성
	create sequence seq_ex1
		start with 1000
		increment by 100
		maxvalue 2000;
	
-- 2. 실행 및 확인
	select seq_ex1.nextval from dual;				    	
	select seq_ex1.currval from dual;

-- 3. DROP 시키고 초기값 1100로 다른 옵션은 위의 내용과 같은 시퀸스 생성
	drop sequence seq_ex1;
	create sequence seq_ex1
		start with 1100
		increment by 100
		maxvalue 2000;

-- 4. 변경.. 최소값 1100, 증가치 10, 최대값 2000, cycle옵션 설정
	alter sequence seq_ex1
		minvalue 1100
		increment by 10
		maxvalue 2000
		cycle;

				    	