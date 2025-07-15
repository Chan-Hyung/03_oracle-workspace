/*
    - DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), ������ �����ϰ�(ALTER), ������ �����ϴ�(DROP) ���
    ��, ���������Ͱ� ���� �ƴ� ���� ��ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� ���
    
    ����Ŭ���� �����ϴ� ��ü(OBJECT) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER), ���ν���(PROCEDURE), �Լ�(FUNCTION), �����(USER)
    
    <CREATE>
    ��ü�� ������ �����ϴ� ����
    
*/
/*
    1. ���̺� ����
    - ���̺��̶�? ��(ROW)�� ��(COLUMN(�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                ��� �����͵��� ���̺��� ���ؼ� ������.
                (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��)
                
    (ǥ����)
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ...
    );
    
    * �ڷ���
    - ����(CHAR(����Ʈũ��)) | VARCHAR2(����Ʈũ��) => �ݵ�� ũ�� ����
    > CHAR : �ִ� 2000����Ʈ ���� ����. ������ ���� �ȿ����� ����� / �������� (������ ũ�⺸�� �� �������� ���͵� �������� ä�������)
            ������ ���ڼ��� �����͸��� ��� ��� ���
            
    > VARCHAR2 : �ִ� 4000����Ʈ���� ���� ����, ��������( ��� ���� ���� ������ ũ�� ������/ ��, ũ�Ⱑ ������ ������ ũ�� ������)
                ������� �����Ͱ� ������ �� ��� ���
                
    - ���� (NUMBER)
    
    - ��¥ (DATE)
    
*/

--------> ȸ���� ���� �����͸� ��� ���� ���̺� MEBER����
CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,        -- ȸ����ȣ, �⺻Ű
    MEM_ID VARCHAR2(20) NOT NULL,     -- ���̵�
    MEM_PWD VARCHAR2(20) NOT NULL,    -- ��й�ȣ
    MEM_NAME VARCHAR2(20) NOT NULL,   -- �̸�
    GENDER CHAR(1),                   -- ���� (M/F)
    PHONE VARCHAR2(13),               -- ��ȭ��ȣ
    EMAIL VARCHAR2(50),               -- �̸���
    MEM_DATE DATE DEFAULT SYSDATE     -- ������, �⺻�� ����
);

-- ���� �÷��� ��Ÿ�� �߻��ߴٸ�? �ٽø���� �ȵǰ� �����ϰ� �ٽ� ��������

---------------------------------------------------------------------------------
/*
    2. �÷��� �ּ� �ޱ�(�÷��� ���� ���� ������)
    
    (ǥ����)
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/

--COMMENT ON COLUMN MEMBER.MEM_NO IS '��������'; ��Ÿ���� �׳� �ٽ� �ۼ��Ͽ� ��ĥ �� ����
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';

COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';
--------------------------------------------------------------------------------------------
-- ���̺� �����͸� �߰� ��Ű�� ����(DML : INSERT) �̶� �ڼ����ϰ� ���
-- INSERT INTO ���̺�� VALUES(��1, ��2, ...);
SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '������', '1', '010-1111-2222', 'ASDF@NAVER.COM', '24/12/24');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '�����', '2', null, null, SYSDATE);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- ��ȿ���� ���� �����Ͱ� ���� ����.. ���� ������ �ɾ������.

-----------------------------------------------------------------------------------------------------------------------
/*
    <�������� CONSTRAINT>
    - ���ϴ� ������ ���� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����Ұ�
    - ������ ���Ἲ ������ �������� �Ѵ�.
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/
/*
    * NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� (��, �ش� �÷��� ����NULL)�� ���ͼ��� �ȵ�
    ���� / ������ NULL ���� ������� �ʵ��� ����
    
    ���� ������ �ο��ϴ� ����� ũ�� 2���� ����� ����(�÷��������/���̺������)
    * NOT  NULL ���������� ������ �÷� ���� ��� �ۿ� �ȵ�.
*/

-- �÷�������� : �÷��� �ڷ��� ��������

CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER NOT NULL,        -- ȸ����ȣ, �⺻Ű
    MEM_ID VARCHAR2(20) NOT NULL,     -- ���̵�
    MEM_PWD VARCHAR2(20) NOT NULL,    -- ��й�ȣ
    MEM_NAME VARCHAR2(20) NOT NULL,   -- �̸�
    GENDER CHAR(3),                   -- ���� (M/F)
    PHONE VARCHAR2(13),               -- ��ȭ��ȣ
    EMAIL VARCHAR2(50),               -- �̸���
    MEM_DATE DATE DEFAULT SYSDATE     -- ������, �⺻�� ����
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01' , '������', '��', '010-1111-2222', 'asdf@naver.com', sysdate );
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', null , '�ں���', '��', null, 'qwer@naver.com', null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- �ǵ� �ߴ� ��� ����(not null �������ǿ� ����Ǿ� ���� �߻�)
INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass02' , '������', '��', null, null, null );
-- ���̵� �ߺ��Ǿ��������� �ұ��ϰ� �� �߰� ��;
----------------------------------------------------------------------------------------------------------------------
/*
    *UNIQUE ���� ����
    �ش� �÷��� �ߺ��� ���� ������ �� �� ���
    �÷����� �ߺ����� �����ϴ� ��������
    ���� / ������ ������ �ִ� �����Ͱ� �� �ߺ����� 
*/

CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,    
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷� ���� ���  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3),                
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50)              
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- ���̺��� ��� : ��� �÷��� �� ���� �� �� �������� ����ϴ� ���
--                 ���� ����(�÷���)

CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,    
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3),                
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- ���̺� ���� ���
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '������', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '�ں���', null, null, null);
-- ORA-00001: unique constraint (DDL.SYS_C007056) violated
-- unique �������ǿ� ����Ǿ� �����߻�
-- > ���� ������ �������Ǹ����� �˷���(Ư�� �÷��� � ������ �մ��� ���� �˷����� ����)
-- > ���� �ľ��ϱ� �����
-- > �������� �ο��� �������Ǹ��� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο��� ����.

/*
    * �������� �ο��� �������Ǹ���� �����ִ� ���
    
    1. �÷����� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�],
        �÷��� �ڷ���
    );
    
    2. ���̺��� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,       
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,   
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,  
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,  
    GENDER CHAR(3),                   
    PHONE VARCHAR2(13),               
    EMAIL VARCHAR2(50),               
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01' , '������', NULL, NULL, NULL );
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02' , '�ں���', NULL, NULL, NULL);
INSERT INTO MEM_NOTNULL VALUES(3, 'user03', 'pass03' , '�����', '��', NULL, NULL);
-- ������ ��ȿ�� ���� �ƴѰ� ���͵� �� insert ��
----------------------------------------------------------------------------------------------
/*
    CHECK ���� ����
    �ش� �÷��� ���� �� �մ� ���� ���� ������ ����
    �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
*/

CREATE TABLE MEM_CHECK (
    MEM_NO NUMBER NOT NULL,    
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),    -- �÷��������
--  CHECK(GENDER IN ('��','��')) -- ���̺������
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50)              
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '������', '��', null, null);

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '�ں���', '��', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007061) violated
-- check �������ǿ� ����Ʊ� ������ ���� �߻�

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '�ں���', null, null, null);
-- ����, �����÷��� ������ ���� �ְ��� �Ѵٸ� check �������ǿ� �����ϴ� ���� �־��������,
-- not null �ƴϸ� null�� �����ϱ��ϴ�.

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '�����', null, null, null);
-- ȸ����ȣ�� �����ص� ������ �߻������� ����

------------------------------------------------------------------------------------------
/*
    * PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� ��������(�ĺ����� ����)
    
    EX) ȸ����ȣ, �й�, �����ȣ, �μ��ڵ�, �����ڵ�, �ֹ���ȣ
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE ���������� ����
    ��, �����̺�� �Ѱ��� ���� ����
*/
CREATE TABLE MEM_PRI (
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- �÷� ���� ���   
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),   
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50)              
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺� ���� ���
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '������', '��', '010-1111-2222', null);

INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', '�ں���', '��', null, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- �⺻Ű�� �ߺ����� �������� �� �� unique �������ǿ� ����

