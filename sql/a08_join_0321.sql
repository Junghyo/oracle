-- EMP���̺� X DEPT���̺�. ũ�ν� ����
	select * from emp;			-- MGR�� EMPNO JOIN����. ex) ALLEN�� MGR:7698  // BLAKE�� EMPNO: 7698 
	select * from dept;
	select * from emp, dept;
	select count(*) from emp;   
	select count(*) from dept;
	select count(*) from emp, dept;

/*
 EQUAL JOIN : �ΰ� �̻��� ���̺��� �� ���̺� �ҼӵǾ� �ִ� �÷��� �����Ͱ� ���� ���� ���� �� �����Ͽ� ó���� �� �ִ� JOIN�� ���Ѵ�.
 	- ���� : SELECT ǥ�����÷� FROM ���̺�1, ���̺�2 WHERE ���̺�1.�����÷� = ���̺�2.�����÷�;   ## �����÷� : ���� �����Ͱ� �ִ� �÷�
*/	
	select * from emp, dept where emp.deptno=dept.deptno;

-- ex) ����� �̸��� ��å, �ҼӺμ����� ����ϼ���.
	select emp.ename, emp.job, dept.dname from emp, dept where emp.deptno=dept.deptno;

-- ex) ������ �μ���ġ�� ����ϼ���.
	select emp.ename, dept.loc from emp, dept where emp.deptno=dept.deptno;	

-- ex) ���ʽ��� �ִ� ����� �̸��� �μ����� ����ϼ���.
	select emp.ename, dept.dname, emp.comm from emp, dept where emp.deptno=dept.deptno and emp.comm is not null;	

/* ���� (homework)
 �μ���ġ�� ����� ���� �Ʒ� �������� ����㼼��.
 �μ���ġ		�����		
*/

/*
 NON-EQUI JOIN : 2�� �̻��� ���̺��� �÷��� ���� ���������� ��ġ���� ���� �� ����ϴ� �������� '='�� ������ �����ڸ� ����Ѵ�.
*/
	select * from salgrade;
-- �޿� ����� 5���� ������ �� ����� ǥ���Ͻÿ�.
-- WHERE SAL BETWEEN [LOSAL] AND [HISAL]
-- �̸��� ��������� ����ϼ���

/* ���̺� ALIAS ����ϱ� : ���̺��� �÷��� ���� �̸��� ������ �ǹ̰� ������ ���� �̸��� ������ �����ϱ����� ���̺��[����]ALIAS�� Ȱ���Ѵ�.
						  ����, ������ �÷��� ���� ������, �������� ���� ����ϴ� ��쵵 �ִ�.
     ���̺�ALIAS.�÷���
*/

-- ex) �̸��� ���� ��������� ����ϼ���.
	select a.ename, a.sal, b.grade from emp a, salgrade b where a.sal between b.losal and b.hisal;	

/*
 ����(homework)
 student10 ���̵�, �̸�
 studentPoint ���̵�, ����, ����
 gradeCheck ��������lopoint, �ְ�����hipoint, �������(A~F)
 1) ���̵� �����ؼ�(equal join)
 	�̸� ���� ���� ���
 2) ������ �����ؼ�(not equal join)
 	���� ���� �������
 3) student10 studentPoint gradeCheck ������ �Ͽ�
 	�̸� ���� �������	 	
*/	

/*
 OUTER JOIN : �� ���� ���� ���迡 �ִ� ���̺� �־ �����Ͱ� ���� �Ǵ� ���� ���̺��� ���ǿ� �������� �ʾƵ� ������ ����� ����ؾ� �ϴ� ��쿡 Ȱ��Ǵ� �����̴�.
 	EMP DEPTNO: 30������ // DEPT DEPTNO: 40������ �ִµ� ������ �� DEPTNO 40�� �����Ͱ� ���ٴ� ǥ�ø� �ؾ���
	
 WHERE �����Ͱ� ���� ���̺�.�÷���(+) = �����Ͱ� �ִ� ���̺�.�÷���
*/
-- ex)�μ���ȣ���� ��Ī�Ǵ� ����̸��� ����ϵ�, �̸��� ������ ���ٴ� ǥ�ð� �ʿ�  
-- �̸�, �μ���ȣ, �μ��� ǥ��
	select a.ename, b.deptno, b.dname from emp a, dept b where a.deptno=b.deptno order by b.deptno; -- dept���̺� deptno�� 40�� ������ list���� ����
	select a.ename, b.deptno, b.dname from emp a, dept b where a.deptno(+)=b.deptno order by b.deptno; -- 40���� null������ list��
-- nvl ������� null���� '�ο�����'���� ó��	
	select nvl(a.ename,'�ο�����'), b.deptno, b.dname from emp a, dept b where a.deptno(+)=b.deptno order by b.deptno;
	select b.deptno, count(a.ename) from emp a, dept b where a.deptno(+)=b.deptno group by b.deptno order by b.deptno;
	

/* ����(homework)
 outer join, group�� Ȱ���Ͽ� �μ��� �ο��� Ȯ���Ϸ��� �Ѵ�. �Ʒ��� �������� ����ϼ���. �ο��� ���� ���� 0���� ǥ��
 �μ��� �ο��� 
*/
	
/*
 SELF JOIN : �� �״�� �ڱ� �ڽŰ� ������ �δ� ���� ���Ѵ�.
 			 FROM���� ���� �̸��� ���̺��� �����Ͽ� �ٸ� ���̺��� ��ó�� �ν��ؼ� �����Ͽ� �� ������� ����ϴ� ���� ���Ѵ�.
			 
 SELECT * FROM ���̺�� ALIAS01, �������̺�� ALIAS02 WHERE ALIAS01.�����÷�=ALIAS02.�����÷�		 			 
*/	
-- ex) EMP ���̺��� ������ �� ����� �����ϴ� �����ڸ��� ����ϼ���
	select work.ename, work.mgr, manager.ename, manager.empno from emp work, emp manager where work.mgr=manager.empno;


/* ������ JOIN���� ���� ���̺� �����(SELF JOIN)
 1. ������ �����Ѵ�.
 	- ID�� ����ID�� �Է��ϴ� KEY�� �����.
	  NUMID, PARENTNUMID, ROLE01, NAME
	  ���̵�, �������̵�   , ����   , �̸�
	
 2. ���̺��� �����Ѵ�.
  	- 
 3. �����͸� �Է��Ѵ�. (���� �������� ������ ������ ���� ������ �Է�ó��)
 4. �Էµ� ������ ������ ���������� �Ǿ� �ִ��� Ȯ���Ѵ�. - ��ȸó��
*/ 

-- 2. ���̺� ����
	create table family(
		numid number,
		parentnumid number,
		role01 varchar2(100),
		name VARCHAR2(500)
	);	
	
-- 3. ������ �Է�	
	insert into family values(1, 0, '�Ҿƹ���', 'ȫ�浿');
	insert into family values(2, 1, '�ƹ���', 'ȫ����');
	insert into family values(3, 2, '�Ƶ�', 'ȫ��ȣ');
	insert into family values(4, 1, '����', 'ȫ��ȣ');
	insert into family values(5, 2, '��', 'ȫ����');
	insert into family values(6, 1, '���', 'ȫ����');
	truncate table family;
	
-- 4. ��ȸ
	select * from family;
	select b.name, a.role01, a.name from family a, family b where a.parentnumid=b.numid;
	
