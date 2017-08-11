/*
 ��(VIEW)
 	- ��� �⺻ ���̺����� �Ļ��� ��ü�� �⺻ ���̺��� ���� �ϳ��� ��������������� �̷���� ������ ���̺�
	- ��� ���̺��� ���� �������̺��ν� SELECT�� ��ȸ�� �����͵��� �������̺��̴�.
    - �������� �������� ���̺��� �޸� ������ ���� ������ ���� ������ �������̺��� ȣ���Ͽ� ���Ǳ� �����̴�.

 ������
 	1. �������� ���̺� ������ �����ϱ� ���ؼ� ���ȴ�.(���Ȼ��� ����)
		- ���̺��� �÷� ��� ������ ������ �÷��� ���Ȼ� ������ �Ұ����� �÷��� �ֱ⿡ �̿� ���� ȿ������ ���ѿ� ���� ����ó���� �ϱ� ���ؼ� ���ȴ�.
	
	2. ������ ���Ǹ� ���� ����� ���ؼ� ���ȴ�.
		- ���� ���̺��� ���ļ� �����̳� ������ �Լ��� Ȱ���ؼ� ������� ������ ���, �� �����͸� �ٽ� Ȱ���ϱ⿡�� ������ ������ �߻��� �� �ִ�.
		  �� ��, ������븸 VIEW�� ����ٸ� ���� ȿ�������� �����͸� �ε��� �� �ְ� �ȴ�.
 
 ����
 CREATE [OR REPLACE] VIEW ���̸� AS SUBQUERY(SQL);		   		
*/

-- ex) emp���̺��� �������̺�(emp01)�� ����� ���ο� emp_view01�� �����. �� view�� emp01���̺��� empno, ename, sal, depno�� list�ϵ� ��ȸ �������� deptno=30�� ��Ÿ���� �Ѵ�.
	create table emp01 as select * from emp;
	create or replace view emp_view01 as select empno, ename, sal, deptno from emp where deptno=30;
	select * from emp_view01;
	
	grant create view to scott;  -- scott������ view ���� ���� �ֱ