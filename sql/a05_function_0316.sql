/*
 LPAD/RPAD 함수 : 특정 문자열에 해당하는 문자열로 채우는 처리를 하는 것을 말한다.
 	
 LPAD : 왼쪽에 반복할 문자를 해당 크기가 될 때까지 채움		형태 : LPAD(데이터, 문자크기수, '반복할 문자' )
*/	
-- himan이라는 문자열 왼쪽에 '#'로 20번 채워서 출력
-- 전체 크기를 만들고 해당 크기가 되지 않으면 문자로 채움
-- 실무 migration varchar : 가변문자형			/		char : 고정문자형
-- 가변문자형의 데이터를 고정문자형으로 전환하여 이동시킬때 활용
	select lpad('himan',7,'#') from dual;

/*
 RPAD : 오른쪽에 반복할 문자를 해당 크기가 될 때까지 채움
	ex) good job에서 문자가 20개가 될 때까지 @로 오른쪽에 채우세요
*/
	select rpad('good job',20,'@') from dual;

/* 확인예제. ename과 job에 지정된만큼 오른쪽과 왼쪽에 지정된 문자열을 아래 형식으로 넣으세요
 1. ename과 job에서 데이터 크기를 확인한다.
 2. 데이터 중에 가장 큰 데이터의 크기를 확인해서
 3. eame에는 오른쪽에@, job에는 왼쪽에 ^를 추가해서 나타나게 한다.
 4. 다음과 같은 순서로 출력
 	사원번호	이름(@) 직책(^) 입사일 
*/
	select max(length(ename)), max(length(job)) from emp;
	select empno 사원번호, rpad(ename,6,'@') "이름(@)", lpad(job,9,'^') "직책(^)", hiredate 입사일 from emp order by "직책(^)"; 
-- 실무에서는 보통 공백을 넣어 데이터 크기를 일치시킴.

/*
 LTRIM(), RTRIM() : 공백의 문자를 삭제하는 함수.
 
 	LTRIM : 왼쪽의 공백문자를 삭제하는 처리.
	RTRIM : 오른쪽의 공백문자를 삭제하는 처리.
*/
-- ex) 왼쪽의 공백문자를 제거
	select
		'          너무 졸려ㅜㅜ' 기본, 
		ltrim('          너무 졸려ㅜㅜ') LTRIM사용,
		length('          너무 졸려ㅜㅜ') 기본문자길이,
		length(ltrim('          너무 졸려ㅜㅜ')) LTRIM문자길이
	from dual;
	
-- ex) 오른쪽의 공백문자를 제거
	select
		'부엉부엉 멍멍     ' 기본,
		rtrim('부엉부엉 멍멍     ') RITRIM사용,
		length('부엉부엉 멍멍     ') 기본문자길이,
		length(rtrim('부엉부엉 멍멍     ')) RTRIM문자길이
	from dual;	
-- 한꺼번에 적용 가능	
	select '  aaaa    ', rtrim(ltrim('  aaaa    ')), length('  aaaa    '), length(rtrim(ltrim('  aaaa    '))) from dual;	
	
/*
 TRIM : 오른쪽, 왼쪽에 있는 공백을 비롯해서 특정 문자열을 삭제 처리하는 함수.		형태 : TRIM('삭제할 문자열' FROM 데이터)
  ex) 'aaaaaaGood morning!!aaaaaa'에서 오른쪽과 왼쪽의 a를 삭제처리
 */
 	select trim('a' from 'aaaaaaGood morning!!aaaaaa') from emp;

/* 확인예제. job 데이터 양쪽 끝에 'N'이나 'R', 'T'가 있으면 삭제하여 다음과 같이 출력하세요.
 이름 기존직책 삭제직책 
*/ 	
	select ename 이름, job 기존직책, trim('T' from trim('R' from trim('N' from job))) 양쪽NTR삭제직책 from emp;	

/*
 날짜 함수
 SYSDATE : 오라클에 내장된 현재 날짜와 시간을 출력하는 객체
*/
 	select sysdate-1 yesterday, sysdate today, sysdate+1 tomorrow from dual;
	select ename, hiredate, sysdate, floor(sysdate-hiredate) from emp;

-- MONTHS_BETWEEN : 두개의 날짜 데이터 사이의 개월수를 구하는 내용. 		형태 : MONTHS_BETWEEN(비교날짜데이터1, 비교날짜데이터2)
-- ex) 각 직원들의 근무한 개월 수를 구하세요.
	select ename, hiredate, sysdate, trunc(months_between(sysdate, hiredate)) 근무개월수 from emp;	 	
	select ename, hiredate, sysdate, floor(months_between(sysdate, hiredate)) 근무개월수 from emp;

-- ADD_MONTHS : 미래시점을 나타내는 함수로 개월 수를 더해서 해당날짜가 나타나게 한다. 	형태 : ADD_MONTHS(기준데이터, 이후 개월 수)
-- ex) 입사 날짜에서 6개월을 추가한 날짜를 출력하세요.
	select ename 이름, hiredate 입사날짜, add_months(hiredate,6) "6개월후" from emp;

/*
 과제1. (homework 1)
 6개월의 인턴기간에는 급여의 70%만 지급하기로 했다.
 사원의 인턴기간 만료시점을 출력하고, 6개월 간의 급여 총합을 계산하세요.
 월급여 : sal/13
 인턴기간 : 월급여의 70%
 인턴기간 월급여 총액을 10단위 절삭해서 출력
 사원번호		사원명	  입사일		인터기간만료시점		월급여	   인턴기간월급여 		 인턴기간월급여총액	
*/
	select 
		empno 사번, ename 사원명, hiredate 입사일,
		add_months(hiredate,6) 인터기간만료시점, sal/13 월급여,
		sal/13*0.7 인턴기간월급여, trunc( (sal/13*0.7*6),-1 ) 인턴기간월급여총액 from emp; 

-- NEXT_DAY : 주 단위로 가장 가까운 요일을 산출할 때 활용		형태 : NEXT_DAY(날짜데이터, '요일') -- 해당 요일에 가장 가까운 날짜 출력
	select sysdate "오늘날짜(목요일)", next_day(sysdate,'목요일') 다음목요일날짜 from dual;	

-- ex) 사원들의 입사후, 첫번째 토요일을 출력하세요.
	select ename 이름, hiredate 입사일, next_day(hiredate,'토요일') 첫번째토요일 from emp;	 	

-- LAST_DAY : 해당 달의 마지막 날짜를 반환처리
	select sysdate 오늘날짜, last_day(sysdate) 이번달마지막날짜, (last_day(sysdate)+1) 마지막날짜다음날짜 from emp; 

/*
 과제2. (homework 2)
 급여계산 -- 3단계 급여일을 나누어서 출력하세요.
 1단계. 당월 20일
 2단계. 당월 마지막날
 3단계. 다음달 10일
 사원 입사일 첫월급1 첫월급2 첫월급3
*/	
	select hiredate,
		add_months(hiredate,-1),
		add_months(hiredate,-1)-20,
		last_day(add_months(hiredate,-1)-20),
		add_months(last_day(add_months(hiredate,-1)-20),1),
		add_months(last_day(add_months(hiredate,-1)-20),1)+20 from emp;
	select 
		ename 사원, hiredate 입사일,
		add_months(last_day(add_months(hiredate,-1)-20),1)+20 첫월급1,
		last_day(hiredate) 첫월급2, last_day(hiredate)+10 첫월급3
	from emp;

/*
 형변환 함수
 오라클에서 데이터간 형변환을 해서 필요한 형식이나 type으로 나타내야 한다. 이 때 활용하는 것이 형변환 함수이다.
 
 TO_CHAR() : 날짜나 숫자형을 문자형으로 변환
 TO_DATE() : 문자형을 날짜형으로 변환
 TO_NUMBER() : 문자형을 숫자형으로 변환
*/	

/* 1) TO_CHAR(날짜데이터, '표현할 문자형태') : 날짜, 숫자형을 문자형으로 변형.		
		표현하는 문자 형태의 종류
		YYYY : 년도 표시 		YY : 년도 2자리 표시
		MM : 월 표시 	    	MON : 월 영문으로 표시 	ex)JAN
		DAY : 요일 표시 		DY : 요일 약어 표시
		DD : 요일날짜 표시
*/	
-- ex) 입사일을 년도-월-일 로 표시하시오.
	select ename 이름, 
		to_char(hiredate, 'YYYY-MM-DD-DY') 입사일1,
		to_char(hiredate, 'YY/MM/DD/DY') 입사일2,
		to_char(hiredate, 'YYYY"년" MM"월" DD"일" DAY') 입사일2
	from emp;

/*
 확인예제. 아래형식으로 출력하세요.
 [사원이름]은 @@년 @@월 @@일에 급여를 @@@만원 받기로 하고 입사했습니다.
*/
	select ename||'은 '||to_char(hiredate, 'YYYY"년" MM"월" DD"일" DAY')||'에 급여를 '||sal||'만원 받기로 하고 입사했습니다.' from emp;	

/* 2)TO_CHAR(날짜데이터, '날짜형식 시간형식') :  시간 출력형식 
		AM 또는 PM : 오전, 오후 표시
		AM. 또는 PM. : 오전. 오후. 표시
		HH 또는 HH12 : 12시간 형식(1~12). hours
		HH24 : 24시간 형식(0~23). hours
		MI : 분 표시. minutes 
		SS : 초 표시. seconds		
*/
-- ex) 현재시간을 날짜와 시간 형식에 의해 표시
	select to_char(sysdate, 'YYYY/MM/DD HH24:Mi:SS') TODAY from dual;

/*
 과제3. (homework 3)
 근무개월수에 따른 차등 보너스 지급
 가장 오래된 개월~가장 최근에 입사한 개월 수
 1/3=30% 1/3=20% 1/3=10% (연봉기준)
 사원, 입사일, 현재날짜(@@/@@/@@ AM @@시 @@분 @@초), 근무개월수, 보너스%, 보너스금액
*/
	select ename 사원, hiredate 입사일, to_char(sysdate,'YY/MM/DD AM HH24"시"MI"분"SS"초"') 현재날짜 from emp;

/* 3) TO_CHAR(데이터, '형식') : 숫자형을 문자형 처리
 		출력형식
			0 : 자릿수가 맞지 않는 경우, 지정된 자리수가 실제 데이터의 자리수보다 큰 경우에 0으로 채워진다.
			9 : 자리수 상관없이 해당 데이터가 나타남. 채워지지 않는다.
			L : 지역별 현금단위 표시
			. : 소숫점 표시
			, : 천단위 표시
*/
	select to_char(1000,'0000000') from dual; -- 해당 자리수보다 클때 0으로 채워짐		    		
	select to_char(1000,'9999999') from dual; -- 채워지지 않고 데이터값이 그대로 출력	
	select to_char(1000,'999') from dual; -- 데이터값보다 글자자리수가 적으면 #으로 표시
	select to_char(24333,'L999999') from dual; -- 지역별 현금단위 표시(한국은 원)	
	select to_char(24333,'L999,999') from dual; -- 천단위(,) 표시.	
	select to_char(24333.2422,'999,999.9999') from dual; -- 소수점(.) 표시.

-- ex) 이름과 급여를 표시하되 급여의 소숫점 이하는 표시되지 않고, 자리수는 7자리로 표시하되 나타나지 않는 자리는 '0'으로 표시
	select ename, to_char(sal,'0000000') sal from emp; 

/* 4) TO_DATE() : 문자형태를 날짜로 처리
		입력한 날짜형의 문자를 입력할 때 날짜 데이터를 조회 처리
		검색을 하려면 문자를 날짜로 변환하여 처리
		문자는 날짜형태로 어떻게 인식하는가?
		ex) 1980/12/12 --> TO_DATE()에서 어떤 형식으로 입력할 것인지 지정.
		T0_DATE(입력데이터, '형식을 지정')
		T0_DATE('19801212','YYYYMMDD')
*/
-- select * from emp where hiredate='12/17/1980';
-- select * from emp where hiredate='12/17/';

-- ex) 입사일이 1980/12/17인 데이터를 검색
	select * from emp where hiredate=to_date('1980/12/17','YYYY/MM/DD');
-- 문자열 ==> 입력형식 지정 ==> to_date() 처리

-- 확인예제. 입력값이 '1981-02-20' 이며 이날 입사한 사원명 및 입사일(1981년02월20일)을 출력하려고 한다.
	select ename 사원명, to_char(hiredate,'YYYY"년"MM"월"DD"일"') "입사일(****년**월**일)" from emp where hiredate=to_date('1981-02-20','YYYY-MM-DD');	
	select ename 사원명, to_char(hiredate,'YYYY"년"MM"월"DD"일"') "입사일(****년**월**일)" from emp where hiredate=to_date('1981/02/20','YYYY/MM/DD');	

/*
 과제4. (homework 4)
 조회값이 '1981년01월01일' 부터 '1982년12월12일' 사이의 데이터 중에서 부서가 30인 데이터를 조회하여 다음과 같이 출력
 사원명(10자리-앞에 #기호처리)
 직책(10자리-나머지 뒤에 '-'처리)
 입사일(@@년 @@월 @@일 @요일 24시 @@분 @@초)
 연봉(####1,600.0 표시) 
*/	

/* 5) TO_NUMBER(입력할 데이터, '형식지정')
 숫자형 문자열이 입력되었을 경우에 처리하는 TO_NUMBER() 함수
 입력되는 문자열의 형식을 지정 후 TO_NUMBER로 데이터 입력처리
*/
	select to_number('20,000','99,999') - to_number('30,000','99,999') calcu from dual;

-- 연봉을 검색하려고 한다. '3,000'이라는 입력값을 통해 3000 이하 연봉을 가진 사람의 이름과 연봉(현금단위표시 - 3,000)을 나타내세요.
	select ename 이름, to_char(sal,'L99,999') from emp where sal<to_number('3,000','9,999');  		
	select ename 이름, to_char(sal,'L99,999') from emp where sal<3000;

/*
 연봉과 보너스를 합산한 금액을 이름과 총액으로 표시하려고 한다. 
 NVL : 해당 데이터가 null일떄 표현할 default 데이터를 지정하여 값이 없을 떄에도 정상적으로 데이터를 처리하기 위한 함수이다.
 숫자 : NVL(데이터, 0)  -- 0
 문자 : NVL(데이터, ' ') -- 공백 ' '
 */	 
 	select sal+nvl(comm,0) from emp; 

/*
 과제5. (homework 5)
 이름 관리자번호 보너스 ==> 데이터가 없을 때는 관리자번호 경우 '최고레벨', 보너스는 '0'표시	
*/
 	select nvl(to_char(mgr),'최고레벨') 관리자번호, nvl(comm, 0) 보너스 from emp;	
	