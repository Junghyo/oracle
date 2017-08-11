/*
 SEQUENCE : ����Ŭ���� �ߺ��� ���� ���� �ʱ� ���� �⺻ Ű(PRIMARY KEY)�� ���̺��� �ϳ��� �÷��� �����Ѵ�.
 �� �÷��� �ߺ����� �ʴ� ���� �ֱ� ���ؼ� ����Ŭ������ SEQUENCE��� ��ü�� �����ϰ� �ִ�.
 �������� ���̺� ���� ������ ���ڸ� �ڵ����� �����Ͽ� �ڵ����� ��ȣ�� �Է��� �� �ְ� �ϱ⿡ ������� ����Ű ������ ���� �δ��� �ٿ��ش�.
 
 SEQUENCE
 	- ������(UNIQUE) ���� �������ִ� ����Ŭ ��ü
	- �������� �����ϸ� �⺻Ű�� ���� ���������� �����ϴ� �÷��� �ڵ������� ��������
	- ���� PRIMARY KEY ���� �����ϱ� ���� ���
	- �޸𸮿� CACHE �Ǿ��� �� SEQUENCE���� ������ ȿ���� ����
	- SEQUENCE�� ���̺���� ���������� ����ǰ� ����. �ϳ��� SEQUENCE�� ���� ���̺��� ��밡��

 ex) �л� ���̺� ��ȣ�� �Է��Ѵ�.
 	no �̸�
	no �÷��� 1, 2, 3, 4, 5, .... ���� �ڵ����� �Է��� �ؾ��� ���
	
	��� ���̺� ��ȣ�� �Է��Ѵ�.
	empno ename
	1000���� ���� 1001, 1002, 1003, 1004....
	
	�й� �Է�
	studId name
	C020001 ���� C02002, C02003, ....
	[�ܰ��ڵ�][SEQUENCE] : �ռ���ȣ
	
	�Է½� �ڵ����� NUMBERING ó��
	INSERT INTO ���̺� VALUES(SEQUENCE��.NEXTVAL,...)
	INSERT INTO ���̺� VALUES('C0'||SEQUENCE��.NEXTVAL,...)      --> ���ڿ� ���յ� SEQUENCE ó��
	
	���� : CREATE SEQUENCE �������� 
				START WITH N  			--> �������� ���� ��ȣ�� ����. ex) 1�� �����ϸ� 1���� ���������� ����
				INCREMENT BY N			--> �������� ���� ���� ����. ex) 2�� �����ϸ� 2������ ����. -1�� �����ϸ� -1������ ����
				MAXVALUE N 				--> �������� ������ �� �ִ� �ִ밪 ����. ex) 999999  1~999999 ���� �����͸� NUMBERING ó�� (NOMAXVALUE - ������ �ִ밪�� ���Ѵ��)
	
	������ �Է��̳� Ȱ���
		��������.NEXTVAL : �������� ������Ű�� ���簪�� ��� (���� ���������� ���� ���� ��ȯ)
		��������.CURRVAL : �������� ���簪�� ��� (���� ���� ��ȯ)			
*/
-- ex) ���۰��� 1�̰� 1�� �����ϰ�, �ִ밪�� 999999�� ������ exp01_seq�� ����� ���� ##
	create sequence exp01_seq
		start with 1
		increment by 1
		maxvalue 999999;
	select exp01_seq.nextval from dual;		-- ȣ���Ҷ� ���� NUMBERING ����. ���� ������ ������ NUMBER
	select exp01_seq.currval from dual;	    -- ���� ��ȣ ȣ��.

-- ex) �л����̺�(student_seq_exp) ����. no		�̸�
	create table student_seq_exp(
		no number constraint student_seq_exp_no_pk primary key,
		name varchar2(50)
	);	
	create sequence student_seq
		start with 1
		increment by 1
		maxvalue 999999;
	
	insert into student_seq_exp values( student_seq.nextval, '�ڱ浿'); 
-- ������ ������ no�� 1�� �����ϸ鼭 �����Ͱ� �Է�ó��
	insert into student_seq_exp values( student_seq.currval, '��浿');
-- ���� no 7���� �Է��� ���ִµ� CURRVAL�� �Է��� ��� ���� �ֱٿ� �Է��� ���������� �Է��ϴ� �����̱� ������ �Է��� �Ұ�(���̺� ������ NO�� PK�� �ߺ��� �Է��� �Ұ����ϰ� �����߱� ����)	
	commit;	
	select * from student_seq_exp;

/* Ȯ�ο���.
	1) emp_seq_exp ���̺� ����.(empno ename)
	emp_seq10 ������ ����. 1000���� ����.

*/	
	create table emp_seq_exp(
		empno number,
		ename varchar2(20)
	);
	create sequence emp_seq10
		start with 1000
		increment by 1;
	
	insert into emp_seq_exp values(emp_seq10.nextval,'��浿');

	insert into emp_seq_exp values(emp_seq10.currval,'ȫ�浿'); 
