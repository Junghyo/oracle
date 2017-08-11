/*
 �������� ������ �����ϰ��� �� �� (���� ���̺��� ���� �����ʹ� �������� �ʰ� �÷� �� DATA-TYPE�� �����ϰ��� �� ���)
 ���� ���̺� WHERE 1=0 ���ǹ����� �����͸� �ʱ�ȭ �� �� ���̺� ����
*/		 
	select * from emp where 1=0;
	create table emp_structor as select * from emp where 1=0;
	select * from emp_structor;	
	
/*
 ���������� �̿��� ������ �߰�.
 INSERT ������ SELECT�� ȥ���ؼ� ������ �Է� ó���� ����
 
 ���� : INSERT INTO ���������̺�� SELECT [�����÷���] FROM ���������̺�� WHERE ����;   -- �ش� SQL�� ���� ������ �����͸� �ѹ��� �Է��� �� �ִ�.
 		������ ��) ���������̺��� �÷��� SELECT [�����÷���]�� �÷� ������ TYPE�� �����Ͽ��� �Ѵ�.
*/
	select * from emp_structor;
-- EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO 
	insert into EMP_STRUCTOR select * from emp where sal>=3000;	

-- �÷� ���� �� ����. 
-- ���� : INSERT INTO ���������̺��(�÷�1, �÷�2, �÷�3) SELECT �÷�1, �÷�1+�÷�2, �Լ�(�÷�3) FROM ���������̺�� WHERE ����;
	insert into emp_structor(comm) select empno-mgr from emp;
	select * from emp_structor;
	truncate table emp_structor;
	insert into emp_structor(empno, sal, ename) select empno, sal+nvl(comm,0), rpad(ename,7,'^^') from emp;

/* Ȯ�ο���. dept_sub ���̺��� ����(dept ���̺� �̿�). �߰��÷� : kdname(�ѱ��̸�), membercnt(��ϵ� �ο�)
	1) ������ �ִ� �������̺� ����
	2) dept���̺��� �̿��ؼ� ���������Ϳ� �߰��� �����͸� �Է��ϼ���.
		-ó�� : �ѱ��̸�-����, membercnt=0	

*/	
	create table dept_sub as select deptno, dname, loc, '           ' kname, 0 membercnt from dept where 1=0;
	insert into dept_sub select deptno, dname, loc, '����' kdname, 0 membercnt from dept;
	select * from dept_sub;
	truncate table dept_sub;
	select * from dept;

-- kdname�� ���� ó��. 
-- DECODE(deptno,10,'ȸ��', 20,'����', 30,'����', 40,'�', '����') kname          -- �μ���ȣ�� ���� ��å�ο�

/* membercnt�� ���� ó��                
	emp���̺� �����͸� Ȯ���ؼ� ó��
	(SELECT COUNT(*) FROM EMP WHERE deptno=d.deptno) membercnt                   -- emp���̺� ������� �μ����� ī����
	
*/	
	insert into dept_sub
		select deptno, dname, loc, decode(deptno,10,'ȸ��', 20,'����', 30,'����', 40,'�', '����') kname, (select count(*) from emp where deptno=d.deptno) membercnt from dept d;
	
	select count(*) from emp e ,dept d where e.deptno=d.deptno group by e.deptno;	/* �̺κ� ��¥ �𸣰ڳ�  �ٽ� üũ*/
	
-- 1�ܰ�
	select * from dept;

-- 2�ܰ�
	select a.*, decode(deptno,10,'ȸ��', 20,'����', 30,'����', 40,'�', '����') kname from dept a;


/*
 ���� �������� : �����ϴ� MAIN SQL������ SUB QUERY�� �ش� ������ ����� ó���ϴ� ���� ���Ѵ�.
 UPDATE ���̺�� SET �÷��� = ������ WHERE ���� -- ����
 UPDATE ���̺�� SET �÷��� = ������( SELECT �÷��� FROM ���̺� WHERE ���� ) WHERE ����  -- SUB QUERY ����
*/

-- ex) empno�� 7369�� ����� ���ʽ��� ��ü ���ʽ��� ����� �Ҵ��Ϸ��� �Ѵ�.
-- 	1) ��������	
	select avg(comm) from emp;
--	2) ��������
	update emp set comm =() where empno=7369;
--	3) ����	
	update emp set comm =(select avg(comm) from emp) where empno=7369;
	select * from emp;

/*
	Ȯ�ο���.
	1. emp_copy��� emp�� �������̺��� ����.
	2. emp_copy���� comm�� null���� �����Ϳ� sal�� ���������� �����ϼ���.
	
*/	
	create table emp_copy as select * from emp;
	update emp_copy set comm=( select min(sal) from emp_copy) where comm is null;
	select * from emp_copy;