INSERT INTO MEM_PRI
VALUES(null, 'user02', 'pass02', '�ں���', '��', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- �⺻Ű�� null�� �������� �Ҷ� (not null �������ǿ� ����)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', '�ں���', '��', null, null);

CREATE TABLE MEM_PRI2 (
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),   
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50)
);

-- ORA-02260: table can have only one primary key
-- �⺻Ű�� �ϳ��� ��.

CREATE TABLE MEM_PRI2 (
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2(20) ,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),   
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50),
    primary key(MEM_NO, MEM_ID) -- ��� PRIMARY KEY �������� �ο�(����Ű)
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '������', null, null, null);

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass02', '�ں���', null, null, null);

INSERT INTO MEM_PRI2
VALUES(2, 'user02', 'pass02', '�����', null, null, null);

INSERT INTO MEM_PRI2
VALUES(null, 'user02', 'pass02', '������', null, null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY�� �����ִ� �� �÷����� ���� NULL�� ������� ����

-- ����Ű ��� ����(���ϱ�, ���ƿ�, ����)
-- ���ϱ� : �ѻ�ǰ�� ������ �ѹ��� ���� �� ����
-- � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(40),
    LIKEDATE DATE,
    PRIMARY KEY( MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;
INSERT INTO TB_TABLE VALUES(1,'�鵵 ������ ', SYSDATE);
INSERT INTO TB_TABLE VALUES(1,'�鵵 ������ ', SYSDATE);
INSERT INTO TB_TABLE VALUES(2,'�鵵 ������ ', SYSDATE);

--------------------------------------------------------------------
-- ȸ�� ��޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY,    
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),   
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER --�п� ��޹�ȣ ���� ������ �÷�
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '������', '��', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02=', '�ں���', '��', null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03=' , '�����', '��', null, null, 30);
----------------------------------------------------------------------
/*
  * FOREIGN KEY(�ܷ�Ű) ���� ����
  - �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷��� �ο��ϴ� ��������
  - �ٸ� ���̺� �����Ѵٴ� ǥ��
  - �ַ� FK �������ǿ� ���� ���̺��� ���谡 ����
  
  1.�÷��������
  �÷��� �ڷ��� CONSTRAINT �������Ǹ� REFERNECES ������ ���̺��(������ �÷���)
  
  2. ���̺������
  CONSTRAINT �������Ǹ� FOREIGN KEY(�÷���) REFERENCES ������ ���̸�(������ �÷���)
  
  --> ������ �÷��� ������ ������ ���̺��� PK�� �ڵ� ����
  
*/
CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY,    
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),   
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) -- �÷� ���� ��� : �����÷��� �����ϸ� PK�� �ڵ� ����
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) -- ���̺� ���� ���
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '������', '��', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02=', '�ں���', '��', null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03=' , '�����', '��', null, null, 90); -- 30�̸鰡��
-- ORA-00001: unique constraint (DDL.SYS_C007080) violated
-- PARENT KEY�� ã�� �� ���ٴ� ���� �߻�
-- MEM_GRADE(�θ����̺�) ------------ MEM(�ڽ����̺�)

-- �̶� �θ����̺��� �����Ͱ��� ������ ���
-- ������ ���� : DELETE FROM ���̺�� WHERE ����;

-- MEM_GRADE ���̺� 10�� ��� ����;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> �ڽ����̺�(MEM)�� 10�̶�� ���� ����ϱ� ������ ����X

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 20;
--> �ڽ� ���̺�(MEM)�� 20�̶�� ���� ����ϰ� ���� �ʱ� ������ ���� O

--> �ڽ����̺� �̹� ����ϰ� �ִ� ���� ���� �ܿ�
--> �θ����̺�� ���� ������ ������ �ȵǰ� �ϴ� "��������" �ɼ��� �ɷ� ����

SELECT * FROM MEM_GRADE;

ROLLBACK;

-------------------------------------------------------------------------------
/*
    �ڽ� ���̺� ������ �ܷ�Ű �������� �ο��� �� ���� �ɼ� ���� ����
    * ���� �ɼ� : �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� ó�� ���
    
    1. ON DELETE RESTRICTED(�⺻��) : ���� ���� �ɼ�, �ڽĵ����ͷ� ���̴� �θ����ʹ� ���� X
    2. ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ���� �ִ� �ڽĵ������� ���� NULL�� ����
    3. ON DELETE CASCADE : �θ����� ������ �ش� �����͸� ���� �ִ� �ڽĵ����͵� ���� ����
*/

