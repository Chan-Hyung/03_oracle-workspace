-- 한 줄 짜리 주석

/*
    여러줄
    주석
*/

-- 현재 모든 계정들에 대해서 조회하는 명령문
select * from DBA_USERS; -- 이건 관리자 계정으로 들어왔기 때문에 보인다.
-- 명령문 하나 실행(왼쪽에 초록색 화살표, ctrl + enter)

-- 일반 사용자 계정 생성하는 구문(오로지 관리자 계정에서만 할 수 있음)
-- (표현법) CREATE USER 계정명 IDENTIFIED BY 비밀번호

CREATE USER kh IDENTIFIED BY kh; -- 계정명은 대소문자 상관없음(단, 비밀번호는 상관있음)

-- 계정 추가 => 권한 부족으로 오류

-- 위에서 생성한 일반 사용자 계정에게 최소한의 권한(데이터관리, 접속) 부여
-- (표현법) GRANT 권한1, 권한2, .. to 계정명;

GRANT CONNECT, RESOURCE TO kh;

