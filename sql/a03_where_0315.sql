	select * from emp;
/*
 OR ������ : ��ȸ ���ǿ� �־, �ϳ��� ���Ǹ� �����ϴ��� �ش� �����Ͱ� ��� ó���Ǵ� ���� ���Ѵ�.
 SELECT �÷� FROM ���̺�� WHERE �÷�1=����1 OR �÷�2=����2;
 �������� ���� �÷�1=����1�� �����ϰų� �÷�2=����2�� ������ ��쿡 �ش� �����͸� ���� list�Ѵ�.
 ex) �μ���ȣ�� 30�̰ų� ������� 'SMITH'�� �����͸� list�ϼ���.
*/
	select deptno "�μ���ȣ", ename "�����" from emp where deptno=30 or ename='SMITH';

-- Ȯ�� ����. ���ʽ��� �ְų� ��å�� 'SALESMAN'�� ���� ����ϼ���
	select * from emp;
	select * from emp where comm is not null or job='SALESMAN';
	
/*
 NOT ������
 �ش� �����ڰ� ���̸� ����, �����̸� ������ ó���Ǿ� ��Ÿ�� �ʿ䰡 ������ Ȱ���Ѵ�.
 �Ϲ������� ���� �̿ܿ� �����͸� ����Ʈ�ϰ��� �� ��쿡 Ȱ��ȴ�.
 ex) �μ���ȣ�� 10�� �ƴ� �����͸� list�ϼ���.
*/
	select * from emp where not deptno=10; --deptno <>10, deptno !=10 (������ ȿ��)
	select * from emp where deptno!=10;
	select * from emp where deptno>10;

-- Ȯ�� ����. ������ 2000~3000�� �ƴ� �����͵��� not keyword�� Ȱ���Ͽ� list�ϼ���.
	select * from emp where not (sal>=2000 and sal<=3000);

-- Ȯ�� ����. ��å�� SALESMAN�� �ƴϰ� ������ 2000�̻��� ����� list�ϼ���.
	select * from emp where not job='SALESMAN' and sal>=2000;
	select * from emp where job!='SALESMAN' and sal>=2000;

/*
 BETWEEN AND ������
 �������� ������ Ư�� ���� ���̿� ������ Ȱ��Ǵ� Ű����
 where �÷��� between A and B;
 �ش� �������� �÷����� ������ A~B ���̿� �ִ� ���� ���Ѵ�.
 ex) ������ 2000���� 3000���̿� �ִ� �����͸� list�ϼ���.
*/
	select * from emp where sal between 2000 and 3000;
	select * from emp where sal>=2000 and sal<=3000;

-- Ȯ�� ����. ����� 7400~7500���̿� ������ ������ 2000�̸��̰ų� 3000�ʰ��ϴ� �����͸� list�ϼ���.
	select * from emp where (empno between 7400 and 7500) and not (sal between 2000 and 3000);
	select * from emp where (empno between 7400 and 7500) and (sal<2000 or sal>3000);

/*
 ��¥�� ���� ó��
 �Ի����� 1987/01/01���� 1987/21/31 ���̿� �ִ� �����͸� list�ϼ���
*/	
	select * from emp;	
	select * from emp where hiredate between '1981/01/01' and '1981/12/31';
	select * from emp where emp.hiredate between '1981/01/01' and '1981/12/31';
	
-- �Ի����� 1981�� 12���� �Ի��� ����� �̸��� �μ����� ����ϼ���.
	select ename "�̸�", deptno "�μ���ȣ", hiredate "�Ի���" from emp where hiredate between '1981/12/01' and '1981/12/31';
	
-- sysdate : ���� ��¥�� ������ִ� Ű����
	select ename, hiredate, sysdate from emp;

/*
 IN ������
 �ش� �����Ϳ� ���� ������ ó���� �� ���� �����Ϳ� ���� ��ȸ�� �ϰ��� �ҋ� Ȱ��ȴ�
 OR �����ڿ� ������ ����.   �÷��� IN (�ش絥����1, �ش絥����2, �ش絥����3)
 ex) �����ڹ�ȣ�� 7902, 7566, 7839�� ���� list�ϼ���.
*/									
	select * from emp; 
	select * from emp where mgr in (7902, 7566, 7839); 	
	
-- Ȯ�ο���. ����̸��� SMITH, WARD, JONES �� ��� �߿��� ���� 1000�̸��� �������� �̸��� ������ ����ϼ���.
	select ename "�̸�", sal "����" from emp where (ename in ('SMITH', 'WARD', 'JONES')) and sal<1000;

