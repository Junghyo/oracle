	select * from emp;
/*
 �׷��ռ� : �����͸� �׷캰�� ���ġ�� ó���� �� Ȱ��ȴ�.
 
 SUM() : ���ջ�
 AVG() : ���
 COUNT() : ����
 MAX() : �ִ밪
 MIN() : �ּҰ�
*/
	select sum(sal) sum, avg(sal) avg, count(sal) count, max(sal) max, min(sal) min from emp;

/* �׷캰�� �������� ���ġ ó���ϱ�
	SELECT ó���ұ׷��÷�, �׷��Լ� FROM ���̺�� (WHERE ����..) GROUP BY ó���ұ׷��÷�;
*/

-- ex) �μ���ȣ���� ���ջ� �������� ����ϼ���.
	select deptno, sum(sal), avg(sal), count(sal), max(sal), min(sal) from emp group by deptno;
	
-- ��ü ������ �Ǽ��� Ȯ���ϼ���. SELECT COUNT(�÷�, ��ü(*) ) FROM ���̺��;
	select count(*) from emp;
	select count(comm) from emp;		   -- Ư�� �÷��� null���� ������ ī��Ʈ�� ���Ե��� ����.
	select count(nvl(comm,0)) from emp;    -- ������ �ִ� �÷��� nvl�� null���� ǥ�����ָ� ī��Ʈ�� ���Ե�. 

-- �ߺ��Ǵ� �����Ϳ� ���� �Ǽ� Ȯ��.   SELECT COUNT( DISTINCT �÷��� ) FROM ���̺��;
-- �ߺ��� ������ 2�� �̻��� ī��Ʈ�� ���Ե��� ����. ex) job�� salesman�� 2�� �̻� ������ �ϳ��� ī��Ʈ ó��.
	select count(distinct job) �ߺ��Ȱ�����ī��Ʈ from emp;

-- ������ 3000�̻��� ����߿� ��å���� �ο����� ���ϼ���.
	select count(job), job, avg(sal) from emp where sal>=3000 group by job order by avg(sal);

-- Ȯ�� ����. �Ի����� 1~3���� ����� �μ����� �ο����� üũ�ϼ���.
	select deptno, count(deptno) from emp where to_number(to_char(hiredate,'MM')) between 1 and 3 group by deptno;					
	select deptno, count(deptno) from emp where to_char(hiredate,'MM') between '01' and '03' group by deptno;	

-- �����͸� �Ի��� �б⺰�� �Ǽ��� ó���ϴ� ����
	select floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1, count(*) from emp group by floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1;
	
	select hiredate, to_char(hiredate,'MM') from emp;	-- TO_CHAR(HIREDATE, 'MM') HIREDATE ��¥�� �����͸� ������ ���ڷ� ���
	select hiredate, to_number(to_char(hiredate,'MM')) from emp; -- TO_NUMBER() : ������ ���ؼ� ���ڸ� ���������� ��ȯó��. 'MM'������ -> MM ������
	select hiredate, to_number(to_char(hiredate,'MM'))/4 from emp; -- 4�� ����				
	select hiredate, floor(to_number(to_char(hiredate,'MM'))/4) from emp;  -- floor�� �Ҽ����� ����.(����ó��)				
	select hiredate, floor(to_number(to_char(hiredate,'MM'))/4)+1 from emp;  -- +1�� ���� �б� ó��
	select floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1, count(*) from emp group by floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1;

/* ����1. (homework 1)
 ���� �������� �ο����� üũ�ϼ���.
 1000 �̸�         �����(�ְ�ġ, ����ġ, ���ġ)
 1000~2000 �̸�				
 2000~3000 �̸�				
 3000~4000 �̸�				
 4000~5000 �̸�
 5000~6000 �̸�
*/ 	

/* �׷캰�� �����͸� ó���� �Ŀ� ������� �׷쿡 ���� ������ ó��
	SELECT ó���ұ׷��÷�, �׷��Լ�
	FROM ���̺��
	(WHERE ����..)              ## �׷��� ó���ϱ� �� ����
	GROUP BY ó���ұ׷��÷�;
	HAVING �׷쿡 ���� ����ó��    ## �׷��� �� �Ŀ� ����	
*/
-- HAVING ���� : GROUP BY �ȿ� �־��� �׷��� �����Ϳ� ���� ������ ó���ϰ��� �� �� Ȱ��ȴ�.
-- ex) �μ����� ��տ����� ó���ϰ� �׷캰 ��տ������� 2000 �̻��� �����͸� �ε��ϼ���.
	select deptno, avg(sal) from emp group by deptno;
	select deptno, avg(sal) from emp where sal>=2000 group by deptno;           -- ����� �׷캰�� ���� ���� ����ó��
	select deptno, avg(sal) from emp group by deptno having avg(sal)>=2000;	    -- ����� ���쳻���� ����ó��

-- ����.�μ��� �ִ밪�� �ּҰ��� ���ϵ� �ִ�޿��� 2900�̻��� �μ��� ���ó��
	select deptno, max(sal), min(sal) from emp group by deptno;
	select deptno, max(sal), min(sal) from emp group by deptno having max(sal)>=2900;
			