-- ���̺� ������ PK�� UNIQUE ���������� ���� �ʾұ⿡ ���� ���������� ���Է��ص� �Է��� ��(�ߺ��Է� ����)	
	select * from emp_seq_exp;	

/* Ȯ�ο���.
 2) COLLEGE ���̺� ����(studid, name)
 	college_seq ������ ����. C020001, C020002,...
*/	
	create table college(
		stuid varchar2(20),
		name varchar2(20)
	);
	
	create sequence college_seq
		start with 20001
		increment by 1;	
	insert into college values('C0'||college_seq.nextval, '��浿');
	select * from college;
	delete from college; 				-- ���̺� �Էµ� �����͸� ���� ������ �������� �Է��ص� �ʱ�ȭ�Ǽ� 1������ �ԷµǴ� ���� �ƴ϶� �����͸� �������� �Էµ� ������ ��ȣ ���ĺ��� NUMBERINGó���Ǿ� �Էµ�.	
	
/*
 SEQUENCE ����
 ���� : DROP SEQUENCE ��������
 
 1) ������ ����: exp_seq
 2) ������ ���� ��ųʸ����� Ȯ�� : SELECT * FROM USER_SEQUENCES;
 3) ������ ���� : DROP SEQUENCE ��������
 4) ������ ���� ��ųʸ����� ��Ȯ��
*/	
	create sequence exp_seq
		start with 10
		increment by 10
		maxvalue 70;
	select * from user_sequences;
	drop sequence exp_seq;
	select * from college;
	delete from college;
	insert into college values(exp_seq.nextval,'��'); 
	insert into college values(exp_seq.currval,'��'); 
/* maxvalue(�ִ밪)�� 70�����̱� ������ 70���� �Է��� �Ǹ� nextval�δ� �Է� �Ұ�. currval�� ��� ���簪�� 70���� ��� �Է°���
   SEQUENCE�� ����� CURRVAL���� ������ �� �� ���⿡ �ش簪�� ���ϴ� ���������� �����Ϸ��� DROP(����)��Ű�� START WITH���� �ٽ� �����ؾ��Ѵ�.
   ������ ���� �� �ٽ� �����ؼ� �Է½ÿ� �ִ밪���� �� �Է��� �����ϴ�.
*/
	create sequence exp_seq
		start with 50			-- ���ϴ� CURRVAL���� START WITH���� �Ҵ��� �� �ش� SEQUENCE ����
		increment by 10
		maxvalue 70;
	select * from user_sequences where sequence_name='EXP_SEQ';
/*
 �ִ�ġ�� �ʹ� �۰� �ѹ��� �κе� �ִ�ġ ���Ŀ� �ٽ� �ʱⰪ���� �����ϴ� ���� �ʿ��� ��� SEQUENCE ���� ó��
 
 ���� : ATLER SEQUENCE ��������
 			START WITH�� ������ ��� �ɼ� ���� ���� 

 �ѹ��� �κ� �ִ�ġ ���� �ٽ� �ʱⰪ���� ���� : CYCLE | NOCYCLE(default��) 			
 CACHE : ���� ó���� ���� �޸� ���� 1���� ũ�� �����ϸ� CYCLE�ɼ��� ������ �� �������ִ� ���� �Ϲ����̴�.

 ex) exp_seq ������ ���� ���� 
*/		
	alter sequence exp_seq
		minvalue 50  			-- �ּҰ�. �ּҰ� ������ �Էµ� NEXTVAL���� �����Ϸ��� ������ ���� ��� �����߻�. �ݵ�� �����Ϸ��� ���� ���� NEXTVAL������ Ŀ�ߵȴ�.
		maxvalue 100
		cycle
		cache 5;	
	select exp_seq.nextval from dual;

/* Ȯ�ο���.*/
-- 1. �ʱⰪ 1000, �ִ밪 2000, STEP 100�� �������� ����
	create sequence seq_ex1
		start with 1000
		increment by 100
		maxvalue 2000;
	
-- 2. ���� �� Ȯ��
	select seq_ex1.nextval from dual;				    	
	select seq_ex1.currval from dual;

-- 3. DROP ��Ű�� �ʱⰪ 1100�� �ٸ� �ɼ��� ���� ����� ���� ������ ����
	drop sequence seq_ex1;
	create sequence seq_ex1
		start with 1100
		increment by 100
		maxvalue 2000;

-- 4. ����.. �ּҰ� 1100, ����ġ 10, �ִ밪 2000, cycle�ɼ� ����
	alter sequence seq_ex1
		minvalue 1100
		increment by 10
		maxvalue 2000
		cycle;

				    	