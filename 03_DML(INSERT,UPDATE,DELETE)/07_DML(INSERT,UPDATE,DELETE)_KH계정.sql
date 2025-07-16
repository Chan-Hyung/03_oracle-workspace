/*
    DQL (QUERY ������ ���� ���) : SELECT
    
    DML (MENIPULATION ������ ���� ���) : [SELECT,] INSERT, UPDATE, DELETE
    DDL (DEFINITION ������ ���� ���) : CREATE, ALTER, DROP
    DCL (CONTROL ������ ���� ���) : GRANT, REVOKE, [COMMIT, ROLLBACK]
    
    TCL (TRANSACTION Ʈ������ ���� ���) : COMMIT, ROLLBACK

    < DML : DATA MATIPULATION LANGUAGE >
    ������ ���� ���
    
    ���̺� ����  ����(INSERT)�ϰų�, ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ����
*/
/*
    1. INSERT
    ���̺� ���ο� ���� �߰��ϴ� ����
    
    (ǥ����)
    1) INSERT INTO ���̺�� VALUES(��1, ��2, ...);
        ���̺��� ��� �÷��� ���� ���� �����ؼ� �� �� INSERT �ϰ��� �� �� ���
        �÷� ������ ���Ѽ� VALUES�� ���� ���� �ؾ���.
        
        VALUES�� ���� �����ϰų� ���� �����ϸ� => not enough values / too many values ������
*/

INSERT INTO EMPLOYEE
VALUES(900, '������', '900101-1234567', 'cha_00@kh.or.kr', '01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;

/*
    2) INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES(��1, ��2, ��3);
        ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
        �׷��� �� �� ������ �߰��Ǳ� ������ ������ �ȵ� �÷��� �⺻������ NULL ǥ��
        => NOT NULL ���� ������ �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� ���� �����ؾ���.
        ��, DEFAULT ���� �ִ� ���� NULL�� �ƴ� DEFAULT ���� ��.
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
        , '�ں���'
        , '880101-1111111'
        , 'J1'
        , 'S2'
        , SYSDATE
        );

SELECT * FROM EMPLOYEE;
-----------------------------------------------------------------------------------------------------------------------
/*
    3) INSERT INTO ���̺�� (��������)
        VALUES�� �� ���� ����ϴ°� ��ſ�
        ���������� ��ȸ�� ������� ��°�� INSERT ����
*/

-- ���ο� ���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- ��ü ������� �纯, �̸�, �μ��� ��ȸ
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

-- �׽�Ʈ�� ���̺�
-- ������ �賢��

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

-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ���, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
    ǥ����
    INSERT ALL
    INTO ���̺��1 VALUES(�÷���, �÷���, ...)
    INTO ���̺��1 VALUES(�÷���, �÷���, ...)
    ��������;
*/
INSERT ALL 
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_01 VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    
-- ������ ����ؼ��� �� ���̺� INSERT ����
---> 2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
-- ���̺� ������ �貸�� ���� �����
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;



---> 2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
    ǥ����
    INSERT ALL
    WHEN ����1 THEN
        INTO ���̺�1 VALUES(�÷���, �÷���, ...)
    WHEN ����2 THEN
        INTO ���̺�2 VALUES(�÷���, �÷���, ...)
    ��������;
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
    ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
    
    ǥ����
    UPDATE ���̺��
        SET �÷��� = �ٲܰ�,
            �÷��� = �ٲܰ�,
            ... => �������� �÷��� ���ÿ� ���� ����
    [WHERE ����] => �����ϸ� ��ü ���̺� �ִ� ��� �����Ͱ� �����.
*/

-- ���纻 ���̺� ���� �۾�
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- D9 �μ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_COPY
    SET DEPT_TITLE = '������ȹ��' -- �ѹ���
WHERE DEPT_ID = 'D9'; -- �߸��ϸ� ROLLBACK����

SELECT * FROM DEPT_COPY;

-- ���纻 ���� ����
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;
    
SELECT * FROM EMP_SALARY;

-- ��ȫö ����� �޿��� 100�������� ���� -- ������ ���
UPDATE EMP_SALARY
    SET SALARY = 1000000 -- 3700000
WHERE EMP_ID = 202;
-- ������ ����� �޿��� 700�������� �����ϰ�, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
    SET SALARY = 7000000, --8000000 
        BONUS = 0.2 -- 0.3
WHERE EMP_ID = 200;
-- ��ü����� �޿��� ������ �޿��� 10���� �λ��� �ݾ�
UPDATE EMP_SALARY
    SET SALARY = SALARY * 1.1;
    
-- UPADATE�� ���������� ��� ����
/*
    UPDATE ���̺��
        SET �÷��� = (��������)
    WHERE ����;
*/
-- ���� ����� �޿��� ���ʽ� ���� ����� ����� �޿��� ���ʽ� ������ ����    
SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '����'; -- 214	����	D1	1518000	

-- ������ ��������
UPDATE EMP_SALARY
    SET SALARY = (SELECT SALARY FROM EMP_SALARY 
                  WHERE EMP_NAME = '�����'),
        BONUS = (SELECT BONUS FROM EMP_SALARY 
                  WHERE EMP_NAME = '�����')
WHERE EMP_ID = 214;
    
-- ���߿� ��������
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY 
                  WHERE EMP_NAME = '�����')
WHERE EMP_ID = 214;

-- ASIA �������� �ٹ��ϴ� ������� ���ʽ����� 0.3���� ����
-- ASIA �������� �ٹ��ϴ� ����� ��ȸ
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

-- UPDATE�ÿ��� �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ�
-- �纯�� 200���� ����� �̸��� NULL�� ����
UPDATE EMPLOYEE
    SET EMP_NAME = NULL
WHERE EMP_ID = 200;
----> NOT NULL ���������� �����ؼ� ���� �߻�

-- ��ȫö ����� �����ڵ带 J9���� ����
SELECT * FROM JOB;
UPDATE EMPLOYEE
    SET JOB_CODE = 'J9'
WHERE EMP_ID = 203;
----> FK ���������� ���õǾ� ���� �߻�

----------------------------------------------------------------------------------------------
/*
    4. DELETE
        ���̺� ��ϵ� �����͸� �����ϴ� ���� ( �� �� ������ ������)
        
        ǥ����
        DELETE FROM ���̺��
        [WHERE ����;] --> WHERE �� ���� ���ϸ� ��ü �� �� ������
    +) ROLLBACK ������ COMMIT�ߴ� ���·� ���ư�(COMMIT�ϸ� ROLLBACK�ϸ� �ٲ���·� �ѹ��)
*/

-- ������ ����� ������ �����
DELETE FROM EMPLOYEE
WHERE EMP_ID = 900;

DELETE FROM EMPLOYEE
WHERE EMP_ID = 901;

SELECT * FROM EMPLOYEE;

COMMIT;

-- DEPT_ID �� D1�μ��� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
----> �ڽ�Ű�� �ڷḦ ����ϰ��ֱ⶧���� �ܷ�Ű �������� �����Ͽ� ����
-- D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ���� �ȵ�.

-- DEPT_ID�� D3�� �μ��� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;

-- TRUNCATE : ���̺��� ��ü ���� ������ �� ���Ǵ� ����
--               DELETE ���� ����ӵ��� ����
--               ������ ���� ���� �Ұ�, ROLLBACK �Ұ�
--  ǥ���� : TRUNCATE TABLE ���̺��;

SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;









































