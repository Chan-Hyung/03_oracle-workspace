--�ǽ�����--

--�������� ���α׷��� ����� ���� ���̺��� �����

--�̶�, �������ǿ� �̸��� �ο��� ��

-- �� �÷��� �ּ��ޱ�

--1. ���ǻ�鿡 ���� �����͸� ��� ���� ���ǻ� ���̺�(TB_PUBLISHER)

--�÷�: PUB_NO(���ǻ��ȣ) --�⺻Ű(PUBLISHER_PK)

-- PUB_NAME(���ǻ��) --NOT NULL(PUBLICHSER_NN)

-- PHONE(���ǻ���ȭ��ȣ) --�������� ����

--3�� ������ ���� ������ �߰��ϱ�

CREATE TABLE TB_PUBLISHER(
  PUB_NO NUMBER PRIMARY KEY, --�⺻Ű(PUBLISHER_PK)
  PUB_NAME VARCHAR2(20) NOT NULL, --(PUBLICHSER_NN)
  PHONE VARCHAR2(20) --�������� ����
);
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS 'PUBLISHER_PK(���ǻ��ȣ)';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS 'PUBLICHSER_NN(���ǻ��)';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '��ȭ��ȣ';

SELECT *
FROM TB_PUBLISHER;

INSERT INTO TB_PUBLISHER
VALUES(1, 'KH����', '010-1111-2222');

INSERT INTO TB_PUBLISHER
VALUES(2, 'JS����', '010-3333-4444');


--2. �����鿡 ���� �����͸� ��� ���� ���� ���̺�(TB_BOOK)

--�÷�: BK_NO(������ȣ) --�⺻Ű(BOOK_PK)

-- BK_TITLE(������) --NOT NULL(BOOK_NN_TITLE)

-- BK_AUTHOR(���ڸ�) --NOT NULL(BOOK_NN_AUTHOR)

-- BK_PRICE(����)

-- BK_STOCK(���) --�⺻�� 1�� ����

-- BK_PUB_NO(���ǻ��ȣ) --�ܷ�Ű(BOOK_FK)(TB_PUBLISHER ���̺��� �����ϵ���)

-- �̶� �����ϰ� �ִ� �θ����� ���� �� �ڽĵ����͵� �����ǵ��� ����

--5�� ������ ���� ������ �߰��ϱ�

CREATE TABLE TB_BOOK(
    BK_NO NUMBER PRIMARY KEY,  --�⺻Ű(BOOK_PK)
    BK_TITLE VARCHAR2(100) NOT NULL, --(BOOK_NN_TITLE)
    BK_AUTHOR VARCHAR2(50) NOT NULL, --NOT NULL(BOOK_NN_AUTHOR)
    BK_PRICE NUMBER,                  -- ����
    BK_STOCK NUMBER DEFAULT 1,        --�⺻�� 1�� ����
    BK_PUB_NO NUMBER REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
    --�ܷ�Ű(BOOK_FK)
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '�⺻Ű(BOOK_PK)';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS 'BOOK_NN_TITLE(å����))';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS 'BOOK_NN_AUTHOR(����)';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '���(�⺻�� 1�� ����)';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '�ܷ�Ű(BOOK_FK)';

SELECT *
FROM TB_PUBLISHER;

DELETE FROM TB_PUBLISHER
WHERE PUB_NO = 2

SELECT *
FROM TB_BOOK

INSERT INTO TB_BOOK
VALUES(1, 'KH�ް��Ҽ�', 'Ŀ������', 3000, DEFAULT, 1 );

INSERT INTO TB_BOOK
VALUES(2, 'SJ�Ҽ�', 'SJ����', 2000, DEFAULT, 2 );

INSERT INTO TB_BOOK
VALUES(3, 'KH�׳ɼҼ�', 'DP����', 1000, 3, 1 );

INSERT INTO TB_BOOK
VALUES(4, '���üҼ�', 'AP����', 1500, 2, 1 );

INSERT INTO TB_BOOK
VALUES(5, 'SJ������', '������������', 4000, 5, 2 );



--3. ȸ���� ���� �����͸� ��� ���� ȸ�� ���̺�(TB_MEMBER)

--�÷���: MEMBER_NO(ȸ����ȣ) --�⺻Ű(MEMBER_PK)

-- MEMBER_ID(���̵�) --�ߺ�����(MEMBER_UQ)

--MEMBER_PWD(��й�ȣ) NOT NULL(MEMBER_NN_PWD)

--MEMBER_NAME(ȸ����) NOT NULL(MEMBER_NN_NAME)

--GENDER(����) 'M' �Ǵ� 'F'�� �Էµǵ��� ����(MEMBER_CK_GEN)

--ADDRESS(�ּ�)

--PHONE(����ó)

--STATUS(Ż�𿩺�) --�⺻������ 'N' �׸��� 'Y' Ȥ�� 'N'���� �Էµǵ��� ��������(MEMBER_CK_STA)

--ENROLL_DATE(������) --�⺻������ SYSDATE, NOT NULL ����(MEMBER_NN_EN)

--5�� ������ ���� ������ �߰��ϱ�

CREATE TABLE TB_MEMBER(
  MEMBER_NO    NUMBER PRIMARY KEY,  --(ȸ����ȣ) --�⺻Ű(MEMBER_PK)
  MEMBER_ID    VARCHAR2(30) UNIQUE, --(���̵�) --�ߺ�����(MEMBER_UQ)
  MEMBER_PWD   VARCHAR2(30) NOT NULL, --(MEMBER_NN_PWD)
  MEMBER_NAME  VARCHAR2(20)NOT NULL, --(MEMBER_NN_NAME)
  GENDER       CHAR(3) CHECK(GENDER IN ('M', 'F')), --'M' �Ǵ� 'F'�� �Էµǵ��� ����(MEMBER_CK_GEN)
  ADDRESS      VARCHAR2(200),                     --(�ּ�)
  PHONE        VARCHAR2(20),                        --(����ó)
  STATUS       CHAR(3) DEFAULT 'N',                  -- MEMBER_CK_STA)
  ENROLL_DATE  DATE DEFAULT SYSDATE  --(MEMBER_NN_EN)
);

