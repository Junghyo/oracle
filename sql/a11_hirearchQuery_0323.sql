/*
 계층형 쿼리 (계층형 질의)
 	오라클에서 계층형 구조의 테이블을 효과적으로 지원하기 위한 QUERY를 말한다. (SELF JOIN을 효과적으로 처리)

 계층형 구조 : 상하위 관계에 테이블 구조를 설정한 것을 말한다.
 	ex) 							할아버지(id, parent_id, role : 1, 0, '할아버지')
 	      아버지(id, parent_id, role : 2, 1, '아버지')			삼촌(id, parent_id, role : 3, 1, '삼촌')
			아들(id, parent_id, role : 4, 2, '아들')			사촌(id, parent_id, role : 5, 3, '사촌')
			
 계층형 SQL 형식
	SELECT....컬럼 FROM 테이블명 WHERE 조건 START WITH 조건(비교연산자)컬럼=데이터 CONNECT BY [NOCYCLE] 조건 AND 조건
		
	START WITH 조건(비교연산자)컬럼=데이터: 계층형 SQL의 시작조건 처리 - 최상위 계층의 조건처리.		
		ex) 가족관계의 최상위 계층은 parentId=0
			우리가족만 계층 내용을 처리하고자 할 경우, parentId=2(아버지 계층 이후로 나타남)
	
	CONNECT BY [NOCYCLE] 조건 AND 조건 : 상하위 관계를 연결시켜주는 조건에 대한 선언. NOCYCLE은 반복여부에 대한 처리
		ex) CONNECT BY id = parent_id  : 현재 id값을 확인해서 상위에 있는 id값의 존재여부를 하위데이터에 확인해서 계층구조로 나타나게 하는 것을 말한다.
	
	PRIOR : 사전 - 상하위 관계에 대해 처리하게 됨		
*/
	select * from emp;
-- ex) EMP 테이블을 기준으로 계층구조의 내용을 처리하고자 한다. (MGR과 EMPNO가 매핑되어 있음)
	select ename, job, empno, mgr from emp start with mgr is null			-- 최상위계층의 조건은 mgr이 null일 때 (job=president)
	connect by prior empno=mgr; 											-- 최상위컬럼과 하위 컬럼과의 연결처리
	
/*
 계층형으로 mgr이 null일때 부터 시작하여 하위계층이 empno로 mgr이 있는지 여부를 확인하여 해당하는 mgr의 데이터가 empno에 없을 때까지
 일단 하나의 NODE전체를 리스팅한다.
 
 ## COLUMN 옵션 : LEVEL - 해당 계층의 계층단계를 표시
 		ex) 최상위 데이터는 1, 차상위는 2, .....
*/
	select level ename, job, empno, mgr from emp start with mgr is null			-- 최상위 데이터(president)는 레벨1, 차상위 데이터(manager)는 2, ....로 표시
	connect by prior empno=mgr; 		

/* 계층형으로 간격을 처리 : LPAD('왼쪽에 입력할 문자', 반복할 횟수)
	
	'    ' : 공백을 기본으로 4칸씩. LPAD( '    ', 4*(LEVEL) ) || job
*/	
-- ex) LEVEL별로 계층형이 표시될 수 있게끔 처리	
	select level ename, lpad('   ',4*(level))||job, empno, mgr from emp start with mgr is null			
	connect by prior empno=mgr; 

-- ex) 학인예제. family를 계층구조로 출력하세요.
-- 출력형식 : level role 이름
	select * from family;
	insert into family values(1, 0, '할아버지', '홍길동');
	insert into family values(2, 1, '아버지', '홍정길');
	insert into family values(3, 2, '아들', '홍현호');
	insert into family values(4, 1, '삼촌', '홍정호');
	insert into family values(5, 2, '딸', '홍진영');
	insert into family values(6, 1, '고모', '홍진경');
	insert into family values(7, 4, '사촌', '홍미미');
	
	select level, name, lpad(' ',4*(level-1))||role01, numid, parentnumid from family start with parentnumid=0 connect by prior numid=parentnumid;

/*
 ORDER SIBLINGS BY 컬럼 ASC/DESC : 해당 계층구조 컬럼에 대한 같은 레벨의 정렬 순서를 설정한다.
 	레벨이 같고 부모가 같은 데이터들에 대한 LIST 우선 순위를 결정
 	- 최근에 등록된 같은 레벨의 데이터를 먼저 LIST - DESC
	- 처음에 등록된 같은 레벨의 데이터를 먼저 LIST - ASC
*/
	select level, name, lpad(' ',4*(level-1))||role01, numid, parentnumid from family
		start with parentnumid=0 connect by prior numid=parentnumid order siblings by numid desc;
	
	insert into family values(8,1,'큰아버지','홍경민');		
	insert into family values(9,0,'작은할아버지','홍찐따');	

/*
 BOARD 계층형 게시판 테이블을 만들어서 LIST하기
 	고유id(글번호),		상위id, 		타이틀, 		내용, 			등록일자, 	수정일자, 	작성자, 		
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
/* 글등록
(1, 0, '글등록 시작', '존나피곤', sysdate, sysdate,'요다')
*/
	insert into board values(1, 0, '글등록 시작', '존나피곤', sysdate, sysdate,'요다');		
	insert into board values(2, 0, '2번째 글', '존나 피곤하다고', sysdate, sysdate,'찐따');		
	insert into board values(3, 1, '1번째글 답', 'ㅇㅇ 개피곤', sysdate, sysdate,'백수');		
	insert into board values(4, 1, '어쩌라고', '??', sysdate, sysdate,'LG짱짱맨');		
	insert into board values(5, 2, '2번째글 답', '개졸립다', sysdate, sysdate,'무적엘지');		
	insert into board values(6, 3, '아 시팔', '자고싶다', sysdate, sysdate,'박용택');		
	insert into board values(7, 4, '엘지짱짱', '엘지우승을 희망합니다', sysdate, sysdate,'오지환');		
	insert into board values(8, 3, '쓸말이없다', '그냥 자고싶다', sysdate, sysdate,'라뱅쓰리런');
	insert into board values(9, 6, 'ㅋ', 'ㅋㅋㅋㅋ', sysdate, sysdate,'ㅇㅇ');
	insert into board values(10, 9, 'ㅎ', 'ㅎㅎㅎ', sysdate, sysdate,'ㅇㅇ');
	insert into board values(11, 8, 'ㅜㅜ', 'ㅠㅠㅠㅠㅠ', sysdate, sysdate,'ㅇㅇ');
	insert into board values(12, 0, 'ㅎㅇ', 'ㅎㅇㅎㅇ', sysdate, sysdate,'ㅇㅇ');
	insert into board values(13, 1, '방가', 'ㅎㅇㅎㅇ', sysdate, sysdate,'ㅇㅇ');
	insert into board values(14, 2, '하이', 'ㅇㅇ', sysdate, sysdate,'ㅇㅇ');
	insert into board values(15, 1, '1등짱짱', 'ㅊㅋㅊㅋ', sysdate, sysdate,'ㅇㅇ');
	
	select no, lpad(' ',4*(level-1))||title, content, to_char(credite,'YYYY/MM/DD') credite, writer from board
		start with parent_no=0 connect by prior no = parent_no order siblings by no desc;
-- ROWNUM을 붙이지 않아 NO 리스트가 엉켜있음		

-- ROWNUM : 데이터 리스트에서 고유로 NUMBERING에 붙는 키워드. (데이터가 입력된 순서 상관없이 순차적으로 숫자 매김)
	select rownum, emp.* from emp;
	
		select rownum, no, lpad(' ',4*(level-1))||title, content, to_char(credite,'YYYY/MM/DD') credite, writer from board
		start with parent_no=0 connect by prior no = parent_no order siblings by no desc;					