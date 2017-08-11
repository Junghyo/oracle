/*
 LPAD/RPAD �Լ� : Ư�� ���ڿ��� �ش��ϴ� ���ڿ��� ä��� ó���� �ϴ� ���� ���Ѵ�.
 	
 LPAD : ���ʿ� �ݺ��� ���ڸ� �ش� ũ�Ⱑ �� ������ ä��		���� : LPAD(������, ����ũ���, '�ݺ��� ����' )
*/	
-- himan�̶�� ���ڿ� ���ʿ� '#'�� 20�� ä���� ���
-- ��ü ũ�⸦ ����� �ش� ũ�Ⱑ ���� ������ ���ڷ� ä��
-- �ǹ� migration varchar : ����������			/		char : ����������
-- ������������ �����͸� �������������� ��ȯ�Ͽ� �̵���ų�� Ȱ��
	select lpad('himan',7,'#') from dual;

/*
 RPAD : �����ʿ� �ݺ��� ���ڸ� �ش� ũ�Ⱑ �� ������ ä��
	ex) good job���� ���ڰ� 20���� �� ������ @�� �����ʿ� ä�켼��
*/
	select rpad('good job',20,'@') from dual;

/* Ȯ�ο���. ename�� job�� �����ȸ�ŭ �����ʰ� ���ʿ� ������ ���ڿ��� �Ʒ� �������� ��������
 1. ename�� job���� ������ ũ�⸦ Ȯ���Ѵ�.
 2. ������ �߿� ���� ū �������� ũ�⸦ Ȯ���ؼ�
 3. eame���� �����ʿ�@, job���� ���ʿ� ^�� �߰��ؼ� ��Ÿ���� �Ѵ�.
 4. ������ ���� ������ ���
 	�����ȣ	�̸�(@) ��å(^) �Ի��� 
*/
	select max(length(ename)), max(length(job)) from emp;
	select empno �����ȣ, rpad(ename,6,'@') "�̸�(@)", lpad(job,9,'^') "��å(^)", hiredate �Ի��� from emp order by "��å(^)"; 
-- �ǹ������� ���� ������ �־� ������ ũ�⸦ ��ġ��Ŵ.

/*
 LTRIM(), RTRIM() : ������ ���ڸ� �����ϴ� �Լ�.
 
 	LTRIM : ������ ���鹮�ڸ� �����ϴ� ó��.
	RTRIM : �������� ���鹮�ڸ� �����ϴ� ó��.
*/
-- ex) ������ ���鹮�ڸ� ����
	select
		'          �ʹ� �����̤�' �⺻, 
		ltrim('          �ʹ� �����̤�') LTRIM���,
		length('          �ʹ� �����̤�') �⺻���ڱ���,
		length(ltrim('          �ʹ� �����̤�')) LTRIM���ڱ���
	from dual;
	
-- ex) �������� ���鹮�ڸ� ����
	select
		'�ξ��ξ� �۸�     ' �⺻,
		rtrim('�ξ��ξ� �۸�     ') RITRIM���,
		length('�ξ��ξ� �۸�     ') �⺻���ڱ���,
		length(rtrim('�ξ��ξ� �۸�     ')) RTRIM���ڱ���
	from dual;	
-- �Ѳ����� ���� ����	
	select '  aaaa    ', rtrim(ltrim('  aaaa    ')), length('  aaaa    '), length(rtrim(ltrim('  aaaa    '))) from dual;	
	
/*
 TRIM : ������, ���ʿ� �ִ� ������ ����ؼ� Ư�� ���ڿ��� ���� ó���ϴ� �Լ�.		���� : TRIM('������ ���ڿ�' FROM ������)
  ex) 'aaaaaaGood morning!!aaaaaa'���� �����ʰ� ������ a�� ����ó��
 */
 	select trim('a' from 'aaaaaaGood morning!!aaaaaa') from emp;

/* Ȯ�ο���. job ������ ���� ���� 'N'�̳� 'R', 'T'�� ������ �����Ͽ� ������ ���� ����ϼ���.
 �̸� ������å ������å 
*/ 	
	select ename �̸�, job ������å, trim('T' from trim('R' from trim('N' from job))) ����NTR������å from emp;	

