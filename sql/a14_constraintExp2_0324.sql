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
	
-- 1) �����͸� �Է½�, ������ null�� �Է�.  ������ : INSERT INTO ���̺��(�÷����� ���)
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

-- 2). ����� null �� �Է�. INSERT INTO ���̺��( �÷��� ��ø� ���� ����)  VALUES(��ü�÷��� �� �����͸� ���) -- ��ü �÷��� ���� �Է��� ó���ϰڴ�.
	insert into null_ex values(null,null,'���α׷���2');
	insert into notnull_ex values(null,'��','����');
-- ��������� null���� �������Է��� ȣ���ϴ��� �÷��� �������ǿ� �ϳ��� ������ ���� ������ �Է��� ���� �ʴ´�.

/* ������ ��ųʸ�(DATA DICTIONARY)�� ���� CONSTRAINTS Ȯ���ϱ�
 USER_CONSTRIANTS : ��ü ���̺� ���� �������� ���� Ȯ���ϱ�
 
 CONSTRAINTS_TYPE : ���������� ������ ���� ������ �����ϴ� �κ�.
 	
	1) P : PRIMARY KEY -- �������ǿ� NOT NULL�� UNIQUE�� �����Ѵ�. ���� �������̺��� KEY�� �����ϴ� �÷�����.
 	
	2) R : FOREGIN KEY -- �ܷ�Ű. �ڽ����̺� �ش� �����͸� �Է��� �� ������ �θ����̺� �ش�Ǵ� �����Ͱ��� �ԷµǾ� �־�� ó���� �Ǵ� ���.
						  ex) DEPT(�θ����̺�)�� �÷��� DEPTNO�� �����Ͱ��� �����ؾ߸� EMP(�ڽ����̺�)�� DEPTNO�� �����Ͱ� �Էµ� �� �ְ� �ؼ� ���Ἲ�� ��ų �� �ִ�.
	
	3) U : UNIQUE -- ����Ű ����. �ش� �÷��� �����Ͱ� �ٸ� �÷��� �����Ϳ� ���ؼ� �ݵ�� �ϳ��� ������ �����Ͱ� �ǰ� �� �� �����ϴ� �ɼ�(�ߺ��� �Է� �Ұ�)
					 ex) DEPT���̺� �� DEPTNO�� �ش��ϴ� DNAME(�μ��̸�)�� �Է��� ���, ������ DEPTNO�� �ٸ� DNAME(�μ��̸�)�� �Էµǰ� �ϸ�
					 	 ������ ���Ἲ�� ������ �߻��ϱ⿡ ������ UNIQUE���������� �����Ͽ� ���Ἲ�� Ȯ���Ѵ�.	
	
	4) C : CHECK -- Ư���� �÷��� Ư���� �����͸� ������ ó���ϴ� ���� ������ ���Ѵ�. 
					ex) EMP�� �÷����� GENDER(����)�� �������� �� ������ F(����), M(����) �Է°��� �����ؼ� �ش� �÷��� F, M �����͸� �Է��� �ǵ��� ó���Ͽ� ���Ἲ�� Ȯ���Ѵ�.					 			  
*/
	select * from user_constraints;

/*
	UNIQUE ���� ���� :  ����Ű ���� ó��
	1. ���������̺����(EMP03)
	2. �÷��� ����Ű �����ϱ�(UNIQUE)
	3. ������ �Է� TEST - �����Ͱ� �����Ҷ�, � ������ �߻��ϴ��� Ȯ��
	4. ������ ��ųʸ����� �ش� ������� Ȯ���ϱ�.
*/	
	drop table emp03;
	create table emp03(
		empno number unique,             -- empno�� �����Ͱ� �ߺ��Է��� �����ʵ��� �������� ����
		ename varchar2(20),
		job varchar2(30)
	);
	
	select * from emp03;
-- �Է� ����	
	insert into emp03 values(1000,'���','���');
	insert into emp03 values(1001,'����','���̽�');
-- �Է� �Ұ�. empno�� UNIQUE ���� ������ �����߱� ������ ������ �Էµ� 1000���� �ߺ����� �Է��� �Ұ�.	
	insert into emp03 values(1000,'���̸�','4��Ÿ��');  

-- ������ ��ųʸ��� ���ؼ� ��������� Ȯ���� �� �ִ�.
	select constraint_name, constraint_type, table_name from user_constraints where table_name='EMP03';	

-- Ȯ�ο���. student��� ���̺� ����. �й�(unique), �̸�, �а� �÷� ����
	create table student(
		no number unique,
		name varchar2(20),
		major varchar2(20)
	);
	
	insert into student values(1,'����','�����а�');	
	insert into student values(2,'����','������а�');	
	insert into student values(3,'���','�����а�');	
	insert into student values(4,'���','������а�');
	select * from student;
	select constraint_name, constraint_type, table_name from user_constraints where table_name='STUDENT';

/* 
 ���������� ����� �����ϱ�(CONSTRAINT_NAME �̸� �����ϱ�)
	1. ���̺� ������, ����
		���� : CREATE TABLE ���̺��
					�������Ǽ������÷� DATA-TYPE 												-- ex) empno number
					CONSTRAINT �������Ǹ�(���̺��_�÷���_���������������) ��������			-- EX) constraint emp_empno_pk primary key
*/	
	create table emp05(
		empno number constraint emp_empno_pk primary key,
		ename varchar2(20)		
	);
	
	select * from user_constraints where table_name='EMP05';
	select * from emp05;
	
	create table emp06(
		empno number primary key,
		enmae varchar2(20)
	);
	select * from user_constraints where table_name='EMP06';
	
/*
 Ȯ�ο���.
 PROFESSOR ���̺� ����. PROID, NAME �÷� ����(NOT NULL, UNIQUE)
 UNIQUE�� ������ ��� �÷��� ���� INDEX�� �ڵ����� ����
*/	
	create table professor(
		proid varchar2(20) constraint professor_proid_notnull not null,
		name varchar2(20) constraint professor_name_unique unique
	);
	select * from user_constraints where constraint_name like '%NOTNULL%';
	select * from user_constraints where table_name='PROFESSOR';


/* �ΰ� �̻��� �÷����� ���������� �����ϴ� ���(����Ű)
 ������ �÷��� �Ѳ����� ���������� ���������� �ش� ���뿡 ���� KEY �÷��� �ű��ۼ��� �ʿ䰡 ���� �� Ȱ��ȴ�. ��, ���������� �ش� ���뿡 �Ѳ����� ó������ ������ ������ �߻�.
 ex) �л����̺��� KEY ������ �÷��� �űԷ� �����ϴ� ���� �ƴ϶�
 GRADE(�г�)	PART(��)	NO(��ȣ)	�̸�
 	
	����
		CREATE TABLE ���̺��(
			�÷���1 DATA-TYPE,
			�÷���2 DATA-TYPE,
			�÷���3 DATA-TYPE,
			CONSTRAINT �������Ǹ�(���̺�_�÷�����_���������������) ��������(�÷�1,�÷�2)
			);
 	
*/
	create table highschool(
		grade number,
		part number,
		no number,
		name varchar2(20),
		constraint highschool_dist_pk primary key(grade,part,no)		-- highschool���̺��� primary key�� 3���� �÷����� ���� ��� grade, part, no�� ���ÿ� �����ؼ� ������ �����Ͱ� �� ������ ó��.
	);	
	insert into highschool values(1,1,2,'��浿');
	insert into highschool values(1,2,3,'��浿');
	insert into highschool values(1,1,3,'��浿');
	insert into highschool values(1,2,1,'��浿');
-- grade,part,no(1,1,2)�� �̹� �ֱ� ������ �Է��� �ȵ�
	insert into highschool values(1,1,2,'�ξ���');
	insert into highschool values(1,2,3,'�ξ���');
	select * from user_constraints where table_name='HIGHSCHOOL';	
	select * from highschool;
	select * from user_constraints;

/* Ȯ�ο���
	ADDRESS��� ���̺� ����. 
	��/������ ��/���� �� ���� ������(PRIMARY KEY�� ��/������, ��/����, ��, ���� ����Ű�� ����)
*/	
	create table address(
		do varchar2(20),
		si varchar2(20),
		dong varchar2(20),
		bunzi varchar2(20),
		sedeju varchar2(20),
		constraint address_dist_pk primary key(do, si, dong, bunzi)
	);	
	
	insert into address values('����','���ı�', '������', 2, 3);
	insert into address values('����','���ı�', '���ĵ�', 2, 3);
	insert into address values('����','���ı�', '���ݵ�', 2, 3);
	insert into address values('����','���ı�', '���ݵ�', 1, 4);
	insert into address values('����','���ı�', '�ſ���', 1, 6);
	insert into address values('����','���ı�', '  ', 2, 16);
	select * from address;
	select * from user_constraints where table_name=upper('address');

/*
 2. ���������� ���� �����Ͽ� �����ϴ� ���
 	1) ���̺� ����
	2) ALTER TABLE ���̺��
			ADD CONSTRAINT �������Ǹ� ������������(�÷���)
			MODIFYT �÷��� CONSTRAINT �������Ǹ� ������������
			DROP CONSTRAINT �������Ǹ�
*/ 