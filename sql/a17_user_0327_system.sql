/*
 ## ����� �������� �����ϴ� ���
 	1) CMD���� �����ϴ� ��� 
		sqlplus system/1111 �Ǵ� sqlplus scott/tiger
	
	2) SQL COMMAND LINE���� �����ϴ� ���
		sql> conn ������/��й�ȣ

 ## �������� CLIENT	���� �̿��ؼ� ���� �ֿ� �ٽ� ����
 IP / PORT��ȣ / SID / ����-��й�ȣ	
*/

/*
 ����� �����ϱ�  (system ���� worksheet���� ó��)
 CREATE USER ����ڸ� IDENTIFIED BY �н�����;
 ex) scott01�̶� ������ ��й�ȣ�� tiger�� �����Ͽ� ����.
*/
	create user scott01 identified by tiger;

/*
 ���� �ο�
 	1. SESSION : ���ӿ� ���õ� ���� �ο�
		���� : GRANT �������� TO ����ڰ���  		-- ������ �������� �ٷ� ������ �� �ִ� ���� �ƴ϶� �ش� ������ ���� ������ �����ؾ��� ������ �ȴ�.
*/	
-- ex) scott01 ������ ���ӱ����� ������ �� �ڿ� ������ �غ���.
-- system ������ �������� ������ �ڿ�
	grant create session to scott01; 	-- ������ session ������ scott01�� �ش�.

/*
 ���̺� �����̽�
 �����ͺ��̽� ������, ���� ������Ʈ(���̺�, �ε���, �� ��)�� ���� ������ ���Ͽ� ����Ǵ� ������ �����̰� ����ڿ� �����ؼ� ���̺� �����̽� ��, ������ ���� ������ ������ �� �ִ�.
 1. ���� ���� ##
 	CREATE TABLESPACE ���̺����̽��� DATAFILE '������������ �ִ� ��ġ' SIZE ũ�⼳�� (ex - 10M)
	DEFAULT STORAGE(������ ũ�⿡ ���� �ʱ� �� BLOCK���� �� ���� ũ��)
	INITIAL ũ�� : �ʱ� ũ�⼳�� (���̺� �����̽��� �� ù��° Extents�� ũ��)
	NEXT ũ�� : �����Ǵ� ũ�⼳�� (���� Extents�� ũ��)
	MAXENXTENTS : �ִ� ������ ũ�� (������ Extents�� �ִ밪)
	PCTINCREASE : Extents�� ������, default���� 50
*/	

/* ex) ���̺� �����̽� �̸� ts01�� �ϰ� C:\a01_prog\database �������� 
���ϸ�:DF001.DBF01
ũ��� 50M
INITAL : 1024K
NEXT : 512K
�ִ�����ũ�� MAXEXTENTS : 128
PCTINCREASE : 0
*/
	create tablespace ts01 datafile 'C:\a01_prog\database\DF001.DBF01' size 50m
	default storage(
		initial 1024k
		next 512k
		maxextents 128
		pctincrease 0
	);	

/* Ư���� ���̺� ������, ������ ���̺����̽��� ����.
 CREATE TABLE ���̺��()
 	TABLESPACE ���������̺����̽���;

 default ���̺����̽� ����.
 ALTER DATABASE default TABLESPACE ���������̺����̽���;
*/	
	select * from user_tables where table_name like '%EMP%'; -- ���� ����� ���̺��� ���� �κ�
	create table tsexp(no number primary key) tablespace ts01;
	select * from user_tables where table_name like '%TSEXP%';