/*
 LIKE �����ڿ� ���ϵ�ī��(_) Ȱ���ϱ�
 Ư�������Ϳ� ���� ���ڿ� ��ü ������ ��Ȯ�ϰ� ���� ���� ��쿡 �����͸� �˻��ϱ����� LIKE�����ڿ� ���ϵ� ī�带 Ȱ���ϴ� ����̴�.
 ����) �˻��÷��� LIKE '%�˻��ҵ�����%';
 ex) ����� K�� ���Ե� �����͸� list�ϼ���.
*/		
	select * from emp where ename like '%K%';
-- ���� K�� ���۵Ǵ� �����͸� list�Ϸ���?
	select * from emp where ename like 'K%';
-- ��å���� MAN���� ������ �����͸� list�ϼ���.
	select * from emp where job like '%MAN'; 		

-- Ȯ�ο���. ��å���� S�� �����ϴ� �����Ϳ��� ���ʽ��� 300�̰ų� 400�̰ų� 700�� �����͸� ��å, �����, ���ʽ� ������ list�ϼ���
	select job "��å", ename "�����", comm "���ʽ�" from emp where (job like 'S%') and (comm in (300, 400, 700));
	select * from emp;

/*
 ���ϵ�ī��(_) ����ϱ�
 _���ڼ��� �����ؼ� �ش系���� �˻��ϰ��� �� �� Ȱ���Ѵ�.
 ex) �ι�° ���ڰ� 'A'�� ����� list�ϼ���.
*/	
	select * from emp where ename like '_A%';

-- Ȯ�ο���. ������� 3��° ���ڰ� A�� ������ �߿� �޿��� 2000�̻��� ���� list�ϼ���.
	select * from emp where (ename like '__A%') and (sal>2000);	

/*
 NOT LIKE '���ϵ�ī��(_)'�ش� ������ �ƴ� ���� ���
 ex) �̸��� 'A'���ڰ� ���Ե��� �ʴ� ����� �˻�
*/	
	select * from emp where ename not like'%A%';
	
-- Ȯ�ο���. ��å�� ER�� ������ �ʴ� ������ �� 1981�⵵�� �Ի��� ����� list�ϼ���.
	select * from emp where (job not like '%ER') and (hiredate between '1981/01/01' and '1981/12/31');
	select * from emp where (job not like '%ER') and (hiredate like '%81%');

/*
 ����ó��
 �����ʹ� ������ ���� ������ ��������, ������������ ����ó���� �� �ִ�.
 ���Ľ� �̿� ���� ���صǴ� �÷��� ���ؾ� �ϸ� ������������ �������������� ǥ���ؾ� �Ѵ�.
 ����) ORDER BY �����÷�1 ASC/DESC
 		 ASC : �������� (�⺻ defalut��)
		DESC : ��������
 ex) �޿��� ������������ ����ϼ���.		
*/
	select * from emp order by sal asc;		
	select * from emp order by sal;
	select * from emp order by sal desc;

-- Ȯ�ο���. ��å�� MANAGER�� �����͸� �Ի��� �������� �������� list
	select * from emp where job='MANAGER' order by hiredate asc;

-- Ȯ�ο���. ���ʽ��� �ִ� �����͸� �������� ������������ �����, �޿�, ���ʽ��� ����ϼ���.
	select ename "�����", sal "�޿�", comm "���ʽ�" from emp where comm is not null order by comm desc;	

/*
 ���ı����� 2�� ���� 3������ �Ǿ� �ִٸ� ��� �ұ�?
*/
-- comm�� �����Ͱ��� ������ ���� sal�������� �������� �����Ѵ�.
	select ename "�����", sal "�޿�", comm "���ʽ�" from emp order by comm desc, sal desc;	

-- Ȯ�ο���1. �Ի����� ������������ �����ϵ�, �����ȣ, �����, ����, �Ի����� ���.
	select * from emp;
	select empno "�����ȣ", ename "����̸�", job "����", hiredate "�Ի���" from emp order by hiredate asc;
	
-- Ȯ�ο���2. �����ȣ�� �������� ������������ �����Ͽ� �����ȣ�� ����� ���.
	select empno "�����ȣ", ename "�����" from emp order by empno desc;
	
-- Ȯ�ο���3. �μ� ��ȣ�� ���� ������� ����ϵ� ���� �μ��� ����� �ֱ� �Ի��� ������� ���(�μ���ȣ, �Ի���, �����, �޿���)
	select deptno "�μ���ȣ", hiredate "�Ի���", ename "�����", sal "�޿�" from emp order by deptno asc, hiredate desc;

/*
 dual : �����͸� �׽�Ʈ�ϱ� ���� �뵵�� oracle ���� ��ü. �� ������ ��µȴ�.
 �ַ� ����, �Լ����볻���� Ȯ���ϴµ� Ȱ��ȴ�.
*/	
	select * from dual;	
	select 10+10 from dual;
	select sysdate from dual;
	select 10+10 plus, sysdate from dual;
	select 10+10 plus, sysdate, 10||'+'||10||'='||(10+10) calcu from dual;

	select * from emp;
	
			