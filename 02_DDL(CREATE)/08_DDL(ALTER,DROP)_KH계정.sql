/*
    DDL(DATE DEFINITION LANGUAGE) : 데이터 정의 언어
    
    객체들을 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 구문
    
    < ALTER >
    객체를 변경하는 구문
    
    표현식
    ALTER TABLE 테이블명 변경할내용;
    
    -변경할 내용
    1. 컬럼 추가/수정/삭제
    2. 제약조건 추가/삭제 ---> 수정은 불가하여 삭제하여 다시 만들어야함.
    3. 컬럼명/제약조건명/테이블명 변경
*/

-- 1. 컬럼 추가/수정/삭제
-- 1-1 컬럼 추가(ADD) : ADD 컬럼명 자료형 [DEFAULT] [제약조건]
-- DEPT_COPY에 CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

SELECT * FROM DEPT_COPY;

-- LNAME 컬럼 추가 (기본값을 지정한채로)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';

-- 1-2 컬럼 수정(MODIFY)
----> 자료형 수정      : MODIFY 컬럼명 바꾸고자하는 자료형
----> DEFAULT 값 수정  : MODIFY 컬럼명 DEFAULT 바꾸고자하는 기본값

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MOKIFY DEPT_ID NUMBER;
--> NUMBER는 오류가 남
-- 단, DEPT_ID에 값이 없을 때는 바꾸는 가능하다

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
--> VARCHAR2(10)보다 큰 값이 있기 때문에 오류발생

-- DEPT_COPY에서 변경
-- DEPT_TITLE 컬럼을 VARCHAR2(50)으로
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);
-- LOCATION_ID 컬럼을 VARCHAR2(4)으로
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);
-- LNAME 컬럼의 기본값을 '미국'으로 변경
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';
----> 디폴트 값을 바꾼다고 해서 이전에 추가된 데이터가 바뀌는 것은 X
SELECT * FROM DEPT_COPY;

-- 다중 변경 가능
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(50)
    MODIFY LOCATION_ID VARCHAR2(4)
    MODIFY LNAME DEFAULT '미국';

-- 1-3 컬럼삭제(DROP COLUMN) : DROP COLUMN 삭제하고자 하는 컬럼명
-- 복사본 테이블 생성
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2 로부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
--  컬럼 삭제하는건 다중 ALTER불가

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- 테이블안에 모든 컬럼을 삭제할 수 없어서 최소한 1개의 컬럼은 존재해야함

-------------------------------------------------------------------------------------------
-- 2. 제약조건 추가 / 삭제
/*
    2-1 제약조건 추가
    PRIMARY KEY : ADD PRIMARY KEY(컬럼명)
    FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블(컬러명)
    UNIQUE : ADD UNIQUE(컬럼명)
    CHECK : ADD CHECK(컬럼에 대한 조건)
    NOT NULL : MODIFY 컬럼명 NOT NULL / NULL

    제약조건명을 지정하고자 한다면 [CONSTRAINT 제약조건명] 제약조건
*/
-- DEPT_ID에 PK 제약조건 추가
-- DEPT_TITLE에 UNIQUE 제약조건 추가
-- LNAME에 NN(NOT NULL) 제약조건 추가
ALTER TABLE DEPT_COPY
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;
    
-- 2-2 제약조건 삭제 : DROP CONSTRANINT 제약조건명
-- NN은 삭제 말고 MODIFY로 쓰면 됨

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;

---------------------------------------------------------------------------------
-- 3. 컬럼명/제약조건명/테이블명 변경(RENAME)
-- 3-1 컬럼명 변경 : RENAME COLUMN 기존컬러명 TO 바꿀컬러명;

-- DEPT_TITLE => DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY;

-- 3-2 제약조건명 변경 : RENAME CONSTRAINT 제약조건명 TO 바꿀제약조건명
-- SYS_C007186
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007186 TO DCOPY_LID_NN;

-- 3-3 테이블명 변경 : RENAME [기존테이블] TO 바꿀테이블명
-- DEPT_COPY => DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

-----------------------------------------------------------------------------------
-- 테이블 삭제
DROP TABLE DEPT_TEST;

-- 단, 어딘가에 참조되고 있는 부모테이블은 함부로 삭제 안됨
-- 만약에 삭제하고자 한다면
-- 방법1. 자식테이블 먼저 삭제 후 부모테이블 삭제하는 방법
-- 방법2. 그냥 부모테이블만 삭제 하는데 제약조건까지 같이 삭제하는 방법
--         DROP TABLE 테이블명 CASCADE CONSTRAINT;


