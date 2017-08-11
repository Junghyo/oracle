/*
 �������� �߰��ϱ�
 ALTER TABLE ���̺��
 ADD CONSTRAINT ���̺��_�÷���_�������Ǵ��� ������������(�÷���);
 ex) �������� UNIQUE     -- NOT NULL�� �Ұ�
*/

-- �������� �߰�, ����, ���� ����
-- 1. address ���̺� HOST�÷��� UNIQUE ���������� �߰�
	alter table address add(host varchar2(20));
	alter table address add constraint address_host_u unique(host);

-- 2. ������ ��ųʸ����� Ȯ��.
	select * from user_constraints where table_name='ADDRESS';

-- 3. HOST�÷��� ���������� ����
	alter table address drop constraint address_host_u;

/* 4. address ���̺� HOST�÷��� NOT NULL ������������ ����
 �������� ������ ���� ADD�� MODIFY�� ���� �ܿ��� �ִ�.
 NOT NULL�� ���� ADD�� ���������� ����� �� ���� MODIFY�� Ȱ���ؾ� �Ѵ�
 	ALTER TABLE ���̺�� MODIFY �÷��� CONSTRAINT �������Ǹ� ������������(ex- NOT NULL);
*/
	alter table address modify host constraint address_host_c not null;
-- ���� host�÷��� null���� �����ϱ� ������ not null ���������� ������ ���� ����.
	update address set host='��浿';
-- host�� null���� ��浿���� �����߱� ������ not null �������� ���𰡴�
	alter table address modify host constraint address_host_c not null;	
-- 5. ������ ��ųʸ����� ��Ȯ��.
	select * from address;

/*
 Ȯ�ο���.
 1. EMP���̺��� �������̺� EMP07 ����.
 2. ENAME�÷��� UNIQUE �������� ����.
 3. �� �������� ����
 4. ENAME �÷��� �������� NOT NULL�� ����.
*/	

	create table emp07 as select * from emp;
	alter table emp07 add constraint emp07_ename_u	unique(ename);
	select * from user_constraints where table_name='EMP07';
	select * from emp07;
	alter table emp07 drop constraint emp07_ename_u;
	alter table emp07 modify ename constraint emp07_ename_c not null; 

/*
 �������� Ȱ�� �� ��Ȱ��ȭ ó�� : ���������� �ӽ������� ��Ȱ��ȭ �����ν� �����͸� TEST�ϰų� Ư���� �Ⱓ�� ���������� ���� �ʴ� ������ �Է��ϰ� ó���ϴ� ���� ���Ѵ�.
 
 ���� : ALTER TABLE ���̺�� ENABLE/DISABLE CONSTRAINT �������Ǹ�;
*/

-- ex) ���̺� EMP07�� emp07_ename_c�� ��Ȱ��ȭ ó���Ѵ�.
	alter table emp07 disable constraint emp07_ename_c;	
	select * from user_constraints where table_name='EMP07';    -- STATUS �÷� �κ� Ȯ��(DISABLED)

-- ex) emp07_ename_c Ȱ��ȭ ó��
	alter table emp07 enable constraint emp07_ename_c;
	select * from user_constraints where table_name='EMP07';   -- STATUS �÷� �κ� Ȯ��(ENABLED)	