DROP TABLE MEM;

-- ON DELETE SET NULL

CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY,    
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),   
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '������', '��', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�ں���', '��', null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '�����', '��', null, null, 20);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '�ں���', '��', null, null, 10);

-- 10�� ��� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- 10�� ������ ���� �ִ� �ڽĵ����� ���� NULL�� ����

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

ROLLBACK;

DROP TABLE MEM;

-- ON DELETE CASCADE

CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY,    
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,  
    MEM_PWD VARCHAR2(20) NOT NULL,   
    MEM_NAME VARCHAR2(20) NOT NULL, 
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),   
    PHONE VARCHAR2(13),              
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '������', '��', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�ں���', '��', null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '�����', '��', null, null, 20);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '�ں���', '��', null, null, 10);

-- 10��� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

----------------------------------------------------------------
/*
    <DEFAULT �⺻��>
    �ķ��� �������� �ʰ� INSERT�� NULL�� �ƴ� �⺻������ INSERT�ϰ��� �� �� �����ص� �� �ִ� ��
*/

DROP TABLE MEMBER;
-- �÷��� �ڷ��� DEFAULT �⺻��(��������)
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(1, '������', 20, '�뷡�ϱ�', '25/01/01');
INSERT INTO MEMBER VALUES(2, '�ں���', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(2, '�ں���', NULL, DEFAULT, DEFAULT);

-- INSERT INTO ���̺��(�÷���, �÷���) VALUES(��1, ��2);
-- NOT NULL�ΰ� �� ������.
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4, '������');
-- ���õ��� ���� �÷����� �⺻������ NULL�� ���
--��, �ش� �÷��� DEFAULT ���� ���� ��� NULL�� �ƴ� DEFAULT ���� ��
-------------------------------------------------------------------------------------------
/*
    ======================== KH ���� ========================================
    <SUBQUERY�� �̿��� ���̺� ����>
    ���̺� 
    
    (ǥ����)
    CREATE TABLE ���̺��
    AS ��������;
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
    FROM EMPLOYEE;
-- �÷�, �����Ͱ�, �������� ���� ��쿡�� NOT NULL�� �����

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
    FROM EMPLOYEE -- ���̺��� ������ ����������
    WHERE 1 = 0; -- ������ FALSE�� ���� : �������� �����ϰ��� �� �� ���̴� ����(������ ���� �ʿ������)
    
SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "����"
FROM EMPLOYEE;
-- ORA-00998: must name this expression with a column alias
-- ALIAS : ��Ī
----> �������� SELECT ���� �����, �Լ� ������ ����� ��� �ݵ�� ��Ī ����

SELECT EMP_NAME, ���� FROM EMPLOYEE_COPY3;

--------------------------------------------------------------------------
/*
    ���̺� �� ������ �Ŀ� �ڴʰ� �������� �߰�
    
    ALTER TABLE ���̺�� ������ ����;
    
    1) PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    2) FOREIGN KEY :  ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��(������ �÷���)
    3) UNIQUE :  ALTER TABLE ���̺�� ADD ���̺�� ADD UNIQUE(�÷���) : 
    4) CHECK :  ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�)
    5) NOT NULL : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
*/

-- ���������� �̿��ؼ� ������ ���̺��� NN �������� ���� �����ȵ�
-- EMPLOYEE_COPY ���̺� PK�������� �߰�(EMP_ID)

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE ���̺� DEPT_CODE�� �ܷ�Ű �������� �߰� (�������̺�(�θ�) : DEPARTMENT(DEPT_ID))
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; -- �����ϸ� �θ����̺��� PK�� ��

-- EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű �������� �߰�(JOB ���̺� ����)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
-- EMPLOYEE ���̺� SAL_LEVEL�� �ܷ�Ű ��������(SAL_GRADE ���̺� ����)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE; 
-- DEPARTMENT ���̺� LOCATION_ID�� �ܷ�Ű ��������(LOCATION ���̺� ����)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION; --REFERENCES �����ϰ� �ϰڴ�.