/*
 ��¥ �Լ�
 SYSDATE : ����Ŭ�� ����� ���� ��¥�� �ð��� ����ϴ� ��ü
*/
 	select sysdate-1 yesterday, sysdate today, sysdate+1 tomorrow from dual;
	select ename, hiredate, sysdate, floor(sysdate-hiredate) from emp;

-- MONTHS_BETWEEN : �ΰ��� ��¥ ������ ������ �������� ���ϴ� ����. 		���� : MONTHS_BETWEEN(�񱳳�¥������1, �񱳳�¥������2)
-- ex) �� �������� �ٹ��� ���� ���� ���ϼ���.
	select ename, hiredate, sysdate, trunc(months_between(sysdate, hiredate)) �ٹ������� from emp;	 	
	select ename, hiredate, sysdate, floor(months_between(sysdate, hiredate)) �ٹ������� from emp;

-- ADD_MONTHS : �̷������� ��Ÿ���� �Լ��� ���� ���� ���ؼ� �ش糯¥�� ��Ÿ���� �Ѵ�. 	���� : ADD_MONTHS(���ص�����, ���� ���� ��)
-- ex) �Ի� ��¥���� 6������ �߰��� ��¥�� ����ϼ���.
	select ename �̸�, hiredate �Ի糯¥, add_months(hiredate,6) "6������" from emp;

/*
 ����1. (homework 1)
 6������ ���ϱⰣ���� �޿��� 70%�� �����ϱ�� �ߴ�.
 ����� ���ϱⰣ ��������� ����ϰ�, 6���� ���� �޿� ������ ����ϼ���.
 ���޿� : sal/13
 ���ϱⰣ : ���޿��� 70%
 ���ϱⰣ ���޿� �Ѿ��� 10���� �����ؼ� ���
 �����ȣ		�����	  �Ի���		���ͱⰣ�������		���޿�	   ���ϱⰣ���޿� 		 ���ϱⰣ���޿��Ѿ�	
*/
	select 
		empno ���, ename �����, hiredate �Ի���,
		add_months(hiredate,6) ���ͱⰣ�������, sal/13 ���޿�,
		sal/13*0.7 ���ϱⰣ���޿�, trunc( (sal/13*0.7*6),-1 ) ���ϱⰣ���޿��Ѿ� from emp; 

-- NEXT_DAY : �� ������ ���� ����� ������ ������ �� Ȱ��		���� : NEXT_DAY(��¥������, '����') -- �ش� ���Ͽ� ���� ����� ��¥ ���
	select sysdate "���ó�¥(�����)", next_day(sysdate,'�����') ��������ϳ�¥ from dual;	

-- ex) ������� �Ի���, ù��° ������� ����ϼ���.
	select ename �̸�, hiredate �Ի���, next_day(hiredate,'�����') ù��°����� from emp;	 	

-- LAST_DAY : �ش� ���� ������ ��¥�� ��ȯó��
	select sysdate ���ó�¥, last_day(sysdate) �̹��޸�������¥, (last_day(sysdate)+1) ��������¥������¥ from emp; 

/*
 ����2. (homework 2)
 �޿���� -- 3�ܰ� �޿����� ����� ����ϼ���.
 1�ܰ�. ��� 20��
 2�ܰ�. ��� ��������
 3�ܰ�. ������ 10��
 ��� �Ի��� ù����1 ù����2 ù����3
*/	
	select hiredate,
		add_months(hiredate,-1),
		add_months(hiredate,-1)-20,
		last_day(add_months(hiredate,-1)-20),
		add_months(last_day(add_months(hiredate,-1)-20),1),
		add_months(last_day(add_months(hiredate,-1)-20),1)+20 from emp;
	select 
		ename ���, hiredate �Ի���,
		add_months(last_day(add_months(hiredate,-1)-20),1)+20 ù����1,
		last_day(hiredate) ù����2, last_day(hiredate)+10 ù����3
	from emp;

/*
 ����ȯ �Լ�
 ����Ŭ���� �����Ͱ� ����ȯ�� �ؼ� �ʿ��� �����̳� type���� ��Ÿ���� �Ѵ�. �� �� Ȱ���ϴ� ���� ����ȯ �Լ��̴�.
 
 TO_CHAR() : ��¥�� �������� ���������� ��ȯ
 TO_DATE() : �������� ��¥������ ��ȯ
 TO_NUMBER() : �������� ���������� ��ȯ
*/	

/* 1) TO_CHAR(��¥������, 'ǥ���� ��������') : ��¥, �������� ���������� ����.		
		ǥ���ϴ� ���� ������ ����
		YYYY : �⵵ ǥ�� 		YY : �⵵ 2�ڸ� ǥ��
		MM : �� ǥ�� 	    	MON : �� �������� ǥ�� 	ex)JAN
		DAY : ���� ǥ�� 		DY : ���� ��� ǥ��
		DD : ���ϳ�¥ ǥ��
*/	
-- ex) �Ի����� �⵵-��-�� �� ǥ���Ͻÿ�.
	select ename �̸�, 
		to_char(hiredate, 'YYYY-MM-DD-DY') �Ի���1,
		to_char(hiredate, 'YY/MM/DD/DY') �Ի���2,
		to_char(hiredate, 'YYYY"��" MM"��" DD"��" DAY') �Ի���2
	from emp;

/*
 Ȯ�ο���. �Ʒ��������� ����ϼ���.
 [����̸�]�� @@�� @@�� @@�Ͽ� �޿��� @@@���� �ޱ�� �ϰ� �Ի��߽��ϴ�.
*/
	select ename||'�� '||to_char(hiredate, 'YYYY"��" MM"��" DD"��" DAY')||'�� �޿��� '||sal||'���� �ޱ�� �ϰ� �Ի��߽��ϴ�.' from emp;	

/* 2)TO_CHAR(��¥������, '��¥���� �ð�����') :  �ð� ������� 
		AM �Ǵ� PM : ����, ���� ǥ��
		AM. �Ǵ� PM. : ����. ����. ǥ��
		HH �Ǵ� HH12 : 12�ð� ����(1~12). hours
		HH24 : 24�ð� ����(0~23). hours
		MI : �� ǥ��. minutes 
		SS : �� ǥ��. seconds		
*/
-- ex) ����ð��� ��¥�� �ð� ���Ŀ� ���� ǥ��
	select to_char(sysdate, 'YYYY/MM/DD HH24:Mi:SS') TODAY from dual;

/*
 ����3. (homework 3)
 �ٹ��������� ���� ���� ���ʽ� ����
 ���� ������ ����~���� �ֱٿ� �Ի��� ���� ��
 1/3=30% 1/3=20% 1/3=10% (��������)
 ���, �Ի���, ���糯¥(@@/@@/@@ AM @@�� @@�� @@��), �ٹ�������, ���ʽ�%, ���ʽ��ݾ�
*/
	select ename ���, hiredate �Ի���, to_char(sysdate,'YY/MM/DD AM HH24"��"MI"��"SS"��"') ���糯¥ from emp;

/* 3) TO_CHAR(������, '����') : �������� ������ ó��
 		�������
			0 : �ڸ����� ���� �ʴ� ���, ������ �ڸ����� ���� �������� �ڸ������� ū ��쿡 0���� ä������.
			9 : �ڸ��� ������� �ش� �����Ͱ� ��Ÿ��. ä������ �ʴ´�.
			L : ������ ���ݴ��� ǥ��
			. : �Ҽ��� ǥ��
			, : õ���� ǥ��
*/
	select to_char(1000,'0000000') from dual; -- �ش� �ڸ������� Ŭ�� 0���� ä����		    		
	select to_char(1000,'9999999') from dual; -- ä������ �ʰ� �����Ͱ��� �״�� ���	
	select to_char(1000,'999') from dual; -- �����Ͱ����� �����ڸ����� ������ #���� ǥ��
	select to_char(24333,'L999999') from dual; -- ������ ���ݴ��� ǥ��(�ѱ��� ��)	
	select to_char(24333,'L999,999') from dual; -- õ����(,) ǥ��.	
	select to_char(24333.2422,'999,999.9999') from dual; -- �Ҽ���(.) ǥ��.

