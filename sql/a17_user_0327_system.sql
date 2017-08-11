/*
 ## 사용자 계정으로 접속하는 방법
 	1) CMD에서 접속하는 방법 
		sqlplus system/1111 또는 sqlplus scott/tiger
	
	2) SQL COMMAND LINE에서 접속하는 방법
		sql> conn 계정명/비밀번호

 ## 여러가지 CLIENT	툴을 이용해서 접근 주요 핵심 정보
 IP / PORT번호 / SID / 계정-비밀번호	
*/

/*
 사용자 생성하기  (system 계정 worksheet에서 처리)
 CREATE USER 사용자명 IDENTIFIED BY 패스워드;
 ex) scott01이란 계정에 비밀번호를 tiger로 설정하여 생성.
*/
	create user scott01 identified by tiger;

/*
 권한 부여
 	1. SESSION : 접속에 관련된 권한 부여
		형식 : GRANT 권한종류 TO 사용자계정  		-- 생성된 계정으로 바로 접속할 수 있는 것이 아니라 해당 계정에 접속 권한을 설정해야지 접속이 된다.
*/	
-- ex) scott01 계정에 접속권한을 설정해 준 뒤에 접속을 해보자.
-- system 관리자 계정으로 접속한 뒤에
	grant create session to scott01; 	-- 접속할 session 권한을 scott01에 준다.

/*
 테이블 스페이스
 데이터베이스 생성시, 각종 오브젝트(테이블, 인덱스, 뷰 등)가 실제 데이터 파일에 저장되는 물리적 공간이고 사용자와 매핑해서 테이블 스페이스 즉, 물리적 공간 파일을 매핑할 수 있다.
 1. 생성 형식 ##
 	CREATE TABLESPACE 테이블스페이스명 DATAFILE '물리적파일이 있는 위치' SIZE 크기설정 (ex - 10M)
	DEFAULT STORAGE(물리적 크기에 설정 초기 및 BLOCK단위 별 증가 크기)
	INITIAL 크기 : 초기 크기설정 (테이블 스페이스의 맨 첫번째 Extents의 크기)
	NEXT 크기 : 증가되는 크기설정 (다음 Extents의 크기)
	MAXENXTENTS : 최대 증가의 크기 (생성할 Extents의 최대값)
	PCTINCREASE : Extents의 증가율, default값은 50
*/	

/* ex) 테이블 스페이스 이름 ts01로 하고 C:\a01_prog\database 폴더생성 
파일명:DF001.DBF01
크기는 50M
INITAL : 1024K
NEXT : 512K
최대증가크기 MAXEXTENTS : 128
PCTINCREASE : 0
*/
	create tablespace ts01 datafile 'C:\a01_prog\database\DF001.DBF01' size 50m
	default storage(
		initial 1024k
		next 512k
		maxextents 128
		pctincrease 0
	);	

/* 특정한 테이블 생성시, 지정된 테이블스페이스와 매핑.
 CREATE TABLE 테이블명()
 	TABLESPACE 지정된테이블스페이스명;

 default 테이블스페이스 지정.
 ALTER DATABASE default TABLESPACE 지정한테이블스페이스명;
*/	
	select * from user_tables where table_name like '%EMP%'; -- 현재 사용자 테이블의 정보 부분
	create table tsexp(no number primary key) tablespace ts01;
	select * from user_tables where table_name like '%TSEXP%';