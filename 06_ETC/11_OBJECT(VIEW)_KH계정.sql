/*
    < VIEW �� >
    
    SELECT���� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �������ϸ� �Ź� �ٽ� �� �ʿ� ����)
    �ӽ����̺� ���� ���� (���� �����Ͱ� ����ִ°� �ƴ�) => �׳� �����ֱ��
    �������� ���̺� : ����
    ������ ���̺� : ���� => ��� ������ ���̺�
*/
-- �並 ����� ���� ������ ������ �ۼ�
-- ������ ������

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-- '�Ϻ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';

-----------------------------------------------------------------------------------------
/*
    1. VIEW ���� ���
    ǥ����
    CREATE [OR REPLACE] VIEW ���
    AS ��������;
    
    OR REPLACE : �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ������ �並 �����ϰ�,
                 ������ �ߺ��� �̸��� �䰡 �ִٸ� �ش� �並 �����ϴ� �ɼ�
*/
CREATE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-01031: insufficient privileges(����) : �� �����ϴ� ������ ����
-- �ذ��� : ������ ������ �����ؼ� ���� �ο��ؾ���.

GRANT CREATE VIEW TO KH;

SELECT * FROM VW_EMPLOYEE; -- �����̺�(�������̺� / �������̺��� �ƴ϶� ������ �ȵ�)

SELECT * FROM(SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
                FROM EMPLOYEE
                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                JOIN NATIONAL USING(NATIONAL_CODE)); -- �ζ�� 

-- �ѱ����� �ٹ��ϴ� ���
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';

CREATE OR REPLACE VIEW VW_EMPLOYEE -- OR REPLACE : ������ �ϰų� �ٲٰų�
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-00955: name is already used by an existing object : VW_EMPLOYEE�� �̸��� ���� �䰡 �־ ���� �߻�
-- �ذ��� : ����� �ٸ��ɷ� �ϸ� ��.
--------------------------------------------------------------------------------------------------
-- �� ����� ���, �̸�, ���޸�, ����(��/��), �ٹ������ ��ȸ�� �� �ִ� SELECT���� ��(VW_EMP_JOB)�� ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����(��/��)",
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
/*
    ORA-00998: must name this expression with a column alias : �� �÷��� ��ġ�� �ο�
    ���������� SELECT���� �Լ����̳� ���������� ��� �Ǿ� ���� ��� �ݵ�� ��Ī�� �����ؾ���.
*/

SELECT * FROM VW_EMP_JOB;

CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME,
            DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
        FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);

SELECT �̸�, ���޸�
FROM VW_EMP_JOB
WHERE ���� = '��';

SELECT *
FROM VW_EMP_JOB
WHERE �ٹ���� >=20;

-- �� �����ϰ��� �Ѵٸ�
DROP VIEW VW_EMP_JOB;
--------------------------------------------------------------------------------------------------
-- ������ �並 �̿��� DML ��� ����
-- �並 ���ؼ� �����ϴ��� ���� ���̺� �ݿ���
-- �ٵ� �� �ȵǴ� �汸�� ���Ƽ� ������ ���� �������� ����

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
FROM JOB;

SELECT * FROM VW_JOB; --�����̺�
SELECT * FROM JOB;    --�������̺�

-- �並 ���� INSERT
INSERT INTO VW_JOB VALUES('J8', '����');

-- �並 ���� UPDATE
UPDATE VW_JOB
    SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';

-- �並 ���� DELETE
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

------------------------------------------------------------------------------------------
/*
    ��, DML ��ɾ�� ������ �Ұ����� ��찡 ����
    1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
    2) �信 ���ǵǾ����� ���� �÷��߿� ���̽����̺� �� NOT NULL ���������� �ִ� ��� => ��� �ǰ� ��� �ȵ�
    3) �������� �Ǵ� �Լ������� ���ǵǾ��ִ� ���
    4) GROUP BY, �׷��Լ� ���Ե� ��� �ȵ�
    5) DISTINCT ������ ���Ե� ��� �ȵ�
    6) JOIN�� �̿��ؼ� �������̺��� ������ѳ��� ��� �ȵ�
    => ��, ��� ��ȸ�Ϸ��� ����Ŷ� DML�� ��������
*/
-- 1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- INSERT
INSERT INTO VW_JOB VALUES('J8', '����');
-- 00913. 00000 -  "too many values" CODE�� �����ϴµ� NAME������ �־ �����߻�

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';
-- ORA-00904: "JOB_NAME": invalid identifier : INSERT�� ���� ������ �����߻�

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';
-- ORA-00904: "JOB_NAME": invalid identifier : ��Ÿ�� ������ ���� �߻�


-- 2) �信 ���ǵǾ����� ���� �÷��߿� ���̽����̺� �� NOT NULL ���������� �ִ� ��� => ��� �ǰ� ��� �ȵ�
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

