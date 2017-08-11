/*
 ��(VIEW)
 	- ��� �⺻ ���̺��� �Ļ��� ��ü�� �⺻ ���̺� ���� �ϳ��� ��������������� �̷���� ������ ���̺�
	- ��� ���̺� ���� �������̺�ν� SELECT�� ��ȸ�� �����͵��� �������̺��̴�.
    - �������� �������� ���̺�� �޸� ������ ���� ������ ���� ������ �������̺��� ȣ���Ͽ� ���Ǳ� �����̴�.

 ������
 	1. �������� ���̺� ������ �����ϱ� ���ؼ� ���ȴ�.(���Ȼ��� ����)
		- ���̺��� �÷� ��� ������ ������ �÷��� ���Ȼ� ������ �Ұ����� �÷��� �ֱ⿡ �̿� ���� ȿ������ ���ѿ� ���� ����ó���� �ϱ� ���ؼ� ���ȴ�.
	
	2. ������ ���Ǹ� ���� ����� ���ؼ� ���ȴ�.
		- ���� ���̺� ���ļ� �����̳� ������ �Լ��� Ȱ���ؼ� ������� ������ ���, �� �����͸� �ٽ� Ȱ���ϱ⿡�� ������ ������ �߻��� �� �ִ�.
		  �� ��, ������븸 VIEW�� ����ٸ� ���� ȿ�������� �����͸� �ε��� �� �ְ� �ȴ�.
 
 ����
 	CREATE [OR REPLACE] VIEW ���̸� AS SUBQUERY(SQL);		   		
*/

-- ex) emp���̺��� �������̺�(emp01)�� ����� ���ο� emp_view01�� �����. �� view�� emp01���̺��� empno, ename, sal, depno�� list�ϵ� ��ȸ �������� deptno=30�� ��Ÿ���� �Ѵ�.
	create table emp01 as select * from emp;
	create or replace view emp_view01 as select empno, ename, sal, deptno from emp01 where deptno=30;

-- �����Ͱ� �߰�(INSERT)�� �����Ͱ� ����(UPDATE) ����	
	insert into emp_view01 values(8888,'ȫ�浿',1700,30);
	update emp_view01 set ename='himan' where empno=7900;
	select * from emp_view01;

-- �Է½� ������ �߻������� ������ ������ VIEW���� �����Ͱ��� �Է��� ���� ����
	insert into emp_view01 values(8888,'ȫ�浿',1700,40);
-- VIEW ������ DEPTNO�� 30�� �����͸� �������� ó���Ͽ��⿡ VIEW���� DEPTNO �����Ͱ��� 30�̿ܿ��� �Է��� ���� ����. �׷��� VIEW�� �������̺� EMP01���� �Է�ó���� ��.
-- 1) VIEW ���̺� Ȯ�� 2)�������̺� Ȯ��	
	select * from emp_view01;
	select * from emp01;
	
/* �ʱ⿡ VIEW�� ������ ��, �̿� ���� VIEW ���Ἲ Ȯ���� ���� VIEW ������ �ɼ��� ����.
	WITH CHECK OPTION
	VIEW�� ������, �ɼ� ����
	
	1. DROP VIEW EMP_VIEW01 	�����̺� ����
	2. WITH CHECK OPTION �� �ִ� �����
*/	
	drop view emp_view01;
	create or replace view emp_view01 as select empno, ename, sal, deptno from emp01 where deptno=30 with check option;
-- VIEW ���� �ܰ迡�� WHERE ������ �ɰ� WITH CHECK OPTION�� �� ��� WHERE ���ǿ� ���ݵǴ� �����Ͱ� �Է½� ���� �߻�.
	insert into emp_view01 values(8888,'ȫ�浿',1700,50);

/* Ư���� ������ �ִ� ������Ը� ����, ���� ������ ������ �Ʒ��� ���� �Ϲݻ���� ���ؼ��� READ ONLY ������ �ִ� VIEW�� Ȱ���ϰ� ������ �������� ������ ��ȭ�� �� �ִ�.
   WITH READ ONLY : �ַ� ��ȸ�� ó���ϴ� ���� �ʿ��� ������ �����ؼ� ���̺��� �˻��� �� Ȱ��ȴ�
	
	CREATE VIEW EMP_VIEW02 AS SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP01 WHERE DEPTNO=30
		WITH READ ONLY
	
	INSERT INTO EMP_VIEW02 VALUE(8890,'ȫ�浿',1700,30) -- ��� ������ �ȵ�.(WHERE ���ǿ� �������� �б� ���Ѹ� �־��⿡ ������ �Է� �� ����ó���� �ȵ�) 	
*/
	create or replace view emp_view02 as select empno, ename, sal, deptno from emp01 where deptno=30 with read only;
	insert into emp_view02 values(1234,'��ư��',2400,30);		
	select * from emp_view02;

-- Ȯ�ο���
-- 1. emp02 �������̺� ����
	drop table emp02;
	create table emp02 as select * from emp;

-- 2. ������ 3000�����̸� ��å�� SALESMAN�� �����̺� emp_view03����
	create or replace view emp_view03 as select * from emp02 where job='SALESMAN' and sal<=3000 with check option; 
	insert into emp_view03(job, sal) values('SALESMAN',2000); 
	insert into emp_view03(job, sal) values('SALESMAN',4000);	-- ��� �ȵ�(sal<=3000�� ����)
	select * from emp_view03;
	select * from emp02;
	 
-- 3. ���ʽ��� ���� �������̸� �˻��� ������ �����̺� emp_view04����
	create or replace view emp_view04 as select * from emp where comm is null with read only;
	insert into emp_view03(empno) values(1222);		-- ��� �ȵ�(with read only�� �˻��� �����ϰ� ������ �Է�, ���� �� ���� �Ұ�)
	
/*
 ���� VIEW
 	�ΰ� �̻��� �⺻ ���̺� ���� ���ǵ� �並 ���Ѵ�. �ַ� ������ ������ �ܼ��ϰ� ��Ÿ���� �� �ʿ䰡 ������ Ȱ��ȴ�.
	
 Ư¡
 	���պ�� �������̺�� Ű�� ���� ���εǾ� �ش� ������ Ű�� ���� �Է������� �� �� ���⿡ ���, ����, ������ �Ұ����ϴ�.
	ex) insert into emp03_dept_view values(8888,'ȫ�浿','�ѹ�'); 		-- �ԷºҰ�	
	
 ����
 	CREATE VIEW ���̸� AS SELECT A.�÷�1, A.�÷�2, B.�÷�1 FROM ���̺�1 A, ���̺�2 B WHERE A.�÷�=B.�÷� AND ����......	
*/
-- ex) ������ ������� emp03�� dept�� �����Ͽ� �����ȣ, ����̸�, �μ����� ����ϴ� VIEW�� ��������.
	create table emp03 as select * from emp;
	create or replace view emp03_dept_view as select e.empno �����ȣ, nvl(e.ename,'�����;���') ����̸�, d.dname �μ��� from emp e, dept d where e.deptno(+)=d.deptno;
	select * from emp03_dept_view;
	drop view emp03_dept_view; 
	