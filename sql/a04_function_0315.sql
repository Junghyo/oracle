	select * from emp;
/*
 �����Լ� : ���ڸ� ó���ϴ� �Լ�. 
 		   ���밪, �����Լ�(sin, cos, tan...), �ø�(ceil), �ݿø�(round), ����(trum, floor), ������(mod)�� ó����
*/		   

-- 1. abs() : ���밪. -��ȣ�� ������� ����� ó���ϴ� �Լ��� ���Ѵ�.		   
	select 25, -25, -25.63, abs(25), abs(-25), abs(-25.63) from dual;

-- 2. floor() : �Ҽ��� �Ʒ��� ������ �Լ�.
	select 25, 25.65, -25.45, floor(25), floor(25.65), floor(-25.45) from dual;  

/* 3. round() : �ݿø� ó�� �Լ�. round(������, �ݿø��� �ڸ���). 
		�ݿø��� �ڸ��� : ��� - �Ҽ��� ������ �ڸ��� ó��. 1�� ��� �Ҽ��� ��°�ڸ�, 2�� ��� �Ҽ��� ��°�ڸ����� �ݿø�
						���� - 1�� �ڸ�(1), 10�� �ڸ�(2)���� �ݿø� �̷������� �ش� ���� ��ŭ �ݿø� ó��
*/
	select 25.27888, round(25.27888,2) from dual;
	select 625.2999, round(625.2999,-2) from dual;	

/*
 ����(homework) 
 sal�� �����̶�� �� ��, �̴� �޿���(1/13)�� ó���Ͻÿ�. �� �̴��� ���ʽ��� �ִ� ���Դϴ�.
 ��³��� : ���, ����, �̴ޱ޿�, ���ʽ�, �ѱ޿���(�޿��� ���ʽ��� 10������ �ݿø�ó���Ѵ�.)
 */  	
 
-- 4. trunc�Լ� : Ư�� �ڸ��� ���Ϸ� ����ó��. trunc(������, �ڸ���ó��)
	select trunc(24.2433,2), trunc(24.243, -1) from dual;

/* ����(homework)
 sal�� �������� 
 1000 �̸�  	  - 10% ���ʽ�
 1000~2000�̸� - 20% ���ʽ�
 2000~3000�̸� - 30% ���ʽ�
 3000~4000�̸� - 40% ���ʽ�
 4000~5000�̸� - 50% ���ʽ�
 5000 �̻� 	  - 60% ���ʽ�
 �� �����ϱ�� �ߴ�. �Լ��� Ȱ���ؼ� �Ʒ� ������ ó���Ͻÿ�.
 ��� �̸� ���� ���ʽ�(%) ���ʽ�	
*/
	select * from emp;
	select empno, ename, sal, (trunc(sal,-3)+1000)/100 from emp;


-- 5. mod�Լ� : ������ �Լ�ó��.   ���� : mod(������, ������) --- �ش絥���͸� ���� ���� ���� ��, ������ ���뿡 ���� ó��.
	select mod(27,2), mod(27,3), mod(27,4) from dual;
-- �����ȣ�� Ȧ���� ����� �˻��ϼ���.
	select * from emp where mod(empno,2)=1;

/* ����(homework)
 ����� �μ��������� 1���� 2������ ����� ü����ȸ�� �ϱ�� �ߴ�.
 �μ���ȣ�� 10, 30 ==> 1��
 �μ���ȣ�� 20, 40 ==> 2��
 ���� ������ ������ ���� ����ϼ���.
 �μ���ȣ	 �����ȣ �̸� ����
*/

/*
 ���� ó�� �Լ�
 1. upper ��� �����͸� �빮�ڷ� ��ȯó��. ���� : upper(������)
		�Ϲ������� ������Ͱ� �ҹ��ڳ� �빮�ڰ� ���� �ԷµǾ� �ִ� ��쿡 �ش� �����͸� �Է¹���(��ҹ��� ���о���)�� �˻��� ��� ���� ���δ�.		 		
*/
	select upper('hi ! good days !!') from dual;

-- ��å�� ��ҹ��� ���� ���� ��ȸ�Ϸ��� �Ѵ�. �Ʒ� salesman�̶�� �ԷµǾ �˻��Ϸ���...
	select * from emp;
	select * from emp where job = upper('salesman');

