/*
 SUB QUERY : �ϳ��� SELECT������ �� �ȿ� ���Ե� �� �ϳ��� SELECT ������ ���Ѵ�.
			 ���������� �����ϰ� �ִ� �������� ��������(MAIN QUERY), ���Ե� �� �ϳ��� ������ ��������(SUB QUERY)��� �Ѵ�.

ex) EMPNO���̺��� ������ �ְ�� ���� ����� �̸��� ������ LIST�ϼ���.
 	SELECT ENAME, SAL FROM EMP					 	--> ��������
		WHERE SAL = ( SELECT MAX(SAL) FROM EMP ) 	--> ��������

# �ۼ��� ������
	1. ���������� �� ������(=, >, <...)�� �����ʿ� ����ؾ� �ϰ� ��ȣ�� �����ִ� ���� �Ϲ����̴�.
	
	2. ���������� ���������� ����Ǳ� ������ ����ȴ�. �������� ���� ó�� -> �������� ó��
	
# ���������� ����
	1. ������ ������ ó���Ǵ� ���.
		SELECT * FROM ���̺�� WHERE �÷��� = ( SELECT �÷��� FROM ���̺�� WHERE ���� )
			- ���ϰ� ���� : =, >, <....(�񱳿����� Ȱ��)
			- ���߰� ���� : IN, EXIST, ANY, ALL....
	
	2. ���̺� ��ü�� SUB QUERYó�� ����
		SELECT * FROM ( SELECT �÷���1, �÷���2, �Լ�(�÷���3) FROM ���̺�� WHERE ���� ) WHERE ����
		SELECT �÷���1+�÷���2, .... FROM ( SELECT �÷���1, �÷���2, �Լ�(�÷���3) FROM ���̺�� WHERE ���� ) WHERE ���� 
	
	3. ��Į�� ��������
		SELECT ( SELECT �÷���1 FROM ���̺�� WHERE ����=��������1), �÷���2, �÷���3 FROM ���̺�� WHERE ���� 			 					
*/

-- 1. ���ǰ����� SUB QUERY�� ���Ǵ� ���(���ϰ�)
-- ex) ��տ������� ���� ������� �̸��� ������ ����ϼ���.
	select ename �̸�, sal ���� from emp where sal> ( select avg(sal) from emp );

-- ex) ���ʽ��� �ִ� ����� �߿��� �ְ��� ����� �̸��� ������ ���ʽ��� ����ϼ���.
	select ename �̸�, sal ����, comm ���ʽ� from emp where comm = ( select max(comm) from emp where comm is not null );

-- ex) ��� ���ʽ����� ����  ����� �̸��� ������ ���ʽ��� ����ϼ���.
	select avg(comm) from emp where comm is not null;  -- null���� �����ϰ� ó��
	select ename �̸�, sal ����, comm ���ʽ� from emp where comm >= (select avg(comm) from emp where comm is not null );
	select avg(nvl(comm,0)) from emp;  -- null���� 0�� �Է��Ͽ� ó��
	select ename �̸�, sal ����, comm ���ʽ� from emp where comm >= (select avg(nvl(comm,0)) from emp );	
	
-- Ȯ�ο���
-- 1). �μ���ȣ�� ���� ���� ����� �̸��� �μ���ȣ�� ����ϼ���.
	select ename �̸�, deptno �μ���ȣ from emp where deptno = ( select max(deptno) from emp );
	
	select e.ename �̸�, d.dname �μ��� from emp e, dept d where e.deptno=d.deptno and e.deptno=(select max(deptno) from emp);

-- 2). ���� �ֱٿ� �Ի��� ����� �̸��� ��å, �Ի����� ����ϼ��� 
	select ename �̸�, job ��å, hiredate �Ի��� from emp where hiredate = ( select max(hiredate) from emp );

-- 1-2. SUB QUERY�� ������� 2�� �̻��� ���
-- SUB QUERY�� ������� �ΰ� �̻� ���� ��� �ش� �÷��� ������ �´� �÷��� �����Ͽ� ���ó���� �����ϰ� �Ѵ�. (�÷�1, �÷�2) IN ( SELECT �÷�1, �Լ�(�÷�2) FROM .... )	

-- ex) �μ����� �Ի����� �ְ��� ������� �̸��� �Ի����� ����ϼ���.
	select deptno, max(hiredate) from emp group by deptno;

-- 1) ���� ���ǿ� ���� ó��
-- IN ������ SUB QUERY�� �־ �ش��ϴ� ������ ������ ������ ó���� �� �ִ�.
	select * from emp where deptno in(10, 20); 
	select * from emp where deptno in( select deptno from emp where deptno<30);

-- ������ 3000, �׸��� �μ���ȣ 20
	select * from emp where sal=3000 and deptno=20;	

-- DEPTNO, HIREDATE�� ������ �Ѵ� SUB QUERY�� ���ؼ� ó���� ���.
	SELECT ENAME, DEPTNO, HIREDATE FROM EMP WHERE (DEPTNO, HIREDATE) IN ( SELECT DEPTNO, MAX(HIREDATE) FROM EMP GROUP BY DEPTNO );	



-- Ȯ�ο���.
-- 1. ��å���� ���� ���� ������ �޴� ����� �̸�, ��å, ������ ����ϼ���.
	select ename �̸�, job ��å, sal ���� from emp where (job, sal) in ( select job, min(sal) from emp group by job );
	select ename, job, sal from emp order by job, sal;
	select job, min(sal) from emp group by job;

/* ����1. (homework 1)
 1. �Ի��� �б⺰�� ���� ���� ������ �޴� ����� ����ϼ���.
 2. ������ 3000 �̻��� ��� �߿� ���(���̺� Ȱ�뵵 ����)�� ����� �ش� ��޺� �ְ� ������ �޴� ����� �̸�, ��� ������ ����ϼ���.
*/ 	

