--실습문제--

--도서관리 프로그램을 만들기 위한 테이블을 만들기

--이때, 제약조건에 이름을 부여할 것

-- 각 컬럼에 주석달기

--1. 출판사들에 대한 데이터를 담기 위한 출판사 테이블(TB_PUBLISHER)

--컬럼: PUB_NO(출판사번호) --기본키(PUBLISHER_PK)

-- PUB_NAME(출판사명) --NOT NULL(PUBLICHSER_NN)

-- PHONE(출판사전화번호) --제약조건 없음

--3개 정도의 샘플 데이터 추가하기

CREATE TABLE TB_PUBLISHER(
  PUB_NO NUMBER PRIMARY KEY, --기본키(PUBLISHER_PK)
  PUB_NAME VARCHAR2(20) NOT NULL, --(PUBLICHSER_NN)
  PHONE VARCHAR2(20) --제약조건 없음
);
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS 'PUBLISHER_PK(출판사번호)';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS 'PUBLICHSER_NN(출판사명)';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '전화번호';

SELECT *
FROM TB_PUBLISHER;

INSERT INTO TB_PUBLISHER
VALUES(1, 'KH출판', '010-1111-2222');

INSERT INTO TB_PUBLISHER
VALUES(2, 'JS출판', '010-3333-4444');


--2. 도서들에 대한 데이터를 담기 위한 도서 테이블(TB_BOOK)

--컬럼: BK_NO(도서번호) --기본키(BOOK_PK)

-- BK_TITLE(도서명) --NOT NULL(BOOK_NN_TITLE)

-- BK_AUTHOR(저자명) --NOT NULL(BOOK_NN_AUTHOR)

-- BK_PRICE(가격)

-- BK_STOCK(재고) --기본값 1로 지정

-- BK_PUB_NO(출판사번호) --외래키(BOOK_FK)(TB_PUBLISHER 테이블을 참조하도록)

-- 이때 참조하고 있는 부모데이터 삭제 시 자식데이터도 삭제되도록 설정

--5개 정도의 샘플 데이터 추가하기

CREATE TABLE TB_BOOK(
    BK_NO NUMBER PRIMARY KEY,  --기본키(BOOK_PK)
    BK_TITLE VARCHAR2(100) NOT NULL, --(BOOK_NN_TITLE)
    BK_AUTHOR VARCHAR2(50) NOT NULL, --NOT NULL(BOOK_NN_AUTHOR)
    BK_PRICE NUMBER,                  -- 가격
    BK_STOCK NUMBER DEFAULT 1,        --기본값 1로 지정
    BK_PUB_NO NUMBER REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
    --외래키(BOOK_FK)
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '기본키(BOOK_PK)';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS 'BOOK_NN_TITLE(책제목))';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS 'BOOK_NN_AUTHOR(저자)';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '재고(기본값 1로 지정)';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '외래키(BOOK_FK)';

SELECT *
FROM TB_PUBLISHER;

DELETE FROM TB_PUBLISHER
WHERE PUB_NO = 2

SELECT *
FROM TB_BOOK

INSERT INTO TB_BOOK
VALUES(1, 'KH메가소설', '커피저자', 3000, DEFAULT, 1 );

INSERT INTO TB_BOOK
VALUES(2, 'SJ소설', 'SJ저자', 2000, DEFAULT, 2 );

INSERT INTO TB_BOOK
VALUES(3, 'KH그냥소설', 'DP저자', 1000, 3, 1 );

INSERT INTO TB_BOOK
VALUES(4, '애플소설', 'AP저자', 1500, 2, 1 );

INSERT INTO TB_BOOK
VALUES(5, 'SJ디비기초', '빌게이츠저자', 4000, 5, 2 );



--3. 회원에 대한 데이터를 담기 위한 회원 테이블(TB_MEMBER)

--컬럼명: MEMBER_NO(회원번호) --기본키(MEMBER_PK)

-- MEMBER_ID(아이디) --중복금지(MEMBER_UQ)

--MEMBER_PWD(비밀번호) NOT NULL(MEMBER_NN_PWD)

--MEMBER_NAME(회원명) NOT NULL(MEMBER_NN_NAME)

--GENDER(성별) 'M' 또는 'F'로 입력되도록 제한(MEMBER_CK_GEN)

--ADDRESS(주소)

--PHONE(연락처)

--STATUS(탈퇴여부) --기본값으로 'N' 그리고 'Y' 혹은 'N'으로 입력되도록 제약조건(MEMBER_CK_STA)

--ENROLL_DATE(가입일) --기본값으로 SYSDATE, NOT NULL 조건(MEMBER_NN_EN)

--5개 정도의 샘플 데이터 추가하기

CREATE TABLE TB_MEMBER(
  MEMBER_NO    NUMBER PRIMARY KEY,  --(회원번호) --기본키(MEMBER_PK)
  MEMBER_ID    VARCHAR2(30) UNIQUE, --(아이디) --중복금지(MEMBER_UQ)
  MEMBER_PWD   VARCHAR2(30) NOT NULL, --(MEMBER_NN_PWD)
  MEMBER_NAME  VARCHAR2(20)NOT NULL, --(MEMBER_NN_NAME)
  GENDER       CHAR(3) CHECK(GENDER IN ('M', 'F')), --'M' 또는 'F'로 입력되도록 제한(MEMBER_CK_GEN)
  ADDRESS      VARCHAR2(200),                     --(주소)
  PHONE        VARCHAR2(20),                        --(연락처)
  STATUS       CHAR(3) DEFAULT 'N',                  -- MEMBER_CK_STA)
  ENROLL_DATE  DATE DEFAULT SYSDATE  --(MEMBER_NN_EN)
);

SELECT *
FROM TB_MEMBER

INSERT INTO TB_MEMBER
VALUES(1,'user01','pwd01','차은우','M', '강남구 kh 정보교육원', '010-5555-6666',default, '25/07/15');

INSERT INTO TB_MEMBER
VALUES(2,'user02','pwd02','장원영','F', '강남구 sj ', '010-7777-8888','Y', default);

INSERT INTO TB_MEMBER
VALUES(3,'user03','pwd03','김현우','M', '송파구 교육원', '010-8888-1212','N', '25/07/15');

INSERT INTO TB_MEMBER
VALUES(4,'user04','pwd04','나홍철','M', '경기도  군포시', '010-3434-6543',default, default);

INSERT INTO TB_MEMBER
VALUES(5,'user05','pwd05','전지현','F', '강남구 압구정동', '010-4545-3433','Y', '23/03/10');



--4. 도서를 대여한 회원에 대한 데이터를 담기 위한 대여목록 테이블(TB_RENT)

--컬럼:

--RENT_NO(대여번호) --기본키(RENT_PK)

--RENT_MEM_NO(대여회원번호) --외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록

--이때 부모데이터 삭제 시 NULL값이 되도록 옵션 설정

--RENT_BOOK_NO(대여도서번호) --외래키(RENT_FK_BOOK) TB_BOOK와 참조하도록

--이때 부모데이터 삭제 시 NULL값이 되도록 옵션설정

--RENT_DATE(대여일) --기본값 SYSDATE

--샘플데이터 3개정도 추가하기

CREATE TABLE TB_RENT(
    RENT_NO NUMBER PRIMARY KEY,    --(대여번호) --기본키(RENT_PK)
    RENT_MEM_NO VARCHAR(30) REFERENCES TB_MEMBER(MEMBER_ID) ON DELETE SET NULL, --(대여회원번호) --외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
    RENT_BOOK_NO NUMBER REFERENCES TB_BOOK(BK_NO) ON DELETE CASCADE, --외래키(RENT_FK_MEM) TB_MEMBER와 참조하도록
    RENT_DATE DATE DEFAULT SYSDATE 
);

SELECT * FROM TB_RENT;

INSERT INTO TB_RENT
VALUES(1,'user01', 1 , DEFAULT);

INSERT INTO TB_RENT
VALUES(2,'user02', 2 , '23/03/10');



SELECT MEMBER_NAME AS "이름", MEMBER_ID AS "아이디", RENT_DATE AS "대여일", RENT_DATE+7 AS "반납예정일"
FROM(SELECT *
        FROM TB_BOOK B, TB_PUBLISHER P, TB_MEMBER M, TB_RENT R
        WHERE B.BK_PUB_NO = P.PUB_NO
        AND B.BK_NO = R.RENT_BOOK_NO 
        AND M.MEMBER_ID = R.RENT_MEM_NO)
WHERE RENT_BOOK_NO = 2
  