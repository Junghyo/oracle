/*
 ## 사용자 계정으로 접속하는 방법
 	1) CMD에서 접속하는 방법 
		sqlplus system/1111 또는 sqlplus scott/tiger
	
	2) SQL COMMAND LINE에서 접속하는 방법
		sql> conn 계정명/비밀번호

 ## 여러가지 CLIENT	툴을 이용해서 접근 주요 핵심 정보
 IP / PORT번호 / SID / 계정-비밀번호	
*/

/*
 사용자 생성하기	 (system 계정 worksheet에서 처리)
 CREATE USER 사용자명 IDENTIFIED BY 패스워드;
 ex) scott01이란 계정에 비밀번호를 tiger로 설정하여 생성.
*/
	create user scott01 identified by tiger;