/* EMP���̺��� �μ���ȣ 30�� �Ҽ� ����� �߿��� �޿��� ���� ���� �޴� ������� ���� �޿��� �޴� ����� �̸��� �޿��� ����ϼ���.
 1) 30�� �Ҽ� ����� �߿��� �޿��� ���� ���� �޴� ���  --> GROUP �Լ� �̿�.
 2) ��ü�����͸� SUBQUERY��  �ε��Ͽ� ���
 		== ALL, ANY..(SUB QUERY)
			ALL : SUB QUERY�� ��� ������ ��ġ�� ��
			ANY, SOME : SUB QUERY�� ������� �ϳ� �̻� ��ġ�ϸ� 
*/ 
 -- �μ���ȣ 30���� ��� ��� �������� ū ����鸸 list
	select ename, sal, deptno from emp where sal >= all( select sal from emp where deptno=30 );
-- �μ���ȣ 30���� ����� �߿��� �ƹ��� ������ ũ�⸸ �ϸ� list(30�� ������� ������ ���� ���� ����� JAMES 950�ε� �� ������� ������ ������ ������ list)
	select ename, sal, deptno from emp where sal >= any( select sal from emp where deptno=30 );

	select ename, sal, deptno from emp where sal> ( select max(sal) from emp where deptno=30 group by deptno );
	select * from emp;

-- Ȯ�ο���. ������ 3000�̸��� ��� �߿� �ֱٿ� �Ի��� ����� �����ȣ, ����, �Ի����� ����ϼ���.
	select ename, empno, sal, hiredate from emp where hiredate >= all( select hiredate from emp where sal<3000 );

-- ����2.(homework2)
-- 1. �μ���ȣ�� 30�� ����߿� ���� ���߿� �Ի��� ������� ������ ������ ����ϼ���
-- 2. ��å�� SALESMAN�� ����� �޴� �޿����� �ּ� �޿����� ���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ 20���� ����� �����Ѵ� (ANY ������ �̿�)
 	
/*
 WHERE EXISTS(SUB QUERY) : �ش� SUB QUERY���� �����Ͱ� �ִ��� ���θ� üũ�ؼ� ���� SQL�� ó���ϰ��� �Ҷ� Ȱ��
 						   Ư�� ���ǿ� ���ؼ� ��ü ������ �ε� ���θ� Ȯ���ϰ��� �� �� Ȱ�� 
 ex) �μ���ȣ�� 30�� �����Ͱ� ������ ��ü ������̺��� list�ϼ���. (�μ���ȣ 30���� ������ ������̺��� list �ε� �ȵ�)
*/		
	select * from emp where exists(select * from emp where deptno=30);
	select * from emp where exists(select * from emp where deptno=40); -- list ó���� �ȵ�

-- Ȯ�ο���. �����ڹ�ȣ�� ������ �߿� null���� ������ �̸�, �����ڹ�ȣ, ��å�� ����ϰ��� �Ѵ�.
	select ename, mgr, job from emp where exists( select * from emp where mgr is null );

/*
 ���������� Ȱ���� ���̺� ����, ������ �Է�, ����, ����..
 
 1. ���̺� �����ϱ�
 	1) ������ + ����
		CREATE TABLE �������̺�� AS SELECT �÷�1, �÷�2 FROM �������̺� WHERE ����..
*/
-- ex) EMP���̺��� ������ 2000 �̻��� ������ �߿� �����ȣ(no), �����(name), ����(salary)�� EMP001�� ������� �Ѵ�.		

	create table emp01 as select empno no, ename name, sal salary from emp where sal>=2000;
	select * from emp01;

-- ex) EMP���̺��� ������ 2000 �̻��� ������ �߿� �����ȣ(no), �����(name), ����(salary), �μ��̸�(dname)���� EMP001�� ������� �Ѵ�.(JOIN ����)		
	create table emp02 as select e.empno no, e.ename name, e.sal salary, d.dname from emp e, dept d where e.deptno=d.deptno and sal>=2000;
	select * from emp02;

-- Ȯ�ο���. emp, salgrade�� Ȱ���Ͽ� ������ ���� �ű� ���̺��� �����ϼ���.
-- ������ 1000�̻� �Ǵ� �����͸� �����(name), �μ���ȣ(partno), ����(salary), �޿����(salgrade)�� �� empgrade ���̺��� ����
	create table empgrade
		as select e.ename name, e.deptno partno, e.sal salary, g.grade grade from emp e, salgrade g
		where sal>=1000 and (e.sal between g.losal and g.hisal);
	select * from empgrade;

/* ����3. (homework 3)
 ������ ���� ������ ���̺� NEW_EMP�� �����ϼ���.
 �̸�(name), ��ȣ(no), �Ի���(credate)-���ڿ�(@@@@�� @@@�� @@@��) ���ر��رٹ�����(workyears)
*/
	create table new_emp
		as select ename name, empno no, to_char(hiredate, 'YYYY"��" MM"��" DD"��"') credate, to_number(to_char(sysdate, 'YYYY'))-to_number(to_char(hiredate,'YYYY')) workyears from emp; 
	select * from new_emp;

/*
 �������� ������ �����ϰ��� �� �� (���� ���̺��� ���� �����ʹ� �������� �ʰ� �÷� �� DATA-TYPE�� �����ϰ��� �� ���)
 ���� ���̺� WHERE 1=0 ���ǹ����� �����͸� �ʱ�ȭ �� �� ���̺� ����
*/		 
	select * from emp where 1=0;
	create table emp_structor as select * from emp where 1=0;
	select * from emp_structor;	
	
	
	