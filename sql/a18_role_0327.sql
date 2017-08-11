/*
 ROLE이란?
 사용자에게 보다 효율적으로 권한을 부여할 수 있도록 여러개의 권한을 묶어 놓은 것을 말한다. 사용자를 생성하면 바로 사용할 수 있는 것이 아니라
 각종 권한을 부여받은 후에 사용이 가능한데 이를 ROLE을 통해서 손 쉽게 다양한 권한을 한번에 부여할 수 있다.

 ROLE의 종류
 1. CONNECT ROLE
 		주로 사용자가 데이터베이스에 접속할 수 있도록 하는 기본적인 데이터베이스의 권한이라고 할 수 있다.
	ex) ALTER SESSION, CREATE CLUSTER, CREATE DATABASE LINK, CREATE SEQUENCE, CREATE SESSION, CREATE SYNONYM, CREATE TABLE, CREATE VIEW

2. RESOURCE ROLE
		사용자가 객체(테이블, 뷰, 인덱스 등)를 생성할 수 있도록 권한을 묶는 것을 말한다.
	ex) CREATE CLUSTER, CREATE PROCEDURE, CREATE EQUENCE, CREATE TABLE, CREATE TRIGGER

3. DBA ROLE
		사용자가 데이터베이스 객체를 관리하고 사용자들을 작성, 변경 또는 제거할 수 있는 강력한 권한의 룰을 말한다.


ROLE의 활용 순서
1. 룰을 생성(데이터베이스 관리자)
		형식 : CREATE ROLE 룰의 이름  					ex) create role roleexp01;

2. 룰에 권한 부여	
		형식 : GRANT 권한1, 권한2, 권한3 TO 룰의 이름	ex) grant create session, create table, create view to roleexp01;

3. 사용자에 롤을 부여 ##
		형식 : GRANT 룰의 이름 TO 사용자				ex) grant roleexp01 to scott01;				
*/ 

/* 확인예제
1. 신규사용자 계정만들기(scott05)
2. role만들기(role02), 권한부여(resource 접근 권한)
3. scott05에 role 권한 부여 및 접근확인
*/
	create user scott05 identified by tiger;
