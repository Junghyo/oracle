/*
 NOT NULL ��������
 	�ش� �÷��� �����Ͱ��� �ݵ�� �Է��� �Ǿ�� ó���ǰԲ� ����.	
*/
-- notnull_ex ���̺� ����. (empno,ename,job) not null����
	create table notnull_ex(
		empno number not null,  	-- �������� not null ����(�����Ͱ��� �ݵ�� �Էµǰ�)
		ename varchar2(20) not null,
		job varchar2(20)
	);
	
-- null_ex ���̺� ����. (empno,ename) 	
	create table null_ex(
		empno number,
		ename varchar2(20),
		job varchar2(20)
	);	
	
-- ���̺��� ����� �����͸� �Է�, ������ �� � ������ �ִ��� Ȯ��
	select * from notnull_ex;
	select * from null_ex;
-- 1) �����͸� �Է½�, ������ null�� �Է�.
-- 		# notnull_ex ���̺� ���
	insert into notnull_ex values('10','','����');
	insert into notnull_ex values('0',null,'����');
	insert into notnull_ex values('','��','����');
	insert into notnull_ex(job) values('����'); 
-- null���� �������� ���� �÷��� �����ϰ� �����Ͱ��� �Է��� �õ��ص� ó���� �ȵ�. not null ������ �ɾ�� empno�� ename �����Ͱ��� �ݵ�� �Է��ؾ� �Ѵ�.
	insert into notnull_ex values('1', '��', '����');
	insert into notnull_ex values('2','null','���̽�');
	insert into notnull_ex values('3','��',null);
	insert into notnull_ex values(4,'��','');
	insert into notnull_ex(empno,ename) values(5,'��');	
--	'' ���̿� �� null�� null���� �ƴ� null�̶�� ����ó��. job�� ''�� �����̳� null���� ��� �Է�ó�� ���� 

--	  # null_ex ���̺� ��� 
	insert into null_ex(job) values('����');
	insert into null_ex values('10','','����');
	insert into null_ex values('0',null,'����');
	insert into null_ex values('','��','����');
	insert into null_ex(empno,ename)   values('',null);   
-- ó������. �Է� �ȵ� �÷��� �����Ͱ��� null�� ǥ��	