-- 2. �ҹ��ڷ� ��ȯ�ϴ� lower�Լ�. ���� : lower(������)
	select lower('GOOD Night !!! This Is The BEST DAY !!') from dual;
	select lower(ename), lower(job) from emp;
	
-- 3. initcap�Լ� : ù���ڸ� �빮��, �������� �ҹ��� ó��. ���� : initcap(������)
	select initcap(ename), initcap(job) from emp;
-- Smith is a Clerk!! �������
	select initcap(ename)||' is a '||initcap(job)||'!!' from emp;

-- 4. ���ڱ��̸� ó���ϴ� length�Լ�. ���� : length(������)
	select length('himan'), length(1234), length('������������') from dual;

-- ��å�� 5�� ������ �����͸� ����Ͻÿ�
	select * from emp where length(job)<=5;
	
-- 5. lengthb() : byte�� ũ�⸦ ��� - ����(1�ڴ� 1byte), �ѱ�(1�ڴ� 2bytes)
	select lengthb('banana'), lengthb('������������'), lengthb('1234') from dual;

/* 6. substr(), substrb() : Ư�� ���ڿ��� �Ϻθ� �����ϴ� �Լ�.
		substr(������, 1���� count�Ͽ� ������ ��ġ����, ������ ���ڿ��� ����) ex) substr(�����ٶ󸶹�,3,3)�� �ϸ� �ٶ󸶰� ���´�.
*/		 
	select substr('�����ٶ󸶹ٻ������', 4,5) from dual;													
	select substr('�����ٶ󸶹�', 3,3) from dual;	

-- ex) job�� �������� 5���� ���ڿ��� �����Ͽ� �̸��� ��å�� ���
	select ename, substr(job,1,5) from emp;

/* Ȯ�ο���
 �Ʒ��� ������ �����͸� ȭ�鿡 list�ϼ���
 ��� �̸� ��å(�̸��� ���ڿ��� ��ŭ�� ǥ��)
*/
	select empno, ename, substr(job,1,length(ename)) from emp;

-- hiredate ��� ������ type�� ��¥���������� �ڵ� ����ȯ�� �Ǿ� ���ڿ�ó�� �Լ��� ���� ���ڿ��� �����Ͽ� ó���� �� �ִ�.	 	
	select substr(hiredate,1,4), hiredate from emp;	
	select substr(hiredate,1,length(hiredate)), hiredate from emp;

-- 1980�� �����͸� ��Ÿ������.
	select * from emp where hiredate like '%80%';
    select * from emp where substr(hiredate,1,2)='80';

-- 1982�⵵ 12���� �Ի��� ����� �̸��� �Ի����� ����ϼ���.
	select ename, hiredate from emp where substr(hiredate,1,5)='82/12';
	select ename, hiredate from emp where hiredate like '82/12%';			
	select ename, hiredate from emp where hiredate like '_2/12%';			
	select ename, hiredate from emp where hiredate like '%2/12%';

/* ����(homework)
 �Լ��� Ȱ���Ͽ� ���� ������ ����غ�����
 1. @@@�� �Ի����� @@�� @@�� @@�� �̸� ���� ������ @@@���� �ް� �ֽ��ϴ�.
 column�� empinfo
 2. substr�� Ȱ���Ͽ� job�� man���� ������ �����͸� ����ϼ���.				
*/
	select ename||'�� �Ի����� '||substr(hiredate,1,2)||'�� '||substr(hiredate,4,2)||'�� '||substr(hiredate,7,2)||'�� �̸� ���� ������ '||sal||'���� �ް� �ֽ��ϴ�.' from emp;	

-- 7. Ư�� ������ ��ġ�� ���ϴ� instr   ���� : instr(������, '�˻��� ����') -- 1���� �����ؼ� �˻��� ������ ù��° ���ڰ� ��Ÿ�� ��ġ
	select instr('�����ٶ󸶹ٻ�', '���ٻ�') from dual;


-- 7-1. instr(������, '�˻��� ����', ������ġ, �˻��� Ƚ��)
	select instr('abcdefbaesb','ba',3,1) from emp;

-- �Ի����� 12���� �������� �̸��� �Ի����� ����ϼ���/ instr()�� Ȱ��
	select ename, hiredate from emp where instr(hiredate,'12',1,1)=4;		
	
	
	
														