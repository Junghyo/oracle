/*
 제약조건 추가하기
 ALTER TABLE 테이블명
 ADD CONSTRAINT 테이블명_컬럼명_제약조건단축 제약조건유형(컬럼명);
 ex) 제약조건 UNIQUE     -- NOT NULL은 불가
*/

-- 제약조건 추가, 삭제, 수정 연습
-- 1. address 테이블에 HOST컬럼에 UNIQUE 제약조건을 추가
	alter table address add(host varchar2(20));
	alter table address add constraint address_host_u unique(host);

-- 2. 데이터 딕셔너리에서 확인.
	select * from user_constraints where table_name='ADDRESS';

-- 3. HOST컬럼의 제약조건을 삭제
	alter table address drop constraint address_host_u;

/* 4. address 테이블에 HOST컬럼을 NOT NULL 제약조건으로 변경
 제약조건 유형에 따라 ADD와 MODIFY를 쓰는 겨웅가 있다.
 NOT NULL의 경우는 ADD로 제약조건을 등록할 수 없고 MODIFY를 활용해야 한다
 	ALTER TABLE 테이블명 MODIFY 컬럼명 CONSTRAINT 제약조건명 제약조건유형(ex- NOT NULL);
*/
	alter table address modify host constraint address_host_c not null;
-- 현재 host컬럼에 null값이 존재하기 때문에 not null 제약조건을 선언할 수가 없다.
	update address set host='김길동';
-- host에 null값을 김길동으로 변경했기 때문에 not null 제약조건 선언가능
	alter table address modify host constraint address_host_c not null;	
-- 5. 데이터 딕셔너리에서 재확인.
	select * from address;

/*
 확인예제.
 1. EMP테이블의 복사테이블 EMP07 생성.
 2. ENAME컬럼에 UNIQUE 제약조건 설정.
 3. 위 제약조건 삭제
 4. ENAME 컬럼의 제약조건 NOT NULL로 변경.
*/	

	create table emp07 as select * from emp;
	alter table emp07 add constraint emp07_ename_u	unique(ename);
	select * from user_constraints where table_name='EMP07';
	select * from emp07;
	alter table emp07 drop constraint emp07_ename_u;
	alter table emp07 modify ename constraint emp07_ename_c not null; 

/*
 제약조건 활성 및 비활성화 처리 : 제약조건을 임시적으로 비활성화 함으로써 데이터를 TEST하거나 특정한 기간에 제약조건이 맞지 않는 내용을 입력하게 처리하는 것을 말한다.
 
 형식 : ALTER TABLE 테이블명 ENABLE/DISABLE CONSTRAINT 제약조건명;
*/

-- ex) 테이블 EMP07에 emp07_ename_c를 비활성화 처리한다.
	alter table emp07 disable constraint emp07_ename_c;	
	select * from user_constraints where table_name='EMP07';    -- STATUS 컬럼 부분 확인(DISABLED)

-- ex) emp07_ename_c 활성화 처리
	alter table emp07 enable constraint emp07_ename_c;
	select * from user_constraints where table_name='EMP07';   -- STATUS 컬럼 부분 확인(ENABLED)	