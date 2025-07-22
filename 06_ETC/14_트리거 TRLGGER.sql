0/*
    < 트리거 TRLGGER >
    내가 지정한 테이블에 INSERT, UPDATE, DELETE 등 DML문에 의해 변경 사항이 생길 때
    (테이블에 이벤트가 발생했을 때)
    자동으로 매번 실행할 내용을 미리 정의해둘 수 있는 객체
    
    EX)
    회원 탈퇴시 기존의 회원테이블에 DELETE 후 곧바로 탈되된 회원들만 따로 보관하는 테이블에 자동으로 INSERT 처리
    신고 횟수가 일정 수를 넘겼을 때 묵시적으ㅗㄹ 해당 회원을 블랙리스트로 처리
    입출고에 대한 데이터가 기록(INSERT)될 때마다 해당 상품에 대한 재고수량을 매번 수정(UPDATE) 해야 될 때

    - 트리거 종류
    1) SQL문의 실행시기에 따른 분류
    -> BEFORE TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
    -> AFTER TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기 후에 트리거 실행
    2) SQL문에 의해 영향을 받는 각 행에 따른 분류
    -> STATEMENT TRIGGER(문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
    -> ROW TRIGGER(행 트리거) : 해당 sql문 실행 할 때마다 매번 트리거 실행
                              (FOR EACH ROW 옵션 기술)
                             : OLD - BEFORE UPDATE(수정전 자료), BEFORE DELETE(삭재전 자료)
                             : NEW - AFTER INSERT(추가된 자료), AFTER UPDATE (수정후 자료)

    - 트리거 생성 구문
    표현식
    CREATE [OR REPLACE] TRIGGER 트리거명 
    (BEFORE/AFTER) (INSERT/UPDQTE/DELETE) ON 테이블명
    (FOR EACH ROW)
    자동으로 실행할 내용;
     ㄴ DECLARE
         변수 선언
        BEGIN
         실행 내용(해당 위에 지정된 이벤트 발생시 묵시적으로(자동으로) 실행할 구문)
         [EXCEPION
            예외처리구문]
        END;
        /
*/
-- MEPLOYEE 테이블에 새로운 행이 INSERT될 때 마다 자동으로 메시지 출력하는 트리거 만들어보기
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다.');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500, '이순신', '111111-1111111', 'D7', 'J7', 'S2', SYSDATE);
---------------------------------------------------------------------------------
-- 상품 입고 및 출고 관련 예시

-- 테스트를 위한 테이블 및 시퀀스 생성
-- 1. 상품에 대한 데이터 보관할 테이블(TB_PRODECT)
CREATE TABLE TB_PRODECT(
    PCODE NUMBER PRIMARY KEY,       -- 상품번호
    PNAME VARCHAR2(30) NOT NULL,    -- 상품명
    BRAND VARCHAR2(30) NOT NULL,    -- 브랜드
    PRICE NUMBER,                   -- 가격
    STOCK NUMBER DEFAULT 0          -- 재고 수량
);

-- 상품번호 중복 안되게끔 매번 새로운 번호 발생시키는 시퀀스 (SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- 샘플 데이터 추가
INSERT INTO TB_PRODECT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시25', '삼성', 1400000, DEFAULT);
INSERT INTO TB_PRODECT VALUES(SEQ_PCODE.NEXTVAL, '아이폰16', '애플', 1600000, 10);
INSERT INTO TB_PRODECT VALUES(SEQ_PCODE.NEXTVAL, 'ㅁㄴㅇㄹ', 'ㅁㄴ', 600000, 20);

SELECT * FROM TB_PRODECT;

COMMIT;

-- 2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
-- 어떤 상품이 어떤 날짜에 몇개 입고 또는 출고가 되었는지에 대한 데이터를 기록하는 테이블
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                       -- 이력번호
    PCODE NUMBER REFERENCES TB_PRODECT,             -- 상품번호
    PDATE DATE NOT NULL,                            -- 상품입출고일
    AMOUNT NUMBER NOT NULL,                         -- 입출고수량
    STATUS CHAR(6) CHECK(STATUS IN ('입고','출고'))  -- 상태
);

-- 이력번호로 매번 새로운 번호 발생시켜서 들어갈 수 있게 도와주는 시퀀스 (SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200번 상품이 오늘 날짜로 10개 입고
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '입고');
-- 200번 상품의 재고수량을 10 증가
UPDATE TB_PRODECT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT; -- 해당 트렌젝션 커밋

-- 210번이 상품이 오늘 날짜로 5개 출고
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '출고');

UPDATE TB_PRODECT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205번 상품이 오늘날짜로 20개 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '입고');

UPDATE TB_PRODECT
SET STOCK = STOCK + 20
WHERE PCODE = 200; -- 실수로 오기입력

-- 해결방법
ROLLBACK;

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '입고');

UPDATE TB_PRODECT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- TB_PRODETAIL 테이블에 INSERT 이벤트 발생시
-- TB_PRODECT 테이블에 매번 자동으로 재고 수량 UPDATE 되게끔 트리거 설정

/*
    - 상품이 입고된 경우 = 해당 상품 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PRODECT
    SET STOCK = STOCK + 현재입고된 수량(INSERT된 자료의 AMOUNT값)
    WHERE PCODE = 입고된 상품번호(INSERT된 자료의 PCODE값을 보고);
*/

/*
    - 상품이 출고된 경우 = 해당 상품을 찾아서 재고수량을 감소해주는 UPDATE
    UPDATE TB_PRODECT
    SET STOCK = STOCK - 현재출고된 수량
    WHERE PCODE = 출고된 상품번호
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- 상품이 입고된 경우 => 재고수량 증가
    IF(:NEW.STATUS = '입고')
        THEN
            UPDATE TB_PRODECT
                SET STOCK = STOCK + :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
    
    -- 상품이 출고된 경우 => 재고수량 감소
    IF (:NEW.STATUS = '출고')
        THEN
            UPDATE TB_PRODECT
                SET STOCK = STOCK - :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210번 상품이 오늘날짜로 7개 출고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '출고');

-- 200번 상품이 오늘날짜로 100개 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '입고');
--------------------------- 실습문제 -----------------------------------
CREATE TABLE TB_SCODRE(
    S_NO NUMBER PRIMARY KEY,
    S_NAME VARCHAR2(30) NOT NULL,
    K NUMBER NOT NULL,
    E NUMBER NOT NULL,
    M NUMBER NOT NULL
);

CREATE TABLE TB_GRADE(
    S_NAME VARCHAR2(30) PRIMARY KEY,
    SM_POINT NUMBER NOT NULL,
    AG_POINT NUMBER NOT NULL,
    POINT NUMBER DEFAULT 1
);

SELECT * FROM TB_SCODRE;
INSERT INTO TB_SCODRE
VALUES(011, '박찬형', 80, 80, 80);

INSERT INTO TB_SCODRE
VALUES(022, '홍길동', 90, 90, 90);

INSERT INTO TB_SCODRE
VALUES(033, '이길동', 40, 40, 40);

UPDATE TB_SCODRE
SET K = K + 20
WHERE S_NAME = '박찬형';


SELECT * FROM TB_GRADE;

INSERT INTO TB_GRADE
VALUES('박찬형', 240, 80, 2);

INSERT INTO TB_GRADE
VALUES('홍길동', 270, 90, DEFAULT);

INSERT INTO TB_GRADE
VALUES('이길동', 120, 40, 3);

CREATE OR REPLACE TRIGGER TRG_GP
AFTER INSERT ON TB_SCODRE
FOR EACH ROW
BEGIN
INSERT INTO TB_GRADE(S_NAME, SM_POINT, AG_POINT)
VALUES(:NEW.S_NAME,
        :NEW.K + :NEW.E + :NEW.M,
        (:NEW.K + :NEW.E + :NEW.M) /3);
END;
/

CREATE OR REPLACE TRIGGER TRG_GP2
AFTER UPDATE ON TB_GRADE
FOR EACH ROW
BEGIN
END;
/

CREATE OR REPLACE PROCEDURE PROC_UPDATE_RANK IS
BEGIN
    UPDATE TB_GRADE G
        SET POINT = (SELECT 순위
                     FROM (SELECT S_NAME, RANK() OVER(ORDER BY SM_POINT DESC)
                           FROM TB_GRADE)
                           SUB
                           WHERE G.S_NAME = SUB.S_NAME);
END;
/

CREATE OR REPLACE TRIGGER TRG_GP3
AFTER INSERT OR UPDATE ON TB_SCODRE
BEGIN
    PROC_UPDATE_RANK;
END;
/

CREATE OR REPLACE TRIGGER TRG_GP4
AFTER DELETE ON TB_SCORE
FOR EACH ROW
BEGIN
    DELETE FROM TB_GRADE
    WHERE S_NO = :OLD.S_NO;
    
    PROC_UPDATE_RANK;
END;
/
-------------------------------------------------------------------------------

-- 1. 성적테이블(학번, 이름, 국, 영, 수), 학점테이블(학번, 총점수, 평균, 등수) 만들기
  -- 성적테이블 : TB_SCORE       /             학점테이블 : TB_GRADE
CREATE TABLE TB_SCORE 
    (STUDENT_NO NUMBER NOT NULL,
     STUDENT_NAME VARCHAR2(15) NOT NULL,
     KO_SCORE NUMBER,
     EN_SCORE NUMBER,
     MAT_SCORE NUMBER
    );
    
CREATE TABLE TB_GRAD
    (STUDENT_NO NUMBER,
     SUM_SCORE NUMBER,
     AVG_SCORE NUMBER, 
     RANK NUMBER
    );

-- 2. 성적테이블에 INSERT 발생하면 자동으로 학점테이블에 INSERT해주는 트리거 생성

/*
CREATE OR REPLACE TRIGGER TRG_SCORE
AFTER INSERT ON TB_SCORE
FOR EACH ROW
DECLARE 
    STU_NO TB_SCORE.STUDENT_NO%TYPE;
    SUM_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE);
    AVG_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE / 3);
            -- 만약, 과목의 컬럼이 추가되면 이 식은 망하지만, 일단... 머리아픙께..
    TOTAL_RANK NUMBER;
BEGIN
    INSERT INTO TB_GRADE VALUES (STU_NO, SUM_SCO, AVG_SCO, TOTAL_RANK);
END;
/
*/

CREATE OR REPLACE TRIGGER TRG_SCORE
AFTER INSERT ON TB_SCORE
FOR EACH ROW
BEGIN
    INSERT INTO TB_GRAD(STUDENT_NO, SUM_SCORE, AVG_SCORE)
    VALUES(:NEW.STUDENT_NO,
           :NEW.KO_SCORE + :NEW.EN_SCORE + :NEW.MAT_SCORE,
           (:NEW.KO_SCORE + :NEW.EN_SCORE + :NEW.MAT_SCORE)/3);
END;
/

INSERT INTO TB_SCORE VALUES(200, '김돌비', 70, 60, 60);
INSERT INTO TB_SCORE VALUES(201, '박궁예', 80, 90, 70);
INSERT INTO TB_SCORE VALUES(202, '이단군', 80, 80, 70);

-- 3. 성적테이블이 UPDATE되면 해당 국어, 영어, 수학 점수의 값이 
   -- 오라클 콘솔에 출력되는 트리거 생성
CREATE OR REPLACE TRIGGER TRG_GRADE
AFTER UPDATE ON TB_SCORE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('국어 : ' || :NEW.KO_SCORE);
    DBMS_OUTPUT.PUT_LINE('영어 : ' || :NEW.EN_SCORE);
    DBMS_OUTPUT.PUT_LINE('수학 : ' || :NEW.MAT_SCORE);
END;
/

-- 4. 성적테이블에 INSERT/ UPDATE 되면 등수를 매겨서 저장해주는 프로시저 생성
CREATE OR REPLACE PROCEDURE PROC_UPDATE_RANK IS
BEGIN
    UPDATE TB_GRAD G     --> 다중 서브쿼리식
    SET RANK = (SELECT RN  
                  FROM (SELECT STUDENT_NO, RANK()OVER(ORDER BY SUM_SCORE DESC) AS "RN"
                          FROM TB_GRAD) SUB
                 WHERE G.STUDENT_NO = SUB.STUDENT_NO
                );
END;
/
  
CREATE OR REPLACE TRIGGER TRG_TEST3
AFTER INSERT OR UPDATE ON TB_SCORE
BEGIN
    PROC_UPDATE_RANK;
END;
/
 
 -- 5. 점수 테이블에 학생 데이터가 삭제되면 학점 테이블에도 
  -- 학생 데이터 삭제 + 나머지 사람 등수 매기는 트리거 생성
CREATE OR REPLACE TRIGGER TRT_TEST4
AFTER DELETE ON TB_SCORE
FOR EACH ROW
BEGIN
    DELETE FROM TB_GRAD
     WHERE STUDENT_NO = :OLD.STUDENT_NO; 
     
    PROC_UPDATE_RANK;
END;
/