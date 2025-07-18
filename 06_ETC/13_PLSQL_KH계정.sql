/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    SQL ���峻���� ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE)���� �����Ͽ� SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���� ����(BLOCK ����) + ����ó���� ����
    
    * PL / SQL ����
    - [�����] : DECLARE�� ���� -> ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - �����   : BEGIN���� ���� -> ������ �־����, SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ��� �ϴ� �κ�
    - [����ó����] : EXCEPTION���� ���� -> ���� �߻��� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� ����
*/
-- �����ϰ� ȭ�鿡 HELLO ORACLE ���
SET SERVEROUTPUT ON;

BEGIN -- ����ص� �Ⱥ��̴� ������ �ܼ��� �����־(SET SERVEROUTPUT ON;)
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/


---------------------------------------------------------------------------
/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
    �Ϲ�Ÿ�� ����, ��ó����Ÿ�� ����, ROWŸ�� ����
    
    1-1 �Ϲ�Ÿ�� ���� ���� �� �ʱ�ȭ
    ǥ���� = ������ [CONSTANT -> �������] �ڷ��� [:= ��];
    =>                                 �� ���� ����
*/
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
    --ENAME := '������';
     
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI :' || PI);
END;
/
-----------------------------------------------------------------------
-- 1-2 ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (� ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
-- ǥ���� = ������ ���̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    --EID := '300';
    --ENAME := '������';
    --SAL := 3000000;
    
    -- ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
---------------------------- �ǽ����� --------------------------------------------------
/*
    ���۷���Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ�
    �� �ڷ����� EMPLOYEE, DEPARTMENT ���̺���� �÷����� �����ϵ���
    
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� �� �� ������ ��Ƽ� ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
    
END;
/

-----------------------------------------------------------------------------------------------
-- 1-3 ROW Ÿ�� ���� ����
--     ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
--     ǥ���� = ������ ���̺��%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * 
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('����� : ' || NVL(E.BONUS, 0));
    
END;
/
------------------------------------------------------------------------------------------
-- 2. BEGIN �����
-- < ���ǹ� >
-- 2-1 IF ���ǽ� THEN ���೻�� END IF; (�ܵ� IF��)

-- ��� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('���: ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿�: ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS*100 || '%');
    
END;
/

-- 2-2 IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('���: ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿�: ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS*100 || '%');
    END IF;

END;
/

----------------------------------- �ǽ����� ------------------------------------------------
DECLARE
    -- ���۷���Ÿ�� ���� (EID, ENAME, DTITLE, NCODE)
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    -- ������ ���̺� EMPLOYEE, DEPARTMENT, LOCATION
    -- �Ϲ�Ÿ�Ժ��� (TEAM ���ڿ�) => �̵��� '������' Ȥ�� '�ؿ���' ��� ����
    TEAM VARCHAR2(10);
BEGIN
    -- ����ڰ� �Է��� ����� ������ �ִ� ����� ���,�̸�,�μ���, �ٹ�����
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
    JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
    WHERE EMP_ID = &���;
    -- NCODE�� ���� KO�� ��� => TEAM�� '������'
    --         ���� �ƴ� ��� => TEAM�� '�ؿ���'
    IF NCODE = 'KO'
        THEN TEAM := '������';
    ELSE 
        TEAM := '�ؿ���';
    END IF;
    
    -- ���, �̸�, �μ���, �Ҽ�(������, �ؿ���)�� ���� ���
    DBMS_OUTPUT.PUT_LINE('���: ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ���: ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ�: ' || TEAM);
END;
/
-----------------------------------------------------------------------------
-- 2 - 3 IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ELSE ���೻��2 END IF;
-- ������ �Է� �޾� SCORE ������ ����
-- 90�� �̻��� 'A', 80�� �̻��� 'B', 70�� �̻��� 'C', 60�� �̻��� 'D', 60�� �̸��� 'F'�� ó���� ��
-- GRADE ������ ����
-- '����� ������ XX���̰�, ������ X���� �Դϴ�.'

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >= 80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';
    ELSIF SCORE >= 60
        THEN GRADE := 'D';
    ELSE
        GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������' || GRADE || '�����Դϴ�.');
END;
/

-- �޿�
-- ���� �Է��� ����� �Է��Ͽ� ����� �޿���
-- GRADE�� ����
-- 500���� �̻��̸� '���'
-- 300���� �̻��̸� '�߱�'
-- 300���� �̸��̸� '�ʱ�'

-- �ش� ����� �޿� ����� XX �Դϴ�.

DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF SAL >= 5000000
        THEN GRADE := '���';
    ELSIF SAL >= 3000000
        THEN GRADE := '�߱�';
    ELSE
        GRADE := '�ʱ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿� ����� ' || GRADE || '�Դϴ�.');
    
END;
/

----------------------------------------------------------------------------------
-- 2-4 CASE �񱳴���� WHEN ������Ұ�1 THEN �����1 WHEN ������Ұ�2 THEN �����2 ... ELSE �����N  END;
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); --�μ��� ���� ����
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ���'
                WHEN 'D2' THEN 'ȸ����'
                WHEN 'D3' THEN '��������'
                WHEN 'D4' THEN '����������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '�ؿܿ�����'
              END;
              
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '��(��)' || DNAME || '�Դϴ�.');
END;
/

-- 1. ����� ������ ���ϴ� ���ν��� �ۼ�
--      ���ʽ��� �ִ� ����� ���ʽ��� ���� �ؼ� ���
--      ���ʽ��� ������ ���ʽ����� ����
--      ���ʽ��� ������ ���ʽ� ������ ����
--      ��¿���
--      �޿� �̸� \(��ȭ��ȣ)

DECLARE
    E EMPLOYEE%ROWTYPE;
    SAL NUMBER;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF E.BONUS IS NULL
        THEN SAL :=(E.SALARY*12);
    ELSE
        SAL := (E.SALARY + E.SALARY * E.BONUS)*12;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(E.SALARY || ' ' || E.EMP_NAME || SAL || TO_CHAR(SAL, 'L999,999,999'));  
    
END;
/
-----------------------------------------------------------------------------------------------------------
/*
    1) BASIC LOOP ��
    LOOP
        �ݺ������� ������ ����
        * �ݺ����� �������� �� �ִ� ����
    END LOOP;
    
    * �ݺ����� �������� �� �ִ� ����
    1) IF ���ǽ� THEN EXIT;
    2) EXIT WHEN ���ǽ�;
*/

-- 1~5���� ���������� 1�� ����
DECLARE
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        
        --IF I = 6 THEN EXIT; END IF;
        EXIT WHEN I = 6;
    END LOOP;

END;
/

-----------------------------------------------------------------------------------------
/*
    2) FOR LOOP��
    ǥ����
    FOR ���� IN [REVERSE] �ʱⰪ..���Ѱ�
                  �� ���� ���ҽ�Ű�� ����
    LOOP
        �ݺ������� ������ ����
    END LOOP
*/  
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
    
);

SELECT * FROM TEST;


CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 100
NOCYCLE
NOCACHE;

BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST;
----------------------------------------------------------------------------------------
/*
    3) WHILE LOOP��
    ǥ����
    WHILE �ݺ����� ����� ����
    LOOP
        �ݺ������� ������ ����
    END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I   := I + 1;
    END LOOP;
END;
/

---------------------------------------------------------------------------------------------------------
/*
    3. ����ó����
    ����(EXCEPTION) : ���� �� �߻��ϴ� ����
    ǥ����
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ...
        => ���๮ -> WHEN OTHERS ����ó������N;
        
        - ���ܸ� ����
        - �ý��� ���� (����Ŭ���� �̸� �����ص� ����)
        - NO_DATA_FOIND : SELECT�� ����� �� �ൿ ���� ���
        - TOO_MANYRESULT : SELECT�� ����� ���� ���� ���
        - ZERO_DIVIDE : 0���� ������ �� ��
        - DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ������� ���
        ...
*/
-- ����ڰ� �Է��� ���� ������ ������ ��� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
    EXCEPTION
        --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� ����.');
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� ����.');
END;
/

-- UNIQUE ���� ���� ����
BEGIN
    UPDATE EMPLOYEE
        SET EMP_ID = &�����һ��
    WHERE MEP_NAME = '��ȫö';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������;
    
    DBMS_OUTPUT.PUT_LINE('���: ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸�: ' || ENAME);
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ���� ���� ��ȸ�ƽ��ϴ�.');
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�.');
END;
/






















































