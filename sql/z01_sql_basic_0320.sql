/*
 1. DML : Data Maniplulation Language
 	1) SELECT : ��ȸ�� ���.
	2) INSERT : ������ �Է½� ���.     INSERT INTO ���̺�� VALUES(������1, ������2, ������3);
*/
	select * from dept;
/*
 ���̺� �����ϱ�
 CREATE TABLE ���ο� ���̺�� AS SELECT * FROM ������ ���̺��;
*/
	create table dept01 as select * from dept;
	select * from dept01;

-- ������ �Է�1.  INSERT INTO DEPT01 VALUES(�÷�1������, '�÷�2������', '�÷�3������');	
	insert into dept01 values(50, '�ѹ���','����');
	select * from dept01;	
-- �̴�� �ϸ� �ٽ� ���ٰ� Ű�� �Էµ� �����Ͱ� ������. �׷��� �ٸ� ����ڵ� ����� �����͸� �� �� �ְ� �Ϸ��� Ȯ��ó��(COMMIT)�� ���־�� ��.	
	commit; 


-- ������ �Է�2.   INSERT INTO ���̺��(������ �÷���1, ������ �÷���2) VALUES(ù��° �Է��� ������, �ι�° �Է��� ������);
-- ex) DEPT01 ���̺��� DEPTNO 60�� �Է��Ѵ�. 
	insert into dept01(deptno) values(60);
	select * from dept01;
-- ex) DEPT01���̺��� DEPTNO 70�� LOC ��õ�� �Է��Ѵ�.	
	insert into dept01(deptno, loc) values(70, '��õ');
	select * from dept01;

/* 3) UPDATE : �ԷµǾ� �ִ� ������ ���� �߿��� ������ �ʿ��� �κ��� ����ó���Ѵ�.
		UPDATE ���̺�� SET �����ϰ��� �ϴ� �÷���1=������ ������1, �����ϰ��� �ϴ� �÷���2=������ ������2 WHERE �����ϰ����ϴ� ����(�÷���=���ǵ�����);
*/			
	select * from dept01;

-- ex) DEPT01�� DEPTNO�� 60�� �����͸� DNAME �λ�, LOC �������� ����ó��.	
	update dept01 set dname='�λ�', loc='����' where deptno=60;
	select * from dept01;

/* Ȯ�ο���
 1) EMP01�̶�� ���� ���̺��� ����� EMPNO�� ���� ���� ��ȣ���� +1�ؼ� ENAME�� JOB, SAL�� �Է��ϼ���.
 2) �׿��� ���̺�, MGR, HIREDATE(SYSDATE-���糯¥�� ����), DEPTNO�� 40���� ����ó���ϼ���.
*/		
	select * from emp;
	create table emp01 as select * from emp;
	select * from emp01;
	select max(empno)+1 from emp01;
	insert into emp01(empno, ename, job, sal) values(7935, 'ȫ�浿', 'SUPERMAN', 5000);
	update emp01 set mgr=7777, hiredate=sysdate, deptno=40 where empno=7935;
	commit;
	select * from emp01;

/* ����1. (homework 1)
 EMP03 �������̺� ����
 1. �Է� EMPNO�� ���� ���������� -1, MGR : CLERK�� MGR�Է�, SAL : ��տ���, COMM : ��ü COMM�� �հ�
 2. ���� ENAME : '�ű浿', JOB�� SUPERMAN, HIREDATE�� �ֱٿ� �Ի���+1
*/ 
	create table emp03 as select  * from emp;
	select * from emp03;
	select min(empno)-1 from emp03;
	select mgr from emp03 where job='CLERK';
	select avg(sal) from emp03;
	select sum(nvl(comm,0)) from emp03;
	insert into emp03(empno, mgr, sal, comm) values(7368, 7902, 2073.21, 2200);
	select * from emp03;
	select max(hiredate) from emp;
	update emp03 set ename='�ű浿', hiredate=to_date('01/12/1983','MM/DD/YYYY')+1, job='SUPERMAN' where empno=7368;
	select * from emp03;

/* 4) DELETE : Ư�� ������ �����͸� ����ó���ϴ� ����.
		DELETE [����] FROM ���̺�� WHERE ����[�÷���=���ǵ�����];
*/
	delete from dept01 where deptno=21;
	select * from dept01;

-- ex) DNAME�� 'SALES'�� �����͸� DEPT01���� �����ϼ���.
	delete from dept01 where dname='SALES';
	select * from dept01;

-- Ȯ�ο���. DEPTNO�� 50�̻��� �����͸� ��� �����ϼ���.
	delete from dept01 where deptno>=50;
	select * from dept01;

-- Ȯ�ο���. EMP01 ���̺� COMM�� null�̰� DEPTNO�� 20�� �����͸� �����ϼ���.
	delete from emp01 where comm is null and deptno=20;
	select * from emp01;

/* TRANSACTION : �����ͺ��̽����� ó���� �� ������ �ǹ�. �������� SQL������ �ϳ��� ���� �۾� ������ ó���ϴ� ���� �ǹ��ϱ⵵ �Ѵ�.
 
 TCL(Transatction Control Language) : �̷��� Ʈ������� �����ϱ� ���� ��ɾ�.
 
 COMMIT : �������� DML�� ���� ����, ����, �Էµ� ������ Ȯ��ó��.
 
 ROLLBACK : �����͸� COMMIT �ϱ� ���� ����, ����, �Էµ� ������ ����ó��. COMMIT�ϱ����� ���·� ���̺��� �ǵ���.
 
 SAVEPOINT : �����͸� Ư���������� ����ó���ϰ��� �� ��, ������ SAVE�ϴ� ���� ���Ѵ�.
*/
	select * from dept01;
-- ex 1) DEPT01���� DEPTNO 30 '�ѹ�' '����'�� �Է��� �Ŀ� ROLLBACKó���� �غ���.
	insert into dept01 values(30, '�ѹ�', '����');
	select * from dept01;
	rollback;
	select * from dept01;

-- ex 2) DEPT01���� DEPTNO 40 '�λ�' '����'�� �Է��� �Ŀ� COMMIT�ϰ� �������� ���� COMMIT�� ���� �ʰ� �������� ��� �������� ������ ���̸� Ȯ���Ѵ�.	
	insert into dept01 values(40, '�λ�', '����');
-- DB������ ���´�. (SCOTT���� DISCONNECT) �ܺο��� COMMIT�ϱ� ������ �����Ͱ� ���� ������ �ȴ�. TOOL�� ���� AUTOCOMMIT�� �߻��ϴ� ��찡 �ִ�.	
	select * from dept01;
	rollback;
	select * from dept01;								