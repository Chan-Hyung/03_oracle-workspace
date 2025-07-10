/*
    < SELECT >
    ������ ��ȸ�� �� ���Ǵ� ����
    >> RESULT SET : SELECT���� ���� ��ȸ�� �����(��, ��ȸ�� ����� ����)
    
    (ǥ����)
    SELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2, ... FROM ���̺��;
    
    * �ݵ�� �����ϴ� �÷��� �����, ���� �÷��� ���� �����߻�
*/

-- EMPLOYEE ���̺��� ��� �÷� ��ȸ
-- SELECT EMP_ID, EMP_NAME, ...
SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE;

-- JOB ���̺��� ��� �÷� ��ȸ
SELECT * FROM JOB;

--------------------------- �ǽ� ���� ---------------------------
-- 1. JOB ���̺��� ���޸� ��ȸ
SELECT job_name FROM JOB;

-- 2. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT * FROM department;

-- 3. DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ
SELECT dept_id, dept_title from department;

-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT emp_name, email, phone, hire_date, salary from employee;


/*
    < �÷����� ���� ��� ���� >
    select�� �÷��� �ۼ� ������� ��� ����(�̶�, �������� ��� ��ȸ)
*/

-- employee ���̺��� �����, ����� ����(�޿� * 12) ��ȸ
SELECT emp_name, salary*12 FROM employee;

-- employee ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT emp_name, salary, bonus from employee;

-- employee ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ����Եȿ���((�޿� + �޿� * ���ʽ�) * 12 ) ��ȸ
select emp_name, salary, salary, bonus, salary*12, ((salary+salary*bonus)*12) from employee;
--> ��� ���� ������ null ���� ������ ��� ��������� ����� ������ ������ null�� ����.

-- employee �����, �Ի���
select emp_name, hire_date from employee;

-- employee�� �����, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���ĳ��� ���� ����
-- ���ó�¥ : SYSDATE
SELECT emp_name, hire_date, sysdate - hire_date from employee;
-- date - date : ������� �� ������ ����
-- ��, ���� �������� ������ date ������ ��/��/��/��/��/�� ������ �ð����������� ������ �ϱ� ����

-----------------------------------------------------------------------------
/*
    < �÷��� ��Ī �����ϱ� >
    ��������� �ϰ� �Ǹ� �÷��� �������ѵ�, �̶� �÷������� ��Ī �ο��ؼ� ����ϰ� ����

    (ǥ����)
    �÷��� ��Ī / �÷��� AS ��Ī / �÷��� "��Ī" / �÷��� AS "��Ī"
    
    AS�� ���̵� �Ⱥ��̵簣�� �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư�����ڰ� ���Ե� ��� �ݵ�� ""���� ����ؾ���
    (������ AS ���� ��)
*/

SELECT emp_name �����, salary AS �޿�, salary * 12 "����(��)", ((salary + salary * bonus)*12) AS "*�Ѽҵ�(���ʽ�)"from employee;
-------------------------------------------------------------------------------------------------------------
/*
    < ���ͷ� >
    ���Ƿ� ������ ���ڿ�('')
    
    SELECT���� ���ͷ��� �����ϸ� ��ġ ���̺� �����ϴ� ������ó�� ��ȸ ����
*/

-- EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS "����" FROM EMPLOYEE;

/*
    <���� ������ : ||>
    ���� �÷������� ��ġ �ϳ��� �÷��� �� ó�� ����, �÷����� ���ͷ� ���� ������ �� ����
    
    System.out.oprintln("num�� �� : " + num); => ���� +�� ���� ����
*/

-- ���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY FROM EMPLOYEE;

-- �÷����� ���ͷ��� ����
-- XXX�� ������ XXX�� �Դϴ�.

SELECT EMP_ID || '�� ������' || SALARY || '�� �Դϴ�.' AS "�޿�����" FROM EMPLOYEE;
---------------------------------------------------------------------
/*
    < DISTINCT >
    �÷��� �ߺ��� ������ �ѹ����� ǥ���ϰ��� �� �� ���
*/
-- ���� �츮 ȸ�翡 � ������ ������� �����ϴ��� �ñ�
SELECT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE�� �����ڵ�(�ߺ�����)��ȸ
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE; -- NULL ���� �μ���ġ�� �ȵ� ���

-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE;
--> ���ǻ��� : DISTINCT �� ���� �� �� ����.

SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;

-- -------------------------------------------------------------------------

/*
    <WHERE ��>
    ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
    �̶� WHERE������ ���ǽ��� �����ϰ� ��
    ���ǽĿ����� �پ��� �����ڵ� ��� ����
    
    (ǥ����)
    SELECT �÷�1, �÷�2, ... 
    FROM ���̺��
    WHERE ���ǽ�;
    
    (�� ������)
    >, <, >=, <=     ----> ��Һ�
    =                ----> �����
    !=, ^=, <>       ----> �񵿵� ��
*/

-- EMPLOYEE ���� �̼��ڵ尡 'D9'�� ����鸸 ��ȸ (�̶�, ��� �÷� ��ȸ)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- MEPLOYEE ���� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ常 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- �μ��ڵ尡 'D1'�� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- ���� ��(ENT_YN = 'N')�� ������� ���, �̸�, �Ի���
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

------------------------------------- �ǽ� ���� ----------------------------------
-- 1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ����(���ʽ�������) ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12
FROM EMPLOYEE
WHERE salary >= 3000000;

-- 2. ������ 5000���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12 AS "����", DEPT_CODE -- 3
FROM EMPLOYEE -- ���� ���� 1
WHERE SALARY*12 >= 50000000; -- 2 (WHERE �������� SELECT������ �ۼ��� ��Ī ��� �Ұ�)
--WHERE ���� >= 50000000;
-- ���� �������
-- FROM �� => WHERE �� => SELECT��

-- 3. �����ڵ尡 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ȸ�翩�� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE ^= 'J3';

-- �μ��ڵ尡 'D9' �̸鼭 �޿��� 500���� �̻��� ������� ���, �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- �μ��ڵ尡 'D6' �̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿� �ڵ�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻� ~ 600���� ���ϸ� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
------------------------------------------------------------------
/*
    <BETWEEN A AND B>
    ���ǽĿ��� ���Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ������ �� ���Ǵ� ������
    
    (ǥ����)
    �񱳴���÷� BETWEEN A(��) AND B(��)
    => �ش� �ɷ����� A�̻��̰� B������ ���
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000 ;

-- ���� ���� ���� ���� ����� ��ȸ�ϰ��� �Ѵٸ�?
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR salary >6000000;
WHERE /*NOT*/ SALARY NOT BETWEEN 3500000 AND 6000000 ;
--> NOT : ������������
-- �÷��� �� �Ǵ� �ڿ� �ص� ����

-- �Ի��� '90/01/01' = '01/01/01'
SELECT *
FROM EMPLOYEE
-- WHERE hire_date >= '90/01/01' AND HIRE_DATE <='01/01/01';
WHERE hire_date BETWEEN '90/01/01' AND '01/01/01';

-----------------------------------------------------------------
/*
    < LIKE >
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    (ǥ����)
    �񱳴���÷� LIKE 'Ư������'
    
    - Ư�� ���� ���ý� '%', '_' ���ϵ�ī��� �� �� �ִ�.
    >>'%' : 0���� �̻�
    EX) �񱳴���÷� LIKE '����%'; => �񱳴���� �÷����� ���ڷ� "����"�Ǵ°� ��ȸ
        �񱳴���÷� LIKE '%����' => �񱳴���� �÷����� ���ڷ� "��"���°� ��ȸ
        �񱳴�� �÷� LIKE '%����%' => �񱳴���� �÷����� ���ڰ� "����"�Ǵ°� ��ȸ
        
    >>'_' : 1���� �̻�
    EX) �񱳴���÷� LIKE '_����' => �� ����� �÷� ���� ���ھտ� ������ �� ���ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '__����' => �� ����� �÷� ���� ���ھտ� ������ �� ���ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '_����_' => �� ����� �÷� ���� ���� �հ� �ڿ� ������ �� ���ھ� �� ��� ��ȸ
*/

-- ����� �� ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸��߿� �ϰ� ���Ե� ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- �̸��� ��� ���ڰ� ���� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM MEPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ��ȭ��ȣ��  3��° �ڸ��� 1�� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM employee
WHERE PHONE LIKE '__1%';

-- Ư�����̽�
-- �̸��� �� _ �������� �ձ��ڰ� 3������ ������� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%'; -- ���ߴ� ��� �� ����
-- ���ϵ�ī��� ����ϰ� �ִ� ���ڿ� �÷����� ��� ���ڰ� �����ϱ� ������ ����� ��� X
--> ��� ���ϵ� ī��� ��� ������ ������ ���� ��������
--> ������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ�ī�带 �����ϰ�, ESCAPE OPTION���� ����ؾ���.

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%'ESCAPE '$';

--------------------------- �ǽ� ���� ---------------------------------------
-- 1. EMPLOYEE���� �̸��� '��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT 

-- 2. EMPLOYEE���� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ


-- 3. EMPLOYEE���� �̸��� '��'�� ���ԵǾ� �ְ� �޿��� 240���� �̻��� ������� �����, �޿� ��ȸ


-- 4. DEPARTMENT ���� �ؿܿ������� �μ��� �μ��ڵ�, �μ��� ��ȸ

