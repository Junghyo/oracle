/*
 ������ ����(Data Dictionary)
 	�����ڿ��� �����ͺ��̽��� ���õ� ������ �����ϴ� ���� ���Ѵ�.

  DBA_XXX : �����ڸ� ���ٰ����� ��ü(���̺� ��)�� ���� ��ȸ.
  ALL_XXX : �ڽ� ���� ���� �Ǵ� ������ �ο� ���� ��ü(���̺�)�� ������ȸ
 USER_XXX : �ڽ��� ������ ������ ��ü � ���õ� ���� ��ȸ.	
*/
	select * from user_tables; -- ����� ���̺� ���� ����
	select * from user_tables where table_name like'%EMP%';
	select * from all_tables where table_name like '%EMP';

-- �������� Ȯ���ϱ�. USER_CONSTRAINTS���� �� ���̺��� ���Ἲ �������ǿ� ���õ� ������ ������ ��ųʸ��� ���� Ȯ�� ����.
	select * from user_constraints;	
	select * from user_constraints where table_name like '%EMP%';	

/* 	CONSTRAINT_TYPE
 P : PRIMARY_KEY
 R : FOREIGN_KEY
 U : UNIQUE
 C : CHECK, NOT NULL

 ** ������ ������ ���ؼ� ������ ���̺��� ���, ���̺��� ����, ���������� Ȯ���� �� �ִ�.
*/	
	select * from user_constraints where table_name like '%DEPT%';
	
	