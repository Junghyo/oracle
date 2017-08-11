/*
 DECODE () : ���� ó���� ���� �Լ�
 	DECODE(������, ������1, ����1������,
				  ������2, ����2������,
				  �׿��� ������)
				 
 gender��� �÷��� 0�� ����, 1�̸� ����, �׿ܿ��� �߼�				  
*/
	select decode(0, 0, '����', 1, '����', '�߼�') gender01,
		   decode(1, 0, '����', 1, '����', '�߼�') gender02,				  
		   decode(2, 0, '����', 1, '����', '�߼�') gender03,			  
		   decode(3, 0, '����', 1, '����', '�߼�') gender04
	from dual;				  
			  

-- �μ���ȣ�� 10 ȸ��, 20 ����, 30 ����, 40 �, �� �ܴ� '����'
	select ename, 
		decode(deptno, 10, 'ȸ��',
					   20, '����',
					   30, '����',
					   40, '�',
					   '����') selDept
	from emp;
	
-- job�� �ѱ۷� Ǯ���ؼ� ���ó��(CLERK : ����, SALESMAN : ������ ��...)
	select distinct job from emp;
	
	select ename, 
		decode(job, 'CLERK', '����',
					'SALESMAN', '������',
					'PRESIDENT', '����',
					'MANAGER', '������',
					'ANALYST', '�м���',
					'���߷�') ��å
	from emp;

/*
 ����1. (homework 1)
 ������ ���� ���ü�踦 �������� �Ѵ�. decode�� Ȱ���ؼ� 
 1000 �̸� - F���				������ 3%
 1000 �̻� ~ 2000 �̸� - E���		������ 5%
 2000 �̻� ~ 3000 �̸� - D���		������ 7%
 3000 �̻� ~ 4000 �̸� - C���		������ 4%
 4000 �̻� ~ 5000 �̸� - B���		������ 3%
 5000 �̻� - A���				������ 2%
 
 �̸� �μ� ���� ������� ������ �Ѿ�(����+������)
*/	
	select ename �̸�, deptno �μ���ȣ, sal ����,
		decode(sal, sal<1000, 'F���',
			   		sal between 1000 and 2000, 'E���') from emp;

/*
 CASE �Լ� : ���ǿ� ���� ���� �ٸ� ó���� ����
 CASE WHEN ����1(�񱳿�����) THEN ó���� ������
	  WHEN ����2(�񱳿�����) THEN ó���� ������
	  WHEN ����3(�񱳿�����) THEN ó���� ������
	  ELSE �� ���ǿ� �ش���� ���� ��� ó���� ������
 END
 
 ex) ������ ���� ���� ��� ��� 
*/
	SELECT CASE WHEN 80>=90 THEN 'A'
				WHEN 80>=80 THEN 'B'	  										  					  	  
				WHEN 80>=70 THEN 'C'	  										  					  	  
				WHEN 80>=60 THEN 'D'	  										  					  	  
			    ELSE 'F'
		   END GRADE
	FROM DUAL;
	
-- �μ���ȣ�� �������� �űԺμ��� ���ġ�Ϸ� �Ѵ�.
	SELECT EMPNO, ENAME, 
		CASE WHEN DEPTNO=10 THEN '�μ��̵�'
			 WHEN DEPTNO=20 THEN '�ο�����'		   					  										  					  	  
			 WHEN DEPTNO=30 THEN '��������'
		 ELSE '��������'
		END RESULT
	FROM EMP;

/* ����2. (homework 2)
 �Ի�б� ���� ǥ��(1/4, 2/4, 3/4, 4/4) �Ի� �б⸦ ǥ��
 �����ȣ �̸� �Ի�(��/��), �Ի�б�
*/	
	SELECT EMPNO �����ȣ, ENAME �̸�, TO_CHAR(	 			   					  										  					  	  