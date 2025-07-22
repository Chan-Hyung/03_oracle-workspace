0/*
    < Ʈ���� TRLGGER >
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ���� ������ ���� ��
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü
    
    EX)
    ȸ�� Ż��� ������ ȸ�����̺� DELETE �� ��ٷ� Ż�ǵ� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó��
    �Ű� Ƚ���� ���� ���� �Ѱ��� �� ���������Ǥ� �ش� ȸ���� ������Ʈ�� ó��
    ����� ���� �����Ͱ� ���(INSERT)�� ������ �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE) �ؾ� �� ��

    - Ʈ���� ����
    1) SQL���� ����ñ⿡ ���� �з�
    -> BEFORE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
    -> AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� �Ŀ� Ʈ���� ����
    2) SQL���� ���� ������ �޴� �� �࿡ ���� �з�
    -> STATEMENT TRIGGER(����Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
    -> ROW TRIGGER(�� Ʈ����) : �ش� sql�� ���� �� ������ �Ź� Ʈ���� ����
                              (FOR EACH ROW �ɼ� ���)
                             : OLD - BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(������ �ڷ�)
                             : NEW - AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE (������ �ڷ�)

    - Ʈ���� ���� ����
    ǥ����
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ� 
    (BEFORE/AFTER) (INSERT/UPDQTE/DELETE) ON ���̺��
    (FOR EACH ROW)
    �ڵ����� ������ ����;
     �� DECLARE
         ���� ����
        BEGIN
         ���� ����(�ش� ���� ������ �̺�Ʈ �߻��� ����������(�ڵ�����) ������ ����)
         [EXCEPION
            ����ó������]
        END;
        /
*/
-- MEPLOYEE ���̺� ���ο� ���� INSERT�� �� ���� �ڵ����� �޽��� ����ϴ� Ʈ���� ������
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.');
END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500, '�̼���', '111111-1111111', 'D7', 'J7', 'S2', SYSDATE);
---------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� ����

-- �׽�Ʈ�� ���� ���̺� �� ������ ����
-- 1. ��ǰ�� ���� ������ ������ ���̺�(TB_PRODECT)
CREATE TABLE TB_PRODECT(
    PCODE NUMBER PRIMARY KEY,       -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,    -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,    -- �귣��
    PRICE NUMBER,                   -- ����
    STOCK NUMBER DEFAULT 0          -- ��� ����
);

-- ��ǰ��ȣ �ߺ� �ȵǰԲ� �Ź� ���ο� ��ȣ �߻���Ű�� ������ (SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- ���� ������ �߰�
INSERT INTO TB_PRODECT VALUES(SEQ_PCODE.NEXTVAL, '������25', '�Ｚ', 1400000, DEFAULT);
INSERT INTO TB_PRODECT VALUES(SEQ_PCODE.NEXTVAL, '������16', '����', 1600000, 10);
INSERT INTO TB_PRODECT VALUES(SEQ_PCODE.NEXTVAL, '��������', '����', 600000, 20);

SELECT * FROM TB_PRODECT;

COMMIT;

-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� � �԰� �Ǵ� ��� �Ǿ������� ���� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                       -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODECT,             -- ��ǰ��ȣ
    PDATE DATE NOT NULL,                            -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,                         -- ��������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�','���'))  -- ����
);

-- �̷¹�ȣ�� �Ź� ���ο� ��ȣ �߻����Ѽ� �� �� �ְ� �����ִ� ������ (SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���� ��¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');
-- 200�� ��ǰ�� �������� 10 ����
UPDATE TB_PRODECT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT; -- �ش� Ʈ������ Ŀ��

-- 210���� ��ǰ�� ���� ��¥�� 5�� ���
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '���');

UPDATE TB_PRODECT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

-- 205�� ��ǰ�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');

UPDATE TB_PRODECT
SET STOCK = STOCK + 20
WHERE PCODE = 200; -- �Ǽ��� �����Է�

-- �ذ���
ROLLBACK;

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');

UPDATE TB_PRODECT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODECT ���̺� �Ź� �ڵ����� ��� ���� UPDATE �ǰԲ� Ʈ���� ����

/*
    - ��ǰ�� �԰�� ��� = �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODECT
    SET STOCK = STOCK + �����԰�� ����(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �԰�� ��ǰ��ȣ(INSERT�� �ڷ��� PCODE���� ����);
*/

/*
    - ��ǰ�� ���� ��� = �ش� ��ǰ�� ã�Ƽ� �������� �������ִ� UPDATE
    UPDATE TB_PRODECT
    SET STOCK = STOCK - �������� ����
    WHERE PCODE = ���� ��ǰ��ȣ
*/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� => ������ ����
    IF(:NEW.STATUS = '�԰�')
        THEN
            UPDATE TB_PRODECT
                SET STOCK = STOCK + :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
    
    -- ��ǰ�� ���� ��� => ������ ����
    IF (:NEW.STATUS = '���')
        THEN
            UPDATE TB_PRODECT
                SET STOCK = STOCK - :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210�� ��ǰ�� ���ó�¥�� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '���');

-- 200�� ��ǰ�� ���ó�¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');
--------------------------- �ǽ����� -----------------------------------
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
VALUES(011, '������', 80, 80, 80);

INSERT INTO TB_SCODRE
VALUES(022, 'ȫ�浿', 90, 90, 90);

INSERT INTO TB_SCODRE
VALUES(033, '�̱浿', 40, 40, 40);

UPDATE TB_SCODRE
SET K = K + 20
WHERE S_NAME = '������';


SELECT * FROM TB_GRADE;

INSERT INTO TB_GRADE
VALUES('������', 240, 80, 2);

INSERT INTO TB_GRADE
VALUES('ȫ�浿', 270, 90, DEFAULT);

INSERT INTO TB_GRADE
VALUES('�̱浿', 120, 40, 3);

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
        SET POINT = (SELECT ����
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

-- 1. �������̺�(�й�, �̸�, ��, ��, ��), �������̺�(�й�, ������, ���, ���) �����
  -- �������̺� : TB_SCORE       /             �������̺� : TB_GRADE
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

-- 2. �������̺� INSERT �߻��ϸ� �ڵ����� �������̺� INSERT���ִ� Ʈ���� ����

/*
CREATE OR REPLACE TRIGGER TRG_SCORE
AFTER INSERT ON TB_SCORE
FOR EACH ROW
DECLARE 
    STU_NO TB_SCORE.STUDENT_NO%TYPE;
    SUM_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE);
    AVG_SCO NUMBER := TB_SCORE(KO_SCORE + EN_SCORE + MAT_SCORE / 3);
            -- ����, ������ �÷��� �߰��Ǹ� �� ���� ��������, �ϴ�... �Ӹ����V��..
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

INSERT INTO TB_SCORE VALUES(200, '�赹��', 70, 60, 60);
INSERT INTO TB_SCORE VALUES(201, '�ڱÿ�', 80, 90, 70);
INSERT INTO TB_SCORE VALUES(202, '�̴ܱ�', 80, 80, 70);

-- 3. �������̺��� UPDATE�Ǹ� �ش� ����, ����, ���� ������ ���� 
   -- ����Ŭ �ֿܼ� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_GRADE
AFTER UPDATE ON TB_SCORE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���� : ' || :NEW.KO_SCORE);
    DBMS_OUTPUT.PUT_LINE('���� : ' || :NEW.EN_SCORE);
    DBMS_OUTPUT.PUT_LINE('���� : ' || :NEW.MAT_SCORE);
END;
/

-- 4. �������̺� INSERT/ UPDATE �Ǹ� ����� �Űܼ� �������ִ� ���ν��� ����
CREATE OR REPLACE PROCEDURE PROC_UPDATE_RANK IS
BEGIN
    UPDATE TB_GRAD G     --> ���� ����������
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
 
 -- 5. ���� ���̺� �л� �����Ͱ� �����Ǹ� ���� ���̺��� 
  -- �л� ������ ���� + ������ ��� ��� �ű�� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRT_TEST4
AFTER DELETE ON TB_SCORE
FOR EACH ROW
BEGIN
    DELETE FROM TB_GRAD
     WHERE STUDENT_NO = :OLD.STUDENT_NO; 
     
    PROC_UPDATE_RANK;
END;
/