-- ex) �̸��� �޿��� ǥ���ϵ� �޿��� �Ҽ��� ���ϴ� ǥ�õ��� �ʰ�, �ڸ����� 7�ڸ��� ǥ���ϵ� ��Ÿ���� �ʴ� �ڸ��� '0'���� ǥ��
	select ename, to_char(sal,'0000000') sal from emp; 

/* 4) TO_DATE() : �������¸� ��¥�� ó��
		�Է��� ��¥���� ���ڸ� �Է��� �� ��¥ �����͸� ��ȸ ó��
		�˻��� �Ϸ��� ���ڸ� ��¥�� ��ȯ�Ͽ� ó��
		���ڴ� ��¥���·� ��� �ν��ϴ°�?
		ex) 1980/12/12 --> TO_DATE()���� � �������� �Է��� ������ ����.
		T0_DATE(�Էµ�����, '������ ����')
		T0_DATE('19801212','YYYYMMDD')
*/
-- select * from emp where hiredate='12/17/1980';
-- select * from emp where hiredate='12/17/';

-- ex) �Ի����� 1980/12/17�� �����͸� �˻�
	select * from emp where hiredate=to_date('1980/12/17','YYYY/MM/DD');
-- ���ڿ� ==> �Է����� ���� ==> to_date() ó��

-- Ȯ�ο���. �Է°��� '1981-02-20' �̸� �̳� �Ի��� ����� �� �Ի���(1981��02��20��)�� ����Ϸ��� �Ѵ�.
	select ename �����, to_char(hiredate,'YYYY"��"MM"��"DD"��"') "�Ի���(****��**��**��)" from emp where hiredate=to_date('1981-02-20','YYYY-MM-DD');	
	select ename �����, to_char(hiredate,'YYYY"��"MM"��"DD"��"') "�Ի���(****��**��**��)" from emp where hiredate=to_date('1981/02/20','YYYY/MM/DD');	

/*
 ����4. (homework 4)
 ��ȸ���� '1981��01��01��' ���� '1982��12��12��' ������ ������ �߿��� �μ��� 30�� �����͸� ��ȸ�Ͽ� ������ ���� ���
 �����(10�ڸ�-�տ� #��ȣó��)
 ��å(10�ڸ�-������ �ڿ� '-'ó��)
 �Ի���(@@�� @@�� @@�� @���� 24�� @@�� @@��)
 ����(####1,600.0 ǥ��) 
*/	

/* 5) TO_NUMBER(�Է��� ������, '��������')
 ������ ���ڿ��� �ԷµǾ��� ��쿡 ó���ϴ� TO_NUMBER() �Լ�
 �ԷµǴ� ���ڿ��� ������ ���� �� TO_NUMBER�� ������ �Է�ó��
*/
	select to_number('20,000','99,999') - to_number('30,000','99,999') calcu from dual;

-- ������ �˻��Ϸ��� �Ѵ�. '3,000'�̶�� �Է°��� ���� 3000 ���� ������ ���� ����� �̸��� ����(���ݴ���ǥ�� - 3,000)�� ��Ÿ������.
	select ename �̸�, to_char(sal,'L99,999') from emp where sal<to_number('3,000','9,999');  		
	select ename �̸�, to_char(sal,'L99,999') from emp where sal<3000;

/*
 ������ ���ʽ��� �ջ��� �ݾ��� �̸��� �Ѿ����� ǥ���Ϸ��� �Ѵ�. 
 NVL : �ش� �����Ͱ� null�ϋ� ǥ���� default �����͸� �����Ͽ� ���� ���� ������ ���������� �����͸� ó���ϱ� ���� �Լ��̴�.
 ���� : NVL(������, 0)  -- 0
 ���� : NVL(������, ' ') -- ���� ' '
 */	 
 	select sal+nvl(comm,0) from emp; 

/*
 ����5. (homework 5)
 �̸� �����ڹ�ȣ ���ʽ� ==> �����Ͱ� ���� ���� �����ڹ�ȣ ��� '�ְ���', ���ʽ��� '0'ǥ��	
*/
 	select nvl(to_char(mgr),'�ְ���') �����ڹ�ȣ, nvl(comm, 0) ���ʽ� from emp;	
	