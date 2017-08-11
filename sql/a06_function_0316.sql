/*
 DECODE () : 조건 처리를 위한 함수
 	DECODE(데이터, 데이터1, 조건1데이터,
				  데이터2, 조건2데이터,
				  그외의 데이터)
				 
 gender라는 컬럼에 0이 남자, 1이면 여자, 그외에는 중성				  
*/
	select decode(0, 0, '남자', 1, '여자', '중성') gender01,
		   decode(1, 0, '남자', 1, '여자', '중성') gender02,				  
		   decode(2, 0, '남자', 1, '여자', '중성') gender03,			  
		   decode(3, 0, '남자', 1, '여자', '중성') gender04
	from dual;				  
			  

-- 부서번호가 10 회계, 20 감사, 30 영업, 40 운영, 그 외는 '미정'
	select ename, 
		decode(deptno, 10, '회계',
					   20, '감사',
					   30, '영업',
					   40, '운영',
					   '미정') selDept
	from emp;
	
-- job을 한글로 풀이해서 출력처리(CLERK : 점원, SALESMAN : 영업맨 등...)
	select distinct job from emp;
	
	select ename, 
		decode(job, 'CLERK', '점원',
					'SALESMAN', '영업맨',
					'PRESIDENT', '사장',
					'MANAGER', '관리자',
					'ANALYST', '분석가',
					'대기발령') 직책
	from emp;

/*
 과제1. (homework 1)
 연봉에 따른 등급체계를 나누려고 한다. decode를 활용해서 
 1000 미만 - F등급				성과급 3%
 1000 이상 ~ 2000 미만 - E등급		성과급 5%
 2000 이상 ~ 3000 미만 - D등급		성과급 7%
 3000 이상 ~ 4000 미만 - C등급		성과급 4%
 4000 이상 ~ 5000 미만 - B등급		성과급 3%
 5000 이상 - A등급				성과급 2%
 
 이름 부서 연봉 연봉등급 성과급 총액(연봉+성과급)
*/	
	select ename 이름, deptno 부서번호, sal 연봉,
		decode(sal, sal<1000, 'F등급',
			   		sal between 1000 and 2000, 'E등급') from emp;

/*
 CASE 함수 : 조건에 따라 서로 다른 처리가 가능
 CASE WHEN 조건1(비교연산자) THEN 처리할 데이터
	  WHEN 조건2(비교연산자) THEN 처리할 데이터
	  WHEN 조건3(비교연산자) THEN 처리할 데이터
	  ELSE 위 조건에 해당되지 않을 경우 처리할 데이터
 END
 
 ex) 점수에 따른 학점 계산 방법 
*/
	SELECT CASE WHEN 80>=90 THEN 'A'
				WHEN 80>=80 THEN 'B'	  										  					  	  
				WHEN 80>=70 THEN 'C'	  										  					  	  
				WHEN 80>=60 THEN 'D'	  										  					  	  
			    ELSE 'F'
		   END GRADE
	FROM DUAL;
	
-- 부서번호를 기준으로 신규부서에 재배치하려 한다.
	SELECT EMPNO, ENAME, 
		CASE WHEN DEPTNO=10 THEN '부서이동'
			 WHEN DEPTNO=20 THEN '인원감축'		   					  										  					  	  
			 WHEN DEPTNO=30 THEN '전원승진'
		 ELSE '변동없음'
		END RESULT
	FROM EMP;

/* 과제2. (homework 2)
 입사분기 기준 표시(1/4, 2/4, 3/4, 4/4) 입사 분기를 표시
 사원번호 이름 입사(년/월), 입사분기
*/	
	SELECT EMPNO 사원번호, ENAME 이름, TO_CHAR(	 			   					  										  					  	  