/* Ȯ�ο���
1. �űԻ���� ���������(scott05)
2. role�����(roleexp02), ���Ѻο�(resource ���� ����)
3. scott05�� role ���� �ο� �� ����Ȯ��
*/

	create user scott05 identified by tiger;
	create role roleexp02;
	grant create cluster, create trigger, create sequence, create type, create procedure, create operator, create indextype, create table to roleexp02;
	grant roleexp02 to scott05;
	SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE IN('CONNECT', 'RESOURCE');