--INSERT
INSERT INTO  VW_JOB VALUES('����');
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '���';

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';
-- �����߻�
    
    
-- 3) �������� �Ǵ� �Լ������� ���ǵǾ��ִ� ���
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "����"
FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;
SELECT * FROM EMPLOYEE;

-- INSERT
INSERT INTO VW_EMP_SAL VALUES(400, '������', 300000, 36000000);
-- ORA-01733: virtual column not allowed here : EMPLOYEE ���̺� �����̶�� ���� ���� ������ ���� �߻�

-- UPDATE
UPDATE VW_EMP_SAL
SET ���� = 80000000
WHERE EMP_ID = 200;
-- ORA-01733: virtual column not allowed here

UPDATE VW_EMP_SAL
SET SALARY = 70000000
WHERE EMP_ID = 200; -- ����

ROLLBACK;

-- DELETE
DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;

ROLLBACK;


-- 4) GROUP BY, �׷��Լ� ���Ե� ��� �ȵ�
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS"�հ�", FLOOR(AVG(SALARY)) AS "���"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM VW_GROUPDEPT;

-- INSERT
INSERT INTO VW_GROUPDEPT VALUES('D3', 8000000, 4000000);
-- ORA-01733: virtual column not allowed here

-- UPDATE
UPDATE VW_GROUPDEPT
SET �հ� = 8000000
WHERE DEPT_CODE = 'D1';
-- ORA-01732: data manipulation operation not legal on this view

-- DELETE
DELETE VW_GROUPDEPT
WHERE �հ� = 5210000;
-- ORA-01732: data manipulation operation not legal on this view


-- 5) DISTINCT ������ ���Ե� ��� �ȵ�
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES('J8');
-- ORA-01732: data manipulation operation not legal on this view

-- UPDATE
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7';
-- ORA-01732: data manipulation operation not legal on this view

-- DELETE
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J4';
-- ORA-01732: data manipulation operation not legal on this view


-- 6) JOIN�� �̿��ؼ� �������̺��� ������ѳ��� ��� �ȵ�
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMOPLYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM VW_JOINEMP;

INSERT INTO VW_JOINEMP VALUES(300, '�����', '�ѹ���');
-- ����

-- UPDATE
UPDATE VW_JOINEMP
SET EMP_NAME = '������'
WHERE EMP_ID = 200;

ROLLBACK;

UPDATE VW_JOINEMP
SET DEPT_TITLE = 'ȸ���'
WHERE EMP_ID = 200;
-- ����

-- DELETE
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

ROLLBACK;

---------------------------------------------------------------------------------------
/*
     - VIEW �ɼ�
     �� ǥ����
     CREATE OR REPLACE [FORCE|NOFORCE] VIEW ���
     AS ��������
     [WITH CHECK OPTION]
     [WITH READ ONLY];
     
     1. OR REPLACE : ������ ������ �䰡 ���� ��� �������ϰ�, �������� ������ ���Ӱ� ����
     2. FORCE | NOFORCE 
        2-1) FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �ϴ� 
        2-2) NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̿��߸� �䰡 �����ǰ� �ϴ� (������ �⺻��)
    3. WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML �����ϵ��� (�� �Ⱦ�)
    4. WITH READ ONLY : �信 ���ؼ� ��ȸ�� ����
*/

-- 2. FORCE | NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;
-- ORA-00942: table or view does not exist : �ش� ���̺� ������ �ȵż� �����߻�

CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT; -- ���̺� ������ ��

SELECT * FROM VW_EMP; -- ��ȸ�ȵ�
---------------------------------- TT���̺��� ������ �Ǹ� ��� ���̺��� �ذᰡ��
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR(20),
    TCONTENT VARCHAR(30)
);

-- 3. WITH CHECK OPTION : ���������� ����� ���ǿ� ���յ��� �ʴ� ������ ������ ���� �߻�
-- WITH CHECK OPTION �Ⱦ���
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
SELECT * FROM VW_EMP;

UPDATE VW_EMP
SET SALARY = 2000000 -- 8000000
WHERE EMP_ID = 200;

ROLLBACK;

CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
WITH CHECK OPTION;

SELECT * FROM VW_EMP;

UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200; -- ������
-- ���������� ����� ���ǿ� ���յ��� �ʾ� ������ �Ұ�

UPDATE VW_EMP
SET SALARY = 4000000
WHERE EMP_ID = 200; -- ���������� ����� ���ǿ� ���յǱ� ������ ���� ����

ROLLBACK;

-- 4. WITH READ ONLY : �信 ���ؼ� ��ȸ�� ���� (DML�� ���� �Ұ�)
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMP;

DELETE FROM VW_EMP
WHERE MEP_ID = 200;
-- ORA-42399: cannot perform a DML operation on a read-only view : �б� �����̶� ���� �Ұ�





