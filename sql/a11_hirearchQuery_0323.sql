/*
 ������ ���� (������ ����)
 	����Ŭ���� ������ ������ ���̺��� ȿ�������� �����ϱ� ���� QUERY�� ���Ѵ�. (SELF JOIN�� ȿ�������� ó��)

 ������ ���� : ������ ���迡 ���̺� ������ ������ ���� ���Ѵ�.
 	ex) 							�Ҿƹ���(id, parent_id, role : 1, 0, '�Ҿƹ���')
 	      �ƹ���(id, parent_id, role : 2, 1, '�ƹ���')			����(id, parent_id, role : 3, 1, '����')
			�Ƶ�(id, parent_id, role : 4, 2, '�Ƶ�')			����(id, parent_id, role : 5, 3, '����')
			
 ������ SQL ����
	SELECT....�÷� FROM ���̺�� WHERE ���� START WITH ����(�񱳿�����)�÷�=������ CONNECT BY [NOCYCLE] ���� AND ����
		
	START WITH ����(�񱳿�����)�÷�=������: ������ SQL�� �������� ó�� - �ֻ��� ������ ����ó��.		
		ex) ���������� �ֻ��� ������ parentId=0
			�츮������ ���� ������ ó���ϰ��� �� ���, parentId=2(�ƹ��� ���� ���ķ� ��Ÿ��)
	
	CONNECT BY [NOCYCLE] ���� AND ���� : ������ ���踦 ��������ִ� ���ǿ� ���� ����. NOCYCLE�� �ݺ����ο� ���� ó��
		ex) CONNECT BY id = parent_id  : ���� id���� Ȯ���ؼ� ������ �ִ� id���� ���翩�θ� ���������Ϳ� Ȯ���ؼ� ���������� ��Ÿ���� �ϴ� ���� ���Ѵ�.
	
	PRIOR : ���� - ������ ���迡 ���� ó���ϰ� ��		
*/
	select * from emp;
-- ex) EMP ���̺��� �������� ���������� ������ ó���ϰ��� �Ѵ�. (MGR�� EMPNO�� ���εǾ� ����)
	select ename, job, empno, mgr from emp start with mgr is null			-- �ֻ��������� ������ mgr�� null�� �� (job=president)
	connect by prior empno=mgr; 											-- �ֻ����÷��� ���� �÷����� ����ó��
	
/*
 ���������� mgr�� null�϶� ���� �����Ͽ� ���������� empno�� mgr�� �ִ��� ���θ� Ȯ���Ͽ� �ش��ϴ� mgr�� �����Ͱ� empno�� ���� ������
 �ϴ� �ϳ��� NODE��ü�� �������Ѵ�.
 
 ## COLUMN �ɼ� : LEVEL - �ش� ������ �����ܰ踦 ǥ��
 		ex) �ֻ��� �����ʹ� 1, �������� 2, .....
*/
	select level ename, job, empno, mgr from emp start with mgr is null			-- �ֻ��� ������(president)�� ����1, ������ ������(manager)�� 2, ....�� ǥ��
	connect by prior empno=mgr; 		

/* ���������� ������ ó�� : LPAD('���ʿ� �Է��� ����', �ݺ��� Ƚ��)
	
	'    ' : ������ �⺻���� 4ĭ��. LPAD( '    ', 4*(LEVEL) ) || job
*/	
-- ex) LEVEL���� �������� ǥ�õ� �� �ְԲ� ó��	
	select level ename, lpad('   ',4*(level))||job, empno, mgr from emp start with mgr is null			
	connect by prior empno=mgr; 

-- ex) ���ο���. family�� ���������� ����ϼ���.
-- ������� : level role �̸�
	select * from family;
	insert into family values(1, 0, '�Ҿƹ���', 'ȫ�浿');
	insert into family values(2, 1, '�ƹ���', 'ȫ����');
	insert into family values(3, 2, '�Ƶ�', 'ȫ��ȣ');
	insert into family values(4, 1, '����', 'ȫ��ȣ');
	insert into family values(5, 2, '��', 'ȫ����');
	insert into family values(6, 1, '���', 'ȫ����');
	insert into family values(7, 4, '����', 'ȫ�̹�');
	
	select level, name, lpad(' ',4*(level-1))||role01, numid, parentnumid from family start with parentnumid=0 connect by prior numid=parentnumid;

/*
 ORDER SIBLINGS BY �÷� ASC/DESC : �ش� �������� �÷��� ���� ���� ������ ���� ������ �����Ѵ�.
 	������ ���� �θ� ���� �����͵鿡 ���� LIST �켱 ������ ����
 	- �ֱٿ� ��ϵ� ���� ������ �����͸� ���� LIST - DESC
	- ó���� ��ϵ� ���� ������ �����͸� ���� LIST - ASC
*/
	select level, name, lpad(' ',4*(level-1))||role01, numid, parentnumid from family
		start with parentnumid=0 connect by prior numid=parentnumid order siblings by numid desc;
	
	insert into family values(8,1,'ū�ƹ���','ȫ���');		
	insert into family values(9,0,'�����Ҿƹ���','ȫ���');	

/*
 BOARD ������ �Խ��� ���̺��� ���� LIST�ϱ�
 	����id(�۹�ȣ),		����id, 		Ÿ��Ʋ, 		����, 			�������, 	��������, 	�ۼ���, 		
	no,					parent_no,		title,			content,		credite,	uptdte,		writer, 		
	number,				number			varchar2(50),	varchar2(1000),	date,		date,		varchar2(50),	
*/
	create table board(
		no number primary key,
		parent_no number,
		title varchar2(50),
		content varchar2(1000),
		credite date,
		uptdte date,
		writer varchar2(50)
	);

	select * from board;
/* �۵��
(1, 0, '�۵�� ����', '�����ǰ�', sysdate, sysdate,'���')
*/
	insert into board values(1, 0, '�۵�� ����', '�����ǰ�', sysdate, sysdate,'���');		
	insert into board values(2, 0, '2��° ��', '���� �ǰ��ϴٰ�', sysdate, sysdate,'���');		
	insert into board values(3, 1, '1��°�� ��', '���� ���ǰ�', sysdate, sysdate,'���');		
	insert into board values(4, 1, '��¼���', '??', sysdate, sysdate,'LG¯¯��');		
	insert into board values(5, 2, '2��°�� ��', '��������', sysdate, sysdate,'��������');		
	insert into board values(6, 3, '�� ����', '�ڰ�ʹ�', sysdate, sysdate,'�ڿ���');		
	insert into board values(7, 4, '����¯¯', '��������� ����մϴ�', sysdate, sysdate,'����ȯ');		
	insert into board values(8, 3, '�����̾���', '�׳� �ڰ�ʹ�', sysdate, sysdate,'��𾲸���');
	insert into board values(9, 6, '��', '��������', sysdate, sysdate,'����');
	insert into board values(10, 9, '��', '������', sysdate, sysdate,'����');
	insert into board values(11, 8, '�̤�', '�ФФФФ�', sysdate, sysdate,'����');
	insert into board values(12, 0, '����', '��������', sysdate, sysdate,'����');
	insert into board values(13, 1, '�氡', '��������', sysdate, sysdate,'����');
	insert into board values(14, 2, '����', '����', sysdate, sysdate,'����');
	insert into board values(15, 1, '1��¯¯', '��������', sysdate, sysdate,'����');
	
	select no, lpad(' ',4*(level-1))||title, content, to_char(credite,'YYYY/MM/DD') credite, writer from board
		start with parent_no=0 connect by prior no = parent_no order siblings by no desc;
-- ROWNUM�� ������ �ʾ� NO ����Ʈ�� ��������		

-- ROWNUM : ������ ����Ʈ���� ������ NUMBERING�� �ٴ� Ű����. (�����Ͱ� �Էµ� ���� ������� ���������� ���� �ű�)
	select rownum, emp.* from emp;
	
		select rownum, no, lpad(' ',4*(level-1))||title, content, to_char(credite,'YYYY/MM/DD') credite, writer from board
		start with parent_no=0 connect by prior no = parent_no order siblings by no desc;					