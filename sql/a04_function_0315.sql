	select * from emp;
/*
 숫자함수 : 숫자를 처리하는 함수. 
 		   절대값, 수학함수(sin, cos, tan...), 올림(ceil), 반올림(round), 내림(trum, floor), 나머지(mod)를 처리함
*/		   

-- 1. abs() : 절대값. -부호에 관계없이 양수로 처리하는 함수를 말한다.		   
	select 25, -25, -25.63, abs(25), abs(-25), abs(-25.63) from dual;

-- 2. floor() : 소숫점 아래를 버리는 함수.
	select 25, 25.65, -25.45, floor(25), floor(25.65), floor(-25.45) from dual;  

/* 3. round() : 반올림 처리 함수. round(데이터, 반올림할 자리수). 
		반올림한 자리수 : 양수 - 소수점 이하의 자리수 처리. 1일 경우 소수점 둘째자리, 2일 경우 소수점 셋째자리에서 반올림
						음수 - 1의 자리(1), 10의 자리(2)에서 반올림 이런식으로 해당 단위 만큼 반올림 처리
*/
	select 25.27888, round(25.27888,2) from dual;
	select 625.2999, round(625.2999,-2) from dual;	

/*
 과제(homework) 
 sal를 연봉이라고 할 때, 이달 급여분(1/13)을 처리하시오. 단 이달은 보너스가 있는 달입니다.
 출력내용 : 사번, 연봉, 이달급여, 보너스, 총급여액(급여와 보너스는 10단위로 반올림처리한다.)
 */  	
 
-- 4. trunc함수 : 특정 자리수 이하로 절삭처리. trunc(데이터, 자리수처리)
	select trunc(24.2433,2), trunc(24.243, -1) from dual;

/* 과제(homework)
 sal을 기준으로 
 1000 미만  	  - 10% 보너스
 1000~2000미만 - 20% 보너스
 2000~3000미만 - 30% 보너스
 3000~4000미만 - 40% 보너스
 4000~5000미만 - 50% 보너스
 5000 이상 	  - 60% 보너스
 를 지급하기로 했다. 함수를 활용해서 아래 내용을 처리하시오.
 사번 이름 연봉 보너스(%) 보너스	
*/
	select * from emp;
	select empno, ename, sal, (trunc(sal,-3)+1000)/100 from emp;


-- 5. mod함수 : 나머지 함수처리.   형식 : mod(데이터, 나눌수) --- 해당데이터를 나눌 수로 나눈 후, 나머지 내용에 대한 처리.
	select mod(27,2), mod(27,3), mod(27,4) from dual;
-- 사원번호가 홀수인 사람을 검색하세요.
	select * from emp where mod(empno,2)=1;

/* 과제(homework)
 사원을 부서기준으로 1팀과 2팀으로 나누어서 체육대회를 하기로 했다.
 부서번호가 10, 30 ==> 1팀
 부서번호가 20, 40 ==> 2팀
 으로 나누고 다음과 같이 출력하세요.
 부서번호	 사원번호 이름 팀명
*/

/*
 문자 처리 함수
 1. upper 모든 데이터를 대문자로 전환처리. 형태 : upper(데이터)
		일반적으로 운영데이터가 소문자나 대문자가 섞여 입력되어 있는 경우에 해당 데이터를 입력문자(대소문자 구분없이)로 검색할 경우 많이 쓰인다.		 		
*/
	select upper('hi ! good days !!') from dual;

-- 직책을 대소문자 구분 없이 조회하려고 한다. 아래 salesman이라고 입력되어도 검색하려면...
	select * from emp;
	select * from emp where job = upper('salesman');

-- 2. 소문자로 변환하는 lower함수. 형태 : lower(데이터)
	select lower('GOOD Night !!! This Is The BEST DAY !!') from dual;
	select lower(ename), lower(job) from emp;
	
-- 3. initcap함수 : 첫문자만 대문자, 나머지는 소문자 처리. 형태 : initcap(데이터)
	select initcap(ename), initcap(job) from emp;
-- Smith is a Clerk!! 형식출력
	select initcap(ename)||' is a '||initcap(job)||'!!' from emp;

-- 4. 문자길이를 처리하는 length함수. 형태 : length(데이터)
	select length('himan'), length(1234), length('하이하이하이') from dual;

-- 직책이 5자 이하인 데이터를 출력하시오
	select * from emp where length(job)<=5;
	
-- 5. lengthb() : byte의 크기를 출력 - 영문(1자당 1byte), 한글(1자당 2bytes)
	select lengthb('banana'), lengthb('하이하이하이'), lengthb('1234') from dual;

/* 6. substr(), substrb() : 특정 문자열의 일부를 추출하는 함수.
		substr(데이터, 1부터 count하여 시작할 위치지정, 추출할 문자열의 개수) ex) substr(가나다라마바,3,3)를 하면 다라마가 나온다.
*/		 
	select substr('가나다라마바사아자차', 4,5) from dual;													
	select substr('가나다라마바', 3,3) from dual;	

-- ex) job을 기준으로 5개의 문자열을 추출하여 이름과 직책을 출력
	select ename, substr(job,1,5) from emp;

/* 확인예제
 아래의 형식의 데이터를 화면에 list하세요
 사번 이름 직책(이름의 문자열수 만큼만 표시)
*/
	select empno, ename, substr(job,1,length(ename)) from emp;

-- hiredate 경우 데이터 type이 날짜형식이지만 자동 형변환이 되어 문자열처리 함수를 통해 문자열을 추출하여 처리할 수 있다.	 	
	select substr(hiredate,1,4), hiredate from emp;	
	select substr(hiredate,1,length(hiredate)), hiredate from emp;

-- 1980년 데이터를 나타내세요.
	select * from emp where hiredate like '%80%';
    select * from emp where substr(hiredate,1,2)='80';

-- 1982년도 12월에 입사한 사람의 이름과 입사일을 출력하세요.
	select ename, hiredate from emp where substr(hiredate,1,5)='82/12';
	select ename, hiredate from emp where hiredate like '82/12%';			
	select ename, hiredate from emp where hiredate like '_2/12%';			
	select ename, hiredate from emp where hiredate like '%2/12%';

/* 과제(homework)
 함수를 활용하여 다음 내용을 출력해보세요
 1. @@@님 입사일은 @@년 @@월 @@일 이며 현재 연봉은 @@@만원 받고 있습니다.
 column명 empinfo
 2. substr을 활용하여 job이 man으로 끝나는 데이터를 출력하세요.				
*/
	select ename||'님 입사일은 '||substr(hiredate,1,2)||'년 '||substr(hiredate,4,2)||'월 '||substr(hiredate,7,2)||'일 이며 현재 연봉은 '||sal||'만원 받고 있습니다.' from emp;	

-- 7. 특정 문자의 위치를 구하는 instr   형태 : instr(데이터, '검색할 문자') -- 1부터 시작해서 검색할 문자의 첫번째 글자가 나타는 위치
	select instr('가나다라마바사', '마바사') from dual;


-- 7-1. instr(데이터, '검색할 문자', 시작위치, 검색한 횟수)
	select instr('abcdefbaesb','ba',3,1) from emp;

-- 입사일이 12월인 데이터의 이름과 입사일을 출력하세요/ instr()을 활용
	select ename, hiredate from emp where instr(hiredate,'12',1,1)=4;		
	
	
	
														