/* 확인예제
1. 신규사용자 계정만들기(scott05)
2. role만들기(roleexp02), 권한부여(resource 접근 권한)
3. scott05에 role 권한 부여 및 접근확인
*/

	create user scott05 identified by tiger;
	create role roleexp02;
	grant create cluster, create trigger, create sequence, create type, create procedure, create operator, create indextype, create table to roleexp02;
	grant roleexp02 to scott05;
	SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE IN('CONNECT', 'RESOURCE');