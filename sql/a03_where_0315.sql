	select * from emp;
/*
 OR 연산자 : 조회 조건에 있어서, 하나의 조건만 만족하더라도 해당 데이터가 출력 처리되는 것을 말한다.
 SELECT 컬럼 FROM 테이블명 WHERE 컬럼1=조건1 OR 컬럼2=조건2;
 위에서와 같이 컬럼1=조건1이 만족하거나 컬럼2=조건2가 만족할 경우에 해당 데이터를 전부 list한다.
 ex) 부서번호가 30이거나 사원명이 'SMITH'인 데이터를 list하세요.
*/
	select deptno "부서번호", ename "사원명" from emp where deptno=30 or ename='SMITH';

-- 확인 예제. 보너스가 있거나 직책이 'SALESMAN'인 것을 출력하세요
	select * from emp;
	select * from emp where comm is not null or job='SALESMAN';
	
/*
 NOT 연산자
 해당 연산자가 참이면 거짓, 거짓이면 참으로 처리되어 나타낼 필요가 있을때 활용한다.
 일반적으로 조건 이외에 데이터를 리스트하고자 할 경우에 활용된다.
 ex) 부서번호가 10이 아닌 데이터를 list하세요.
*/
	select * from emp where not deptno=10; --deptno <>10, deptno !=10 (동일한 효과)
	select * from emp where deptno!=10;
	select * from emp where deptno>10;

-- 확인 예제. 연봉이 2000~3000이 아닌 데이터들을 not keyword를 활용하여 list하세요.
	select * from emp where not (sal>=2000 and sal<=3000);

-- 확인 예제. 직책이 SALESMAN이 아니고 연봉이 2000이상인 사원을 list하세요.
	select * from emp where not job='SALESMAN' and sal>=2000;
	select * from emp where job!='SALESMAN' and sal>=2000;

/*
 BETWEEN AND 연산자
 데이터의 범위가 특정 조건 사이에 있을때 활용되는 키워드
 where 컬럼명 between A and B;
 해당 데이터중 컬럼명의 범위가 A~B 사이에 있는 것을 말한다.
 ex) 연봉이 2000에서 3000사이에 있는 데이터를 list하세요.
*/
	select * from emp where sal between 2000 and 3000;
	select * from emp where sal>=2000 and sal<=3000;

-- 확인 예제. 사번이 7400~7500사이에 있으며 연봉이 2000미만이거나 3000초과하는 데이터를 list하세요.
	select * from emp where (empno between 7400 and 7500) and not (sal between 2000 and 3000);
	select * from emp where (empno between 7400 and 7500) and (sal<2000 or sal>3000);

/*
 날짜에 대한 처리
 입사일이 1987/01/01에서 1987/21/31 사이에 있는 데이터를 list하세요
*/	
	select * from emp;	
	select * from emp where hiredate between '1981/01/01' and '1981/12/31';
	select * from emp where emp.hiredate between '1981/01/01' and '1981/12/31';
	
-- 입사일이 1981년 12월에 입사한 사람의 이름과 부서명을 출력하세요.
	select ename "이름", deptno "부서번호", hiredate "입사일" from emp where hiredate between '1981/12/01' and '1981/12/31';
	
-- sysdate : 현재 날짜를 출력해주는 키워드
	select ename, hiredate, sysdate from emp;

/*
 IN 연산자
 해당 데이터에 대한 조건을 처리할 떄 여러 데이터에 대한 조회를 하고자 할떄 활용된다
 OR 연산자와 동일한 내용.   컬럼명 IN (해당데이터1, 해당데이터2, 해당데이터3)
 ex) 관리자번호가 7902, 7566, 7839인 것을 list하세요.
*/									
	select * from emp; 
	select * from emp where mgr in (7902, 7566, 7839); 	
	
-- 확인예제. 사원이름이 SMITH, WARD, JONES 인 사람 중에서 연봉 1000미만인 데이터의 이름과 연봉을 출력하세요.
	select ename "이름", sal "연봉" from emp where (ename in ('SMITH', 'WARD', 'JONES')) and sal<1000;

/*
 LIKE 연산자와 와일드카드(_) 활용하기
 특정데이터에 대한 문자열 전체 내용을 정확하게 알지 못할 경우에 데이터를 검색하기위한 LIKE연산자와 와일드 카드를 활용하는 방법이다.
 형식) 검색컬럼명 LIKE '%검색할데이터%';
 ex) 사원명에 K가 포함된 데이터를 list하세요.
*/		
	select * from emp where ename like '%K%';
-- 만약 K로 시작되는 데이터를 list하려면?
	select * from emp where ename like 'K%';
-- 직책에서 MAN으로 끝나는 데이터를 list하세요.
	select * from emp where job like '%MAN'; 		

-- 확인예제. 직책에서 S로 시작하는 데이터에서 보너스가 300이거나 400이거나 700인 데이터를 직책, 사원명, 보너스 순서로 list하세요
	select job "직책", ename "사원명", comm "보너스" from emp where (job like 'S%') and (comm in (300, 400, 700));
	select * from emp;

/*
 와일드카드(_) 사용하기
 _글자수를 제한해서 해당내용을 검색하고자 할 때 활용한다.
 ex) 두번째 글자가 'A'인 사원을 list하세요.
*/	
	select * from emp where ename like '_A%';

-- 확인예제. 사원명의 3번째 글자가 A인 데이터 중에 급여가 2000이상인 것을 list하세요.
	select * from emp where (ename like '__A%') and (sal>2000);	

/*
 NOT LIKE '와일드카드(_)'해당 조건이 아닌 것을 출력
 ex) 이름에 'A'문자가 포함되지 않는 사람만 검색
*/	
	select * from emp where ename not like'%A%';
	
-- 확인예제. 직책이 ER로 끝나지 않는 데이터 중 1981년도에 입사한 사람을 list하세요.
	select * from emp where (job not like '%ER') and (hiredate between '1981/01/01' and '1981/12/31');
	select * from emp where (job not like '%ER') and (hiredate like '%81%');

/*
 정렬처리
 데이터는 일정한 범위 내에서 오름차순, 내림차순으로 정렬처리할 수 있다.
 정렬시 이에 대한 기준되는 컬럼을 정해야 하며 오름차순인지 내림차순인지를 표현해야 한다.
 형식) ORDER BY 기준컬럼1 ASC/DESC
 		 ASC : 오름차순 (기본 defalut값)
		DESC : 내림차순
 ex) 급여를 오름차순으로 출력하세요.		
*/
	select * from emp order by sal asc;		
	select * from emp order by sal;
	select * from emp order by sal desc;

-- 확인예제. 직책이 MANAGER인 데이터를 입사일 기준으로 오름차순 list
	select * from emp where job='MANAGER' order by hiredate asc;

-- 확인예제. 보너스가 있는 데이터를 기준으로 내림차순으로 사원명, 급여, 보너스를 출력하세요.
	select ename "사원명", sal "급여", comm "보너스" from emp where comm is not null order by comm desc;	

/*
 정렬기준이 2중 내지 3중으로 되어 있다면 어떻게 할까?
*/
-- comm의 데이터값이 동일할 경우는 sal기준으로 내림차순 정렬한다.
	select ename "사원명", sal "급여", comm "보너스" from emp order by comm desc, sal desc;	

-- 확인예제1. 입사일을 오름차순으로 정렬하되, 사원번호, 사원명, 직급, 입사입을 출력.
	select * from emp;
	select empno "사원번호", ename "사원이름", job "직급", hiredate "입사일" from emp order by hiredate asc;
	
-- 확인예쩨2. 사원번호를 기준으로 내림차순으로 정렬하여 사원번호와 사원명 출력.
	select empno "사원번호", ename "사원명" from emp order by empno desc;
	
-- 확인예제3. 부서 번호가 빠른 사원부터 출력하되 같은 부서내 사원은 최근 입사한 사원부터 출력(부서번호, 입사일, 사원명, 급여순)
	select deptno "부서번호", hiredate "입사일", ename "사원명", sal "급여" from emp order by deptno asc, hiredate desc;

/*
 dual : 데이터를 테스트하기 위한 용도의 oracle 내장 객체. 한 행으로 출력된다.
 주로 연산, 함수적용내용을 확인하는데 활용된다.
*/	
	select * from dual;	
	select 10+10 from dual;
	select sysdate from dual;
	select 10+10 plus, sysdate from dual;
	select 10+10 plus, sysdate, 10||'+'||10||'='||(10+10) calcu from dual;

	select * from emp;
	
			