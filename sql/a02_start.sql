-- �÷��� �̸�(����) ���̱�!!
	select * from emp;
-- empno�� ��Ī���� companyNo�� ����� �ߴ�. ����ϼ���.
-- �÷��� as ��Ÿ�� ��Ī�÷��� alias
	select empno as companyNo from emp;
	
-- ��Ī�� ���α׷� �������� �߿��� �ǹ̸� ������.
-- ��ټ� ���α׷��� ��Ī���� �����ϰ� ����ϴ� ��찡 ����.
-- ex) rs.getString("��Ī/�÷���")
-- as ��ſ� ����(' ')���� ó���Ѵ�.  select �÷��� ���� from emp;
	select '����� '||empno||'�Դϴ�!' show from emp;
	select deptno companyNo from emp;		
-- ���� application������ rs.getString("show")�� ó���ȴ�.
	select * from emp;

-- ������ ������ ����� �÷����� ��Ÿ������. 
-- �÷���	 	depandname		upgradeRatio	enterCompany
-- ��µ�����		(�μ���ȣ)�̸� 	������ 10%		�Ի�����
	select '( '||deptno||' ) '||ename depandname, sal*0.1 upgradeRatio, hiredate enterCompany from emp;	
	
-- ���鰪�� ��Ī���� ó���ϱ� : " " ���̿� ��Ī���� �����ش�.
	select ename "name intro" from emp;	

-- �ѱ��� �������� ó���� ���� " " ���̿� ó�� (�׳� �ص� �Ǵµ�?)
	select deptno "�μ���ȣ" from emp;
	select deptno �μ���ȣ���� from emp;

-- �ߺ��� ó�� : �����ͺ��̽������� ������ ���� �Է��ϴ� ���� ���̺������ �Է��ϴ� ���� �����Ѵ�.
-- �÷��� �ִ� ��� �����Ͱ� �����ؼ��� �ȵȴٴ� ���̴�.
-- �׷��� 1�� �÷����� ��ȸ�� ���� ������ �����Ͱ� ��Ż �� �ִ�.
	select deptno from emp;	 
-- deptno���� �ϳ� �Ǵ� �ټ��� �����Ͱ� ������ ���� ���͸� ���ִ� ó���� �ִµ� �̸� distinct��� �Ѵ�.
-- Ȱ������ : select distinct �÷�1, �÷�2.. from ���̺�
	select distinct deptno from emp;

-- Ȯ�ο���1) -mgr�� ���ϰ� ���� ����ϼ���.
-- ȹ�ο���2) job�� mgr �÷��� ���ϰ��� ������ ����ϼ���.
	select distinct nvl(mgr,0) from emp;
	select distinct job, mgr from emp; 

/*
 ����ó��
 Ư���� ������ list���뿡�� �ʿ��� �������� ������� ���͸��ϴ� ���� ���Ѵ�.
 1. ���� ó��
*/		
	select * from emp;
-- ������ 3000�̻��� �����͸� list ó��
-- where �÷��� > ���ǵ�����
	select * from emp where sal>=3000;

-- �����ͺ��̽����� ���̴� �񱳿�����
-- = , >, <. >=, <=, <>, !=(�ٸ���)
	select * from emp;

-- 1) �μ���ȣ 30�� �����͸� list�ϼ���.
	select * from emp where deptno=30;
-- 2) ������ 1000�̸��� ������
	select * from emp where sal<1000;
-- 3) ename�� SMITH�� ������
	select * from emp where ename='SMITH';	
-- 4) comm�� NULL�� ������
	select * from emp where nvl(comm,0)=0;
-- 5) mgr�� 7689�� �ƴ� ������
	select * from emp where mgr!=7689;	  	
	
-- null���� ��Ÿ���� keyword : is null  (null���� �ƴҶ��� : is not null) 
	select * from emp where comm is null;		
	select * from emp where comm is not null;	
	
-- ���� ���� �ΰ��� ������ ���� ������ list�ϱ�
-- ���� multi ���ǿ� ���� ó��
-- ������ 3000�̻��� ����� �̸��� ������ ���� �ʹ�.
	select ename, sal from emp where sal>=3000;	
	
-- ������ 2000�����̰� ��å�� SALESMAN�� ����� �̸��� ��å�� ������ ���� �ʹ�.
	select ename �̸�, job ��å, sal ���� from emp where sal<=2000 and job='SALESMAN';
-- �÷����� ��ҹ��ڸ� �������� ������ �����ʹ� ��ҹ��ڸ� �����Ѵ�.	

/*
 ��������
 1. EMP�߿� �޿��� 2000�̸��� �Ǵ� ��� ���� �߿� �����ȣ�� ������ ����϶�.
 2. ������ ���ʽ��� �ջ� �ݾ��� 1500�̸��� ����� �̸�, ����, ���ʽ�, �ջ���� ����϶�.
 3. mgr�� NULL�� ����� job�� �̸� ������ ����ϼ���.
 4. job�� CLERK�� ��� �� deptno�� 30�� ����� �̸�, ��å, �μ���ȣ�� �Է��ϼ���.
 5. ������ 2000���� 3000���̿� �ִ� ����� �μ���ȣ, �̸�, ������ ����ϼ���.
*/		