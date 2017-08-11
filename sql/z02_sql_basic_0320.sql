/*
 DDL(Data Definition Language) : ���̺� ���� ����, ���� �� �����ϴ� ���� ���Ѵ�.
 	1. CREATE TABLE : ���̺� ������ �űԷ� ����.
	2.  ALTER TABLE : ���̺� ������ ����
	3.  DROP TABLE  : ���̺� ������ ����(�÷� ����).
	4. ��Ÿ : TRUNCATE, RENAME ���̺�� 
*/

/* 1. CREATE TABLE : ���̺� ����
		CREATE TABLE ���̺� ��(�÷��� DATA-TYPE ��Ÿ��������,...);

 	DATA-TYPE
		1)   CHAR(size)   : ������ ���ڿ� ������Ÿ��. ���ڿ��� ũ�Ⱑ ������ ������ ū �����Ͱ� ���� �� ������ ���� �����ʹ� ������ ũ��� ����ȴ�.
		
		2) VARCHAR2(size) : ������ ���ڿ� ������Ÿ��. �������� �ִ�ũ�⸦ �����ϸ� �� ������ ������ ũ�Ⱑ ���������� ����� �� �ִ�.
		
		3) NUMBER(��ü�ڸ���, �Ҽ��������ڸ���) : ���ڸ� �����ϴ� ������Ÿ��.
			- NUMBER(����), NUMBER(����, 0) : ������ ������Ÿ��
			- NUMBER(����, 2) : �Ǽ��� ������Ÿ��. �Ҽ��� ��°¥������ ���尡��
		
		4) DATE : ��¥�� �����ϴ� ������Ÿ��.(��¥+�ú���)
		
		5) LONG : 4000byte �̻��� ���ڿ��� ���� �Ҷ� Ȱ��Ǵ� ������Ÿ��. �ְ�ġ 2GB
		
		6) LOB : 2G ���� ���̳ʸ�(��� ���������尡��) ������ ����.	
*/

-- 1. ���̺� �����ϱ�. CREATE TABLE ���̺��(�÷��� DATA-TYPE,..); 
-- ex) emp10�̶�� ���̺� �÷��� empno ������, ename ����������, sal �Ǽ������� ���̺��� ������� �Ѵ�.
	create table emp10( empno number(4), ename varchar2(20), sal number(7,2) );

/*
 ����2. (homework 2)
 login�� �ϴ� ȭ���� ����� id�� password�� üũ�ϰ�, ����ȭ�鿡�� 'id@@@�� ȯ���մϴ�. ���� point�� @@@�Դϴ�.' ��� ������ ��Ÿ���ٰ� �Ѵ�.
 �̿� �ʿ�� �ϴ� ���̺�� ���̺� ������ ���弼��.
*/	

-- 2. ���̺� ���� �����ϱ�

-- 1) ADD COLUMN : ���̺��� ���ο� �÷��� �߰� �� ��. ALTER TABLE ���̺�� ADD(�÷��� DATA-TYPE)
-- ex) emp10�� job�̶�� �̸����� ����������(9)�� ���� �÷��� ���� �߰��Ϸ��� �Ѵ�.
	alter table emp10 add(job varchar2(9));
	select * from emp10;

-- Ȯ�ο���. emp10�� ��¥�� ������ creatdate, �Ǽ���������(7,3)�� �߰��Ϸ��� �Ѵ�.
	alter table emp10 add( createdate date, sal12 number(7,3) );
	select * from emp10;
	
-- 2) MODIFY COLUNN : ���̺� �÷� ����. ALTER TABLE ���̺�� MODIFY(������ �÷��� DATA-TYPE);	
-- ex) emp10�� sal12�� ���������� �����ϰ��� �Ѵ�.
	alter table emp10 modify( sal12 varchar2(10) );
	select * from emp10;

/*
 ���̺��� DATA=TYPE ������ �Ѱ�
 	1. �ش� �÷��� �����Ͱ� �ִ� ���
		- �ٸ� DATA-TYPE���� ���� �Ұ�.
		- ���� DATA-TYPE�̶� ���� ũ�⺸�� ���� ������ ũ����� ������ �Ұ�. �÷��ȿ� 'HIMAN'�̶�� �����Ͱ� ���� �� 5���Ϸ� ���ϼ��� ����.
	2. �ش� �÷��� �����Ͱ� ���� ���
		- DATA-TYPE�� ũ�� ������ �����Ӵ�.
*/

-- 3) DROP COLUMN : ���̺��� �÷� ����. ALTER TABLE ���̺�� DROP COLUMN �÷���;
-- ex) emp10�� sal12 �÷��� �����Ϸ��� �Ѵ�.
	alter table emp10 drop column sal12;
	select * from emp10; 

-- 3. RENAME  
-- 1) ���̺� �� ����.	ALTER TABLE �������̺�� RENAME TO ���ο����̺��;
-- ex) ���̺�� emp10�� empxp10���� �����Ϸ��� �Ѵ�.
	alter table emp10 rename to empxp10;
	select * from empxp10;

-- 2) �÷��� ����.	ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO ���ο� �÷���;
-- ex) empxp10���� createdate�÷��� hiredate�� ���� ó��
	alter table empxp10 rename column createdate to hiredate;
	select * from empxp10;

-- Ȯ�ο���. dept01 ���̺��� dept10Exp��� ���̺�� �����ϰ� �÷��� loc�� location���� �����Ͻÿ�. ũ��� 13���� 25��.
	alter table dept01 rename to dept10Exp;
	select * from dept10Exp;
	alter table dept10Exp rename column loc to location;
	alter table dept10Exp modify( location varchar2(25) );
	select * from dept10Exp;

-- 4. DDL�� �������� ��� ���� ����. TRUNCATE TABLE ���̺��
-- ex) dept10Exp�� �ִ� ��� �����͸� DDL�� ���� ó��.
	truncate table dept10Exp;
	select * from dept10Exp;

-- 5. ���̺� ���� ��ü�� ����. DROP TABLE ���̺��;
-- ex) dept10Exp ���̺��� ������ �����ϼ���.
	drop table dept10Exp;
	select * from dept10Exp;

/*
 DROP
 ���̺��� ���� ��ü�� ������ ������
 ROLLBACK �Ұ���
 ���̺��� ����ߴ� Storage�� ��� Release

 DELETE
 �����͸� ����
 Commit �������� ROLLBACK�� ����
 �����͸� ��� DELETE�ص� ����ߴ� Storage�� Release ���� ����

 TRUNCATE
 ���̺��� ���� ������ �ʱ���·� ����
 ROLLBACK �Ұ���
 ���̺��� ����ߴ� Storage �� ���� ���̺� ������ �Ҵ�� Storage�� ����� Release

*/								