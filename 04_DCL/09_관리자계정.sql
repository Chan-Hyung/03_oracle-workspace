/*
    < DCL : DATA CONTROL LANGUAGE >
    데이터 제어 언어
    
    계정에게 시스템권한 또는  객체접근권한을 부여(GRANT)하거나 회수(REVOKE) 하는 구문
    
    -> 시스템 권한 : DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
    -> 객체접근권한 : 특정 객체들을 조작할 수 있는 권한
*/
/*
    - 시스템권한 종류
    1) CREATE SESSION : 접속 할 수 있는 권한
    2) CREATE TABLE : 테이블을 생성할 수 있는 권한
    3) CREATE VIEW : 뷰를 생성할 수 있는 권한
    4) CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
    ... : 일부는 CONNECT안에 포함돼 있음
*/

-- 1. SAMPLE / SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 상태: 실패 -테스트 실패: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

-- 2. 접속을 위해 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;

-- 3-1 테이블을 생성할 수 있는 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;

-- 3-2 TABLESPACE 할당(앞으로 수업에서 쓸 일 없음)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-------------------------------------------------------------------
/*
    - 객체 접근 권한 종류
    특정 객체에 접근해서 조작할 수 있는 권한
    
    - 권한 종류         특정 객체
    1) SELECT     TABLE, VIEW, SEQUENCE
    2) INSERT     TABLE, VIEW
    3) UPDATE     TABLE, VIEW
    4) DELETE     TABLE, VIEW
    
    (표현식)
    GRANT 권한종류 ON 특정객체 TO 계정
    
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

-------------------------------------------------------------
GRANT CONNECT, RESOURCE TO 계정명;

/*
    < 롤 ROLE >
    - 특정 권한들을 하나의 집합으로 모아놓은 것
    
    CONNECT : 접속할 수 있는 권한 CREATE SESSOIN
    RESOURCE : 특정 객체들을 생성 할 수 있는 권한 CREATE TABLE, CREATE SEQUENCE, ...
*/

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE')
ORDER BY 1;




















