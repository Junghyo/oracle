	select * from emp;
/*
 그룹합수 : 데이터를 그룹별로 통계치를 처리할 때 활용된다.
 
 SUM() : 총합산
 AVG() : 평균
 COUNT() : 갯수
 MAX() : 최대값
 MIN() : 최소값
*/
	select sum(sal) sum, avg(sal) avg, count(sal) count, max(sal) max, min(sal) min from emp;

/* 그룹별로 데이터의 통계치 처리하기
	SELECT 처리할그룹컬럼, 그룹함수 FROM 테이블명 (WHERE 조건..) GROUP BY 처리할그룹컬럼;
*/

-- ex) 부서번호별로 총합산 연봉액을 출력하세요.
	select deptno, sum(sal), avg(sal), count(sal), max(sal), min(sal) from emp group by deptno;
	
-- 전체 데이터 건수를 확인하세요. SELECT COUNT(컬럼, 전체(*) ) FROM 테이블명;
	select count(*) from emp;
	select count(comm) from emp;		   -- 특정 컬럼에 null값이 있으면 카운트에 포함되지 않음.
	select count(nvl(comm,0)) from emp;    -- 공백이 있는 컬럼을 nvl로 null값을 표시해주면 카운트에 포함됨. 

-- 중복되는 데이터에 대한 건수 확인.   SELECT COUNT( DISTINCT 컬럼명 ) FROM 테이블명;
-- 중복된 데이터 2개 이상은 카운트에 포함되지 않음. ex) job에 salesman이 2개 이상 있으면 하나만 카운트 처리.
	select count(distinct job) 중복된것제외카운트 from emp;

-- 연봉이 3000이상인 사람중에 직책별로 인원수를 구하세요.
	select count(job), job, avg(sal) from emp where sal>=3000 group by job order by avg(sal);

-- 확인 예제. 입사일이 1~3월인 사람을 부서별로 인원수를 체크하세요.
	select deptno, count(deptno) from emp where to_number(to_char(hiredate,'MM')) between 1 and 3 group by deptno;					
	select deptno, count(deptno) from emp where to_char(hiredate,'MM') between '01' and '03' group by deptno;	

-- 데이터를 입사한 분기별로 건수를 처리하는 내용
	select floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1, count(*) from emp group by floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1;
	
	select hiredate, to_char(hiredate,'MM') from emp;	-- TO_CHAR(HIREDATE, 'MM') HIREDATE 날짜형 데이터를 월단위 문자로 출력
	select hiredate, to_number(to_char(hiredate,'MM')) from emp; -- TO_NUMBER() : 연산을 위해서 문자를 숫자형으로 변환처리. 'MM'문자형 -> MM 숫자형
	select hiredate, to_number(to_char(hiredate,'MM'))/4 from emp; -- 4로 나눔				
	select hiredate, floor(to_number(to_char(hiredate,'MM'))/4) from emp;  -- floor로 소수점을 버림.(내림처리)				
	select hiredate, floor(to_number(to_char(hiredate,'MM'))/4)+1 from emp;  -- +1로 정성 분기 처리
	select floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1, count(*) from emp group by floor((to_number(to_char(hiredate,'MM'))/4+0.25))+1;

/* 과제1. (homework 1)
 연봉 단위별로 인원수를 체크하세요.
 1000 미만         사원수(최고치, 최저치, 평균치)
 1000~2000 미만				
 2000~3000 미만				
 3000~4000 미만				
 4000~5000 미만
 5000~6000 미만
*/ 	

/* 그룹별로 데이터를 처리한 후에 만들어진 그룹에 대한 조건을 처리
	SELECT 처리할그룹컬럼, 그룹함수
	FROM 테이블명
	(WHERE 조건..)              ## 그룹을 처리하기 전 조건
	GROUP BY 처리할그룹컬럼;
	HAVING 그룹에 대한 조건처리    ## 그룹이 된 후에 조건	
*/
-- HAVING 조건 : GROUP BY 안에 주어진 그룹의 데이터에 대한 조건을 처리하고자 할 때 활용된다.
-- ex) 부서별로 평균연봉을 처리하고 그룹별 평균연봉에서 2000 이상인 데이터를 로딩하세요.
	select deptno, avg(sal) from emp group by deptno;
	select deptno, avg(sal) from emp where sal>=2000 group by deptno;           -- 평균을 그룹별로 내기 전의 조건처리
	select deptno, avg(sal) from emp group by deptno having avg(sal)>=2000;	    -- 평균을 구룹내에서 조건처리

-- 예제.부서의 최대값과 최소값을 구하되 최대급여가 2900이상인 부서만 출력처리
	select deptno, max(sal), min(sal) from emp group by deptno;
	select deptno, max(sal), min(sal) from emp group by deptno having max(sal)>=2900;
			