SELECT *
FROM TB_MEMBER

INSERT INTO TB_MEMBER
VALUES(1,'user01','pwd01','������','M', '������ kh ����������', '010-5555-6666',default, '25/07/15');

INSERT INTO TB_MEMBER
VALUES(2,'user02','pwd02','�����','F', '������ sj ', '010-7777-8888','Y', default);

INSERT INTO TB_MEMBER
VALUES(3,'user03','pwd03','������','M', '���ı� ������', '010-8888-1212','N', '25/07/15');

INSERT INTO TB_MEMBER
VALUES(4,'user04','pwd04','��ȫö','M', '��⵵  ������', '010-3434-6543',default, default);

INSERT INTO TB_MEMBER
VALUES(5,'user05','pwd05','������','F', '������ �б�����', '010-4545-3433','Y', '23/03/10');



--4. ������ �뿩�� ȸ���� ���� �����͸� ��� ���� �뿩��� ���̺�(TB_RENT)

--�÷�:

--RENT_NO(�뿩��ȣ) --�⺻Ű(RENT_PK)

--RENT_MEM_NO(�뿩ȸ����ȣ) --�ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���

--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼ� ����

--RENT_BOOK_NO(�뿩������ȣ) --�ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���

--�̶� �θ����� ���� �� NULL���� �ǵ��� �ɼǼ���

--RENT_DATE(�뿩��) --�⺻�� SYSDATE

--���õ����� 3������ �߰��ϱ�

CREATE TABLE TB_RENT(
    RENT_NO NUMBER PRIMARY KEY,    --(�뿩��ȣ) --�⺻Ű(RENT_PK)
    RENT_MEM_NO VARCHAR(30) REFERENCES TB_MEMBER(MEMBER_ID) ON DELETE SET NULL, --(�뿩ȸ����ȣ) --�ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
    RENT_BOOK_NO NUMBER REFERENCES TB_BOOK(BK_NO) ON DELETE CASCADE, --�ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
    RENT_DATE DATE DEFAULT SYSDATE 
);

SELECT * FROM TB_RENT;

INSERT INTO TB_RENT
VALUES(1,'user01', 1 , DEFAULT);

INSERT INTO TB_RENT
VALUES(2,'user02', 2 , '23/03/10');



SELECT MEMBER_NAME AS "�̸�", MEMBER_ID AS "���̵�", RENT_DATE AS "�뿩��", RENT_DATE+7 AS "�ݳ�������"
FROM(SELECT *
        FROM TB_BOOK B, TB_PUBLISHER P, TB_MEMBER M, TB_RENT R
        WHERE B.BK_PUB_NO = P.PUB_NO
        AND B.BK_NO = R.RENT_BOOK_NO 
        AND M.MEMBER_ID = R.RENT_MEM_NO)
WHERE RENT_BOOK_NO = 2
  