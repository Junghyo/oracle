/*
 �������� ��� DML QUERY
 	1. ���� ���̺� ������ �Է��ϱ�.
		INSERT ������ ������ �Ἥ �����͸� �Է��ϴ� ��찡 ���� �����͸� �Է��� �� ���ŷ��� ��찡 �ִ�.
		�ѹ��� SUB QUERY�� ���ؼ� ���� ������ ������ ���̺� �Է��� �� INSERT ALL ������ Ȱ���ϸ� �ս��� ó���� �� �ִ�.
		
		1) ����
			INSERT ALL
				INTO ���̺�1�� VALUES(�÷�1, �÷�2, �÷�3)
				INTO ���̺�2�� VALUES(�÷�1, �÷�2, �÷�4)
				SELECT �÷�1, �÷�2, �÷�3, �÷�4 FROM �����͸� �ҷ��� ���̺�� WHERE ����				
*/
-- ex) emp���̺��� �����������̺� ����. emp_hir(empno, ename, hiredate) , emp_mgr(empno, ename, mgr)�� ����� deptno=20�� �����͸� �Է�ó��
	create table emp_hir as select empno, ename, hiredate from emp where 1=0;
	create table emp_mgr as select empno, ename, mgr from emp where 1=0;
	
	insert all
		into emp_hir values(empno, ename, hiredate)
		into emp_mgr values(empno, ename, mgr)
		select ename, empno, mgr, hiredate from emp where deptno=20; 

	select * from emp_hir h, emp_mgr m where h.empno=m.empno;

/*
 SUB QUERY�� �̿��� ������ �����ϱ�.
 UPDATE ���̺��
 	SET (�������÷�1, �������÷�2) = (SELECT �÷�1, �÷�2 FROM �����͸� �ҷ��� ���̺��) WHERE ����
*/
-- ex) 20�� �μ��� �������� 40�� �μ��� ���������� �����Ϸ��� �Ѵ�. SUB QUERY�� Ȱ���غ���
	create table dept01 as select * from dept;
	update dept01 set loc = (select loc from dept where deptno=40) where deptno=20;
	select * from dept01;
	update dept01 set (loc,dname) = (select loc, dname from dept where deptno=40) where deptno=20;
	select * from dept01;

-- Ȯ�ο���. ���̺� - emp ���纻 emp03 ����. job�� president�� sal�� deptno�� job�� clerk�� �����ͷ� �����ϼ���.
	create table emp03 as select * from emp;
	update emp03 set (sal,deptno) = ( select sal,deptno from emp where job='CLERK' and empno=7369 ) where job='PRESIDENT' ;
	select * from emp03;

/*
 MERGE ó��
 DATA MIGRATION(������ �̰�ó��) �Ҷ� ���� Ȱ��ȴ�.
 	���̺�A, ���̺�B�� �����͸� �̰�ó����, �μ��� �ٸ��� �ԷµǾ� �ִ� �����͵� �ְ�
 	�űԷ� �Է��ؾ� �� �����͵� ������ �ԷµǾ� �ִ� �����ʹ� Ư�� �÷��� ����ó���ؾ� �� ��쿡 ���� Ȱ��ȴ�.
 
 1) ���̺�A�� ������ ���̺�B���� ���� �����ʹ� INSERT ó��
  
 2) ���̺�A�� �ְ� ���̺�B���� ������ Ư���� �÷��� �����ϴ� ���� UPDATEó��
 ���� : MERGE INTO ���������̺��                     								 -- ���̺�B
 			USING �������̺� �Ǵ� ���������̺�	    								 -- ���̺�A
			ON ����ó�� 															 -- �Ϲ������� �� ���̺��� KEY��(�����÷�)�� �������� ó��. ex) ���̺�A.�����÷�=���̺�B.�����÷�
			WHEN MATCHED THEN 														 -- �ΰ��� ���̺� KEY�����Ͱ� �������� ������
				������Ʈ ���� ó��(UPDATE SET)
				UPDATE SET ���������̺��.�������÷�=�������������̺�.�÷� 			-- �ش� �����Ͱ� ������ ��� ex) ���̺�B.�����÷�=���̺�A.�÷�
				
			WHEN NOT MATCHED THEN 				     								-- ���� ���̺� �����Ͱ� ���� ��� ex) ���̺�A���� ������ ���̺�B���� ���� ���
				�Է� ���� ó��(INSERT VALUES)
				INSERT VALUES(�������������̺�.�÷�1, .....)						-- ex) INSERT VALUES(���̺�A.�÷���.....)		
*/

/* Ȯ�ο���.
emp01�� emp02 �����͸� �ε��ؼ� emp01�� ������ MERGEó��
1). EMP01 �������̺� �����
2). EMP02 �������̺� �����. JOB='MANAGER'��...
	EMP02 JOB�� TEST�� UPDATE (empno�� ���������� job�� �ٸ�)
	EMP02 �Է� 7935, 'ȫ�浿', 'SUPERMAN', 7839, SYSDATE, 4000, 100, 40	
*/
	create table emp01 as select * from emp;
	create table emp02 as select * from emp where job='MANAGER';
	update emp02 set job='test';
	insert into emp02 values(7935,'ȫ�浿','SUPERMAN',7839,sysdate,4000,100,40);
	
	merge into emp01 e1										-- ���������ʹ� emp01�� ó��
		using emp02 e2										-- emp02�����͸� �����
		on (e1.empno=e2.empno) 								-- �ش� key���� empno�� �ִ��� ���ο� ���� update/insert
		when matched then									-- empno���� ���� ��
			update set e1.job=e2.job							-- emp02.job�� test�� �����͸� emp01.job�� �ְڴ�.
		when not matched then								-- ������ empno���� ���� ���
			insert values(e2.empno, e2.ename, e2.job, e2.mgr, e2.hiredate, e2.sal, e2.comm, e2.deptno);
	
	select * from emp01;
	
/* Ȯ�ο���.
 �������̺� emp03
 �������̺� emp04 (deptno=30��)
 emp04 hiredate->sysdate (updateó��)
 emp04 (7370,'�����ɽ�','SUPERMAN',7839,sysdate,6000,400,40)�Է�
*/
	create table emp03 as select * from emp; 			
	create table emp04 as select * from emp where deptno=30;
	update emp04 set hiredate=sysdate;
	insert into emp04 values(7370,'������','SUPERMAN',7839,sysdate,6000,400,40);
	merge into emp03 e3
		using emp04 e4 on (e3.empno=e4.empno)
		when matched then
			update set e3.hiredate=e4.hiredate
		when not matched then
			insert values(e4.empno, e4.ename, e4.job, e4.mgr, e4.hiredate, e4.sal, e4.comm, e4.deptno);
	
	select * from emp03;
	select * from emp04;

			 			