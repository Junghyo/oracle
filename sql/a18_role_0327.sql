/*
 ROLE�̶�?
 ����ڿ��� ���� ȿ�������� ������ �ο��� �� �ֵ��� �������� ������ ���� ���� ���� ���Ѵ�. ����ڸ� �����ϸ� �ٷ� ����� �� �ִ� ���� �ƴ϶�
 ���� ������ �ο����� �Ŀ� ����� �����ѵ� �̸� ROLE�� ���ؼ� �� ���� �پ��� ������ �ѹ��� �ο��� �� �ִ�.

 ROLE�� ����
 1. CONNECT ROLE
 		�ַ� ����ڰ� �����ͺ��̽��� ������ �� �ֵ��� �ϴ� �⺻���� �����ͺ��̽��� �����̶�� �� �� �ִ�.
	ex) ALTER SESSION, CREATE CLUSTER, CREATE DATABASE LINK, CREATE SEQUENCE, CREATE SESSION, CREATE SYNONYM, CREATE TABLE, CREATE VIEW

2. RESOURCE ROLE
		����ڰ� ��ü(���̺�, ��, �ε��� ��)�� ������ �� �ֵ��� ������ ���� ���� ���Ѵ�.
	ex) CREATE CLUSTER, CREATE PROCEDURE, CREATE EQUENCE, CREATE TABLE, CREATE TRIGGER

3. DBA ROLE
		����ڰ� �����ͺ��̽� ��ü�� �����ϰ� ����ڵ��� �ۼ�, ���� �Ǵ� ������ �� �ִ� ������ ������ ���� ���Ѵ�.


ROLE�� Ȱ�� ����
1. ���� ����(�����ͺ��̽� ������)
		���� : CREATE ROLE ���� �̸�  					ex) create role roleexp01;

2. �꿡 ���� �ο�	
		���� : GRANT ����1, ����2, ����3 TO ���� �̸�	ex) grant create session, create table, create view to roleexp01;

3. ����ڿ� ���� �ο� ##
		���� : GRANT ���� �̸� TO �����				ex) grant roleexp01 to scott01;				
*/ 

/* Ȯ�ο���
1. �űԻ���� ���������(scott05)
2. role�����(role02), ���Ѻο�(resource ���� ����)
3. scott05�� role ���� �ο� �� ����Ȯ��
*/
	create user scott05 identified by tiger;
