/*
    DQL (QUERY 데이터 질의 언어) : SELECT
    
    DML (MENIPULATION 데이터 조작 언어) : [SELECT,] INSERT, UPDATE, DELETE
    DDL (DEFINITION 데이터 정의 언어) : CREATE, ALTER, DROP
    DCL (CONTROL 데이터 제어 언어) : GRANT, REVOKE, [COMMIT, ROLLBACK]
    
    TCL (TRANSACTION 트렌젝션 제어 언어) : COMMIT, ROLLBACK

    < DML : DATA MATIPULATION LANGUAGE >
    데이터 조작 언어
    
    테이블에 값을  삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
*/
/*
    1. INSERT
    테이블에 새로운 행을 추가하는 구문
    
    (표현식)
    1) INSERT INTO 테이블명 VALUES(값1, 값2, ...);
        테이블의 모든 컬럼에 대한 값을 제시해서 한 행 INSERT 하고자 할 때 사용
        컬럼 순번을 지켜서 VALUES에 값을 나열 해야함.
        
        VALUES에 값을 부족하거나 많이 제시하면 => not enough values / too many values 오류뜸
*/

INSERT INTO EMPLOYEE
VALUES(900, '차은우', '900101-1234567', 'cha_00@kh.or.kr', '01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;

/*
    2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값1, 값2, 값3);
        테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
        그래도 한 행 단위로 추가되기 때문에 선택이 안된 컬럼은 기본적으로 NULL 표시
        => NOT NULL 제약 조건이 걸려있는 컬럼은 반드시 선택해서 직접 값을 제시해야함.
        단, DEFAULT 값이 있는 경우는 NULL이 아닌 DEFAULT 값이 들어감.
*/
INSERT 
  INTO EMPLOYEE
       (
          EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        )
VALUES
        (901
        , '박보검'
        , '880101-1111111'
        , 'J1'
        , 'S2'
        , SYSDATE
        );

SELECT * FROM EMPLOYEE;
-----------------------------------------------------------------------------------------------------------------------
/*
    3) INSERT INTO 테이블명 (서브쿼리)
        VALUES로 값 직접 명시하는거 대신에
        서브쿼리로 조회된 결과값을 통째로 INSERT 가능
*/

-- 새로운 테이블 셋팅
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- 전체 사원들의 사변, 이름, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON  (DEPT_CODE = DEPT_ID); 

INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON  (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;
------------------------------------------------------------------------------------------------------
/*
    2. INSERT ALL 
*/

-- 테스트할 테이블
-- 구조만 배끼기

CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1 = 0;
   
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1 = 0;
   
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- 부서코드가 D1인 사원들의 사번, 이름, 부서콛, 입사일, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    표현식
    INSERT ALL
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    서브쿼리;
*/
INSERT ALL 
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_01 VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    
-- 조건을 사용해서도 각 테이블에 INSERT 가능
---> 2000년도 이전 입사한 입사자들에 대한 정보 담을 테이블
-- 테이블 구조만 배껴서 먼저 만들기
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;



---> 2000년도 이후 입사한 입사자들에 대한 정보 담을 테이블
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
    표현식
    INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블1 VALUES(컬럼명, 컬럼명, ...)
    WHEN 조건2 THEN
        INTO 테이블2 VALUES(컬럼명, 컬럼명, ...)
    서브쿼리;
*/
INSERT ALL
WHEN HIRE_DATE < '2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
--------------------------------------------------------------------------------------------------
/*
    3. UPDATE
    테이블에 기록되어있는 기존의 데이터를 수정하는 구문
    
    표현식
    UPDATE 테이블명
        SET 컬럼명 = 바꿀값,
            컬럼명 = 바꿀값,
            ... => 여러개의 컬럼값 동시에 변경 가능
    [WHERE 조건] => 생략하면 전체 테이블에 있는 모든 데이터가 변경됨.
*/

-- 복사본 테이블 만들어서 작업
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- D9 부서의 부서명을 '전략기획팀'으로 수정
UPDATE DEPT_COPY
    SET DEPT_TITLE = '전략기획팀' -- 총무부
WHERE DEPT_ID = 'D9'; -- 잘못하면 ROLLBACK가능

SELECT * FROM DEPT_COPY;

-- 복사본 떠서 진행
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- 노홍철 사원의 급여를 100만원으로 변경 -- 데이터 백업
UPDATE EMP_SALARY
    SET SALARY = 1000000 -- 3700000
WHERE EMP_ID = 202;
-- 선동일 사원의 급여를 700만원으로 변경하고, 보너스도 0.2로 변경
UPDATE EMP_SALARY
    SET SALARY = 7000000, --8000000 
        BONUS = 0.2 -- 0.3
WHERE EMP_ID = 200;
-- 전체사원의 급여를 기존의 급여의 10프로 인상한 금액
UPDATE EMP_SALARY
    SET SALARY = SALARY * 1.1;
    
-- UPADATE시 서브쿼리를 사용 가능
/*
    UPDATE 테이블명
        SET 컬럼명 = (서브쿼리)
    WHERE 조건;
*/
-- 방명수 사원의 급여와 보너스 값을 유재식 사원의 급여와 보너스 값으로 변경    
SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '방명수'; -- 214	방명수	D1	1518000	

-- 단일행 서브쿼리
UPDATE EMP_SALARY
    SET SALARY = (SELECT SALARY FROM EMP_SALARY 
                  WHERE EMP_NAME = '유재식'),
        BONUS = (SELECT BONUS FROM EMP_SALARY 
                  WHERE EMP_NAME = '유재식')
WHERE EMP_ID = 214;
    
-- 다중열 서브쿼리
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY 
                  WHERE EMP_NAME = '유재식')
WHERE EMP_ID = 214;

-- ASIA 지역에서 근무하는 사원들의 보너스값을 0.3으로 변경
-- ASIA 지역에서 근무하는 사원들 조회
SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
    SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                 FROM EMP_SALARY
                 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                 JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%');
                 
SELECT * FROM EMP_SALARY;

-- UPDATE시에도 해당 컬럼에 대한 제약조건에 위배되면 안됨
-- 사변이 200번인 사원의 이름을 NULL로 변경
UPDATE EMPLOYEE
    SET EMP_NAME = NULL
WHERE EMP_ID = 200;
----> NOT NULL 제약조건을 무시해서 오류 발생

-- 노홍철 사원의 직급코드를 J9으로 변경
SELECT * FROM JOB;
UPDATE EMPLOYEE
    SET JOB_CODE = 'J9'
WHERE EMP_ID = 203;
----> FK 제약조건이 무시되어 오류 발생

----------------------------------------------------------------------------------------------
/*
    4. DELETE
        테이블에 기록된 데이터를 삭제하는 구문 ( 한 행 단위로 삭제됨)
        
        표현식
        DELETE FROM 테이블명
        [WHERE 조건;] --> WHERE 절 제시 안하면 전체 행 다 삭제됨
    +) ROLLBACK 마지막 COMMIT했던 상태로 돌아감(COMMIT하면 ROLLBACK하면 바뀐상태로 롤백됨)
*/

-- 차은우 사원의 데이터 지우기
DELETE FROM EMPLOYEE
WHERE EMP_ID = 900;

DELETE FROM EMPLOYEE
WHERE EMP_ID = 901;

SELECT * FROM EMPLOYEE;

COMMIT;

-- DEPT_ID 가 D1부서를 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
----> 자식키가 자료를 사용하고있기때문에 외래키 제약조건 위반하여 오류
-- D1의 값을 가져다 쓰는 자식데이터가 있기 때문에 삭제 안됨.

-- DEPT_ID가 D3인 부서를 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;

-- TRUNCATE : 테이블의 전체 행을 삭제할 때 사용되는 구문
--               DELETE 보다 수행속도가 빠름
--               별도의 조건 제시 불가, ROLLBACK 불가
--  표현식 : TRUNCATE TABLE 테이블명;

SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;









































