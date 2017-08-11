/*
 �ε�����?
 	�����Ϳ� ������ �����ϴ� ���� ���������μ� �����ͺ��̽��� ���� ��� ������ �ִ� ��ü.
	1) ����
		- �˻� �ӵ��� ��������.
		- �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����Ų��.
	
	2) ��������
		- ����(������, ��������), ���̺� ����, ������ �Է� �� ����
		- ��� ������ ���Ͻ� ����
	
	3) ��뿩��
		- ���̺��� ���� ���� ���� ���(������ �Ǽ��� ���� ���)
		- WHERE ������ INDEX�� �ش� �÷��� ���� ���� ��.(��ȸ���� ����Ѵ�)
			ps) ���̺� �Է�, ����, ������ ���� �Ͼ�� ������� �ʴ� ���� �Ϲ����̴�.
		- �˻� ����� ��ü �������� 2~4%���� �� ���.
			ex) 1000������ �λ����� ���� �����Ϳ��� �˻��� 20~40���� ������ �����͸� �ε��ؼ� ����� �� INDEX ó����.
	
	4) ����
		- �ε����� ���� �߰� ������ �ʿ�
		- �ε����� �����ϴµ� �ð��� �ɸ���.		 			
*/

/*
 �ε��� ���� ���� �����.
 1. ���� ���̺� �����
	CREATE TABLE EMP_IDX_EXP AS SELECT * FROM EMP;
 
 2. �ε��� ó���� �÷� ����
	EMP_IDX_EMP���� EMPNO�� INDEX�� ����

 3. �ε��� ����(�ش����̺� �ε��� ����) ##
	CREATE INDEX �ε����̸� ON ���������̺��(��������÷� ASC/DESC)
	CREATE INDEX INDEX_EMPNO_EMP_IDX_EXP ON EMP_IDX_EMP(EMPNO);

 4. ���̺����̽�
 	CREATE INDEX �ε����̸� ON ���������̺��(��������÷�) TABLESPACE ���������̺����̽���	
*/ 
	create table emp_idx_exp as select * from emp;    -- ����� ���̺��� ��� CONSTRAINTS�� INDEX�� ���簡 �����ʰ� �����͸� �����.
	select * from emp_idx_exp;

-- EMP_idx_EXP ���̺��� EMPNO �÷��� INDEX�� �����Ѵ�.	
	create index index_empno_emp_idx_exp on emp_idx_exp(empno);		-- Object Explorer�� Indexes�� ���� ����(index_empno_emp_idx_exp)
	
-- �ε��� ����. DROP INDEX �ε��� �̸�
	drop index index_empno_emp_idx_exp;	


-- Ȯ�ο���. DEPT ���̺� ���纻 DEPT_IDX_EXP�� ����� �ε��� �̸��� IDX_DEPTNO_DEPT�� �ؼ� ����, Ȯ�� �� ����ó��...
	create table dept_idx_exp as select * from dept;
	select * from dept_idx_exp;
	create index idx_deptno_dept on dept_idx_exp(deptno);
	drop index idx_deptno_dept;

-- emp���̺��� empno�÷��� ���� �ε����� ����. �ε��� �������� �������� ������ �÷��� �ڿ� ASC/DESC
	create index idx_emp_empno on emp(empno asc) tablespace exp_tab_space;
	create index idx_emp_empno on emp(empno desc) tablespace exp_tab_space;
	



	
