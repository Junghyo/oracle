/*
 ������ ���Ἲ ���� ����
 	- �������� �ŷڼ��� Ȯ���ϱ� ���Ͽ� ���̺� ������, �÷� �Ӽ������� �����ϴ� ���� ���Ѵ�.(�ߺ����̳� null�� ���� ��...)

 �������� 5����
 	1.   NOT NULL  : null���� ������� �ʴ´�.
	2.   UNIQUE    : �ߺ����� �Է��� ������� �ʴ´�.
	3. PRIMARY KEY : NOT NULL�� UNIQUE�� ���ÿ� ����.
	4. FOREIGN KEY : �����Ǵ� ���̺��� �÷����� �����ؾ� �Է��� ����.
	5.   CHECK     : ���� ������ �����Ͱ��� ������ ������ �����Ͽ� ������ ������ �Է� ���.	
*/

-- 1. NOT NULL : ��� ���̺� ����� ������ ������ �� �ݵ�� �����ȣ�� ����̸��� ����Ǿ�� �Է��� �ǵ��� ó���ϰ��� �� ���.
-- 			���� : CREATE TABLE ���̺��(�÷��� DATA-TYPE NOT NULL, .....);
	create table emp02( empno number(4) not null, ename VARCHAR2(10) not null, job VARCHAR2(9), deptno NUMBER(4) );
	select * from emp02;
	
	insert into emp02(job,deptno) values('�븮',30);  
	/*empno�� ename�� ���� �Էµ��� �ʾ� ���� �߻�*/
	
	insert into emp02 values(1000,'ȫ�浿','�븮',30);
	select * from emp02;
	
	insert into emp02 values(null,'ȫ�浿','�븮',30);
	/*empno�� null���� �ԷµǾ� ���� �߻�*/
	insert into emp02 values(1002,'','�븮',30); 
	/*empno�� ���鰪�� �ԷµǾ� ���� �߻� ������ null������ ó��*/
	
-- 2. UNIQUE : D������ �Է¿� �־, �ߺ��� ������ �Է��� ������� �ʴ� ���� ���Ѵ�.
-- ex) emp03 ���̺��� �÷� empno�� unique���������� �־� ������ ����� �Էµ��� �ʵ��� ó���ϼ���.
	create table emp03( empno number(4) unique, ename VARCHAR2(25), mgr number(4) );	
	insert into emp03 values(1000,'himan1',null);	
	insert into emp03 values(1001,'himan2',7788);	
	insert into emp03 values(1002,null,null);	
	insert into emp03 values(1003,'himan3',8888);
	insert into emp03 values(1000,'himan4',8888);  /*empno '1000'���� �̹� �Է��� �Ǿ��⿡ �ߺ�ó���� �Ǿ� ���� �߻�*/
	select * from emp03;	

-- 3. PRIMARY KEY : NOT NULL(�ݵ�� ������ �Է�)�� UNIQUE(�ߺ��� �Ұ�)�� ������ ��� ������ �ִ� ��. �ַ� �������̺��� key���� ������ �� Ȱ��ȴ�.	
-- ex) MEMBER���̺� MEMBERID���� PRIMARY KEY�� �����ϼ���.
	create table member( memberid VARCHAR(20) primary key, pass VARCHAR(20), name VARCHAR(50), loc VARCHAR(100) );
	insert into member values('1111', '7777', 'ȫ�浿', '���ﰭ��');
	insert into member values('1112', '7777', 'ȫ�浿', '���ﰭ��');
	
	insert into member values('1111', '7777', 'ȫ�浿', '���ﰭ��');  
	/*memberid���� 1111�� �̹� �ֱ� ������ ���� �߻�*/
	
	insert into member values(null, '7777', 'ȫ�浿', '���ﰭ��'); 
	/* memberid���� null���� �ֱ� ������ ���� �߻�*/
	select * from member; 

-- 4. FOREIGN KEY : �����Ǵ� ���̺� �ݵ�� ���� �Է��ؾ� �ϴ� ��츦 ���Ѵ�.
	CREATE TABLE DEPT_REF(
   DEPTNO   NUMBER (2) PRIMARY KEY,
   DNAME    VARCHAR2 (14),
   LOC      VARCHAR2 (13) );	
	
	CREATE TABLE EMP_REF(
   EMPNO      NUMBER (4) PRIMARY KEY,
   ENAME      VARCHAR2 (10),
   JOB        VARCHAR2 (9),
   MGR        NUMBER (4),
   HIREDATE   DATE,
   SAL        NUMBER (7, 2),
   COMM       NUMBER (7, 2),
   DEPTNO     NUMBER (2) REFERENCES DEPT_REF(DEPTNO) );
   
-- �÷��� DATA-TYPE REFERENCES ���������̺��(�������÷���)
	insert into DEPT_REF values(10,'�λ�','����');
	insert into DEPT_REF values(20,'�ѹ�','���');
	select * from DEPT_REF;
	
	insert into EMP_REF(empno, ename, deptno) values(1000,'ȫ�浿',10);
	select * from EMP_REF;
	
	insert into EMP_REF(empno, ename, deptno) values(1001,'�ű浿',30); 
	/*deptno 20�� ���̺� DEPT_REF�� ���� ������ ���� �߻�*/
	insert into EMP_REF(empno, ename, deptno) values(1001,'�ű浿',20);
	select * from EMP_REF; 
	
/* ����3. (homework 3)
����Ű ���迡 �ִ� ���̺� �����ϱ�
 
 �������̺� student_main(id, pass, name) : ���̵�, �н�����, �̸�
 �������̺� student_point(id, subject, point) : ���̵�, ����, ����
 �������̺�� �������̺��� id�� foreign key ���踦 �����ϰ� �������̺� �����Ͱ� �־�߸� �������̺� �Է��� �� �ְԲ� ó��
*/	

-- 5. CHECK : �ԷµǴ� ���� üũ�Ͽ� ������ �� �̿��� ���� ������ ���ϰ� ������ �����ϴ� ���� ���Ѵ�.
-- ex) ������̺� gender��� �÷��� �����ϰ� ���⿡ 'M', 'F' �ΰ��� �� �ܿ��� �Էµ��� ���ϰ� ó���ϼ���.
	create table emp04( empno number(4), ename VARCHAR2(10), gender VARCHAR2(1) check(gender in('M', 'F')) );
	insert into emp04 values(9999,'ȫ�浿', 'M');
	select * from emp04;
	
	insert into emp04 values(9998,'�ű浿', 'D');
	/* check �������� gender�÷��� 'M', 'F'�� �Է°����ϵ��� �����߱� ������ ���� �߻� */
	insert into emp04 values(9998,'�ű浿', 'F');
	select * from emp04;