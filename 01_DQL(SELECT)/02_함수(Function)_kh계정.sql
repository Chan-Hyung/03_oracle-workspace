/*
    < �Լ� FUNTION >
    ���޵� �÷� ���� �о�鿩�� �Լ��� ������ ����� ��ȯ
    
    1) ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ����(�Ȱ��� ������ ���� ��ȯ)
    2) �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� ����
    
    - SELECT ���� �������Լ��� �׷��Լ��� �Բ� ��� ����
    => ��� ���� ������ �ٸ��� ������
    
    - �Լ� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/

/*
    < ���� ó�� �Լ� >
    LENGTH / LENGTHB        => ����� NUMBER(����) Ÿ�� ���
     LENGTH(�÷�)('���ڿ���') : �ش� ���ڿ����� ���ڼ� ��ȯ
     LENGTHB(�÷�)('���ڿ���') : �ش� ���ڿ����� ����Ʈ�� ��ȯ
     
     +) '��', '��', '��' �ѱ��ڴ� 3BYTE
        ������, ����, Ư�� �ѱ��ڴ� 1BYTE
*/
SELECT SYSDATE FROM DUAL; -- DUAL ���� ���̺�

SELECT LENGTH('Ƽ����'), LENGTHB('Ƽ����')
FROM DUAL;

SELECT LENGTH('ping'), LENGTHB('ping')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), 
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- ���ึ�� �� ����ǰ� ���� -> ������ �Լ�

/*
    INSTR
    ���ڿ��κ��� Ư�� ������ ���� ��ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ�', 'ã�����ϴ� ����', ['ã����ġ�� ���۰�']) => ������� NUMBER Ÿ��(index ���ڷ� ���)
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- ã�� ���� 1�� �ָ� �տ������� ã��
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- ã�� ���� -1�� �ָ� �ڿ������� ã��
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- ã�� ���� 1�� �ְ� 2��° b�� ã��
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL; -- ã�� ���� 1�� �ְ� 2��° b�� ã��

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_�� ��ġ", INSTR(EMAIL, '@') AS "@�� ��ġ"
FROM EMPLOYEE;

------------------------------------------------------------------------------

/*
    SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ(�ڹٿ����� substring() �޼ҵ��� ����)
    
    SUBSTR(STRING, POSITION, [LENGTH])      => ��� ���� CHARACTER Ÿ�� ���
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7��° �ڸ����� �ο���
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; -- 5��° �ڸ����� 2�� ���� ���
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; -- 1��° �ڸ����� 6�� ���� ���
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- �ڿ������� 8��° �ڸ����� 3�� ���� ���

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO,8,1) IN ('2', '4');

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1, 3) -- ���������� �ڵ� ����ȯ
ORDER BY 1;

-- �Լ� ��ø ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "���̵�"
FROM EMPLOYEE;
---------------------------------------------------------------------------------
/*
    LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD/RPAD(STRING, ���������� ��ȯ �� ������ ����, [�����̰����ϴ� ����])
*/

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) -- �����̰����ϴ� ���� ������ �⺻���� ����
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101 - 2****** -> �� 14����
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '******'
FROM EMPLOYEE;
--------------------------------------------------------------------
/*
    LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    LTRIM / RTRIM(STRING, ('�����ҹ��ڵ�')) => �����ϸ� ���� ����
*/

SELECT LTRIM('    K  H  ')FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL; -- 1,2,3�� ���ۺ��� ã�Ƽ� �����ϴٰ� �ٸ� ���ڰ� ������ ����
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT RTRIM('5782KH123', 'D123456789') FROM DUAL;

/*
    TRIM
    ���ڿ��� �� / ��/ ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    TRIM(STRING)
    
    +) Ư�� ���ڿ��� ���ö�
    TRIM([�����ϰ��� �ϴ� ���ڵ� FROM], '���ڿ�')
*/
SELECT TRIM('     K  H   ') FROM DUAL; -- �⺻�����δ� ���ʿ� �ִ� ���ڵ� �� ã�Ƽ� ����
-- SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;

-----------------------------------------------------------------------------------
/*
    LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP(STRING) => ������� CHARCTER Ÿ��
*/

SELECT LOWER('Welcome To The Show') FROM DUAL;
SELECT UPPER('Welcome To The Show') FROM DUAL;
SELECT INITCAP('welcome to the show') FROM DUAL; -- �ܾ��� ������ ���������� ���� �ܾ�� �빮��

-----------------------------------------------------------------------------------------------
/*
    CONCAT
    ���ڿ� 2���� �޾Ƽ� �ϳ��� ��ģ �� ��� ��ȯ
    CONCAT(STRING, STRING)
*/
SELECT CONCAT('ABC', '���ݸ�') FROM DUAL;
SELECT 'ABC' || '���ݸ�' FROM DUAL;

SELECT CONCAT('ABC', '���ݸ�', '���ִ�') FROM DUAL; -- 2���� ���ڿ��� �����༭ �����߻�
SELECT 'ABC' || '���ݸ�' || '���ִ�.' FROM DUAL;

--------------------------------------------------------------------------------
/*
    REPLACE : ����� �� �ٲ���
    REPLACE(STRING, STR,STR)
*/
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

---------------------------------------------------------------------------
/*
    ABS
    ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBER)
*/
SELECT ABS(-10) FROM DUAL;

-------------------------------------------------------------------------------------
/*
    MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ�
    MOD(NUMBER, NUMBER)
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
-----------------------------------------------------------------------
/*
    ROUND
    �ݿø��� ����� ��ȯ
    ROUND(NUMBER, [NUMBER]) ���ڸ� �־� ���° �ڸ����� ������ְ� �ٷ� �ڿ��� �ݿø�����
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
-----------------------------------------------------------------------------------------
/*
    CEIL
    �ø�ó�� ���ִ� �Լ�
    CEIL(NUMBER)
*/
SELECT CEIL(123.152) FROM DUAL;
-----------------------------------------------------------------------------------------
/*
    FLOOR
    �Ҽ��� �Ʒ� ����ó�� �ϴ� �Լ�
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.952) FROM DUAL;
-------------------------------------------------------------------------------
/*
    TRUNC
    ��ġ ���� ������ ���� ó�����ִ� �Լ�
    TRUNC(NUMBER, [NUMBER])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
-----------------------------------------------------------------------------------
/*
    ��¥ ó�� �Լ�
    SYSDATE : �ý��� ��¥ �� �ð� ��ȯ
    MONTHS_BETWEEN(DATE, DATE) : �� ��¥ ������ ������
    ADD_MONTHS(DATE, NUMBER) : Ư����¥�� �ش� ���ڸ�ŭ�� ������ ���ؼ� ��ȯ
    NEXT_DAY (DATE, ����) : �ش� ��¥ ���Ŀ� ���� ����� ������ ��¥�� ��ȯ
    LAST_DAY(DATE) : �ش���� ������ ��¥�� ��ȯ
*/
SELECT SYSDATE FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, FLOOR (SYSDATE-HIRE_DATE) || '��' AS "�ٹ��ϼ�", CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "�ٹ�������"
FROM EMPLOYEE;

SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS "�����Ⱓ ���� ��¥"
FROM EMPLOYEE;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ����') FROM DUAL;

SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE AS "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;

/*
    EXTRACT : Ư����¥�κ��� �⵵ | �� | �� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    EXTRACT(YEAR FROM DATE) : �⵵�� ����
    EXTRACT(MONTH FROM DATE) : ���� ����
    EXTRACT(DAY FROM DATE) : �ϸ� ����
*/
-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME,
EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",
EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��",
EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵", "�Ի��", "�Ի���";
-------------------------------------------------------------
/*
    ����ȯ �Լ�
    TO_CHAR : ����, ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    TO_CHAR(����|��¥, [����])
*/
-- ����Ÿ�� => ����Ÿ��
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
FROM EMPLOYEE;

SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- 1990�� 02�� 06�� ��������
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')
FROM EMPLOYEE;

-- �⿡ ���� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ���� ���� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- �Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DDD'),
        TO_CHAR(SYSDATE, 'DD'),
         TO_CHAR(SYSDATE, 'D')
FROM DUAL;

-- ���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
-----------------------------------------------------------------------
/*
    TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ�� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_DATE(����|����, [����])
*/
SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL;
SELECT TO_DATE('070101') FROM DUAL; -- ù���ڰ� 0�� ��쿡�� ������ ����Ÿ������ �����ؾ���

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 2098 => ������ ���� ����� �ݿ�

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;
-- RR : �ش� ���ڸ� �⵵ ���� 50�̾��� ��� ���缼�� �ݿ� <=> 50�̻��� ��� �������� �ݿ�

-- ���󿡼� ��¥�� �����͸� �Ѱܵ� ������ ���ڷ� �Ѿ��

-------------------------------------------------------------------------------
/*
    TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_NUMBER(����, [����])
*/
SELECT TO_NUMBER('0124894513898') FROM DUAL;
SELECT '1000000' + '55000' FROM DUAL;
--SELECT '1,000,000' + '55,000' FROM DUAL; ���ڸ� �־����

SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('55,000', '99,999') FROM DUAL;
------------------------------------------------------------------------------------------
/*
     NULL ó�� �Լ�
     NVL(�÷�, �ش� �÷����� NULL�� ��� ��ȯ�� ��)
     NVL2(�÷�, ��ȯ��1, ��ȯ��2) : �÷����� ������ ��� ��ȯ��1 ��ȯ
                                 �÷����� NULL�� ��� ��ȯ��2 ��ȯ
     NULLIF(�񱳴��1, �񱳴��2) : �� ���� ���� ��ġ�ϸ� NULL ��ȯ
                                  �� ���� ���� ��ġ���� ������ �񱳴��1 ���� ��ȯ
*/
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- �̸�, ���ʽ����� ����
SELECT EMP_NAME, BONUS, (SALARY+SALARY*BONUS)*12, (SALARY+SALARY*NVL(BONUS, 0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE, '�μ�����')
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ�����', '�μ�����')
FROM EMPLOYEE;

SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;
------------------------------------------------------------------------------------
/*
    < ���� �Լ�>
    DECODE(���ϰ����ϴ� ���, �񱳰�1, �����1, �񱳰�2, �����2, ...)
    => SWITCH�� �����
*/
-- ���, �����, �ֹι�ȣ
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����"
FROM EMPLOYEE;

-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10%�λ� (SALARY * 1.1)
-- J8�� ����� �޿��� 15% �λ� (SALARY * 1.15)
-- J5�� ����� �׺��� 20% �λ� (SALARY * 1.2)
-- �� ���� ����� �޿� 5% �λ� (SALARY * 1.05)

-- �����,�����ڵ�, �����޿�, �λ�ȱ޿�
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE (JOB_CODE, 'J7', SALARY * 1.1, 
                   'J6', SALARY * 1.5, 
                   'J5', SALARY * 1.2,
                   SALARY * 1.05) AS "�λ�� �޿�"
FROM EMPLOYEE;
-------------------------------------------------------------------------------------
/*
    CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����N
    END
*/
SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY >= 5000000 THEN '��ް�����'
             WHEN SALARY >= 3500000 THEN '�߱ް�����'
             ELSE '�ʱް�����'
        END AS "����"
FROM EMPLOYEE;
-----------------------------------------------------------------
/*
    �׷� �Լ�
    1. SUM(����Ÿ���÷�) : �ش� �÷� ������ �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�
    2. AVG(����Ÿ��) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
    3. MIN(����Ÿ��) : �ش� �÷����� �߿� ���� ���� �� ���ؼ� ��ȯ
    4. MAX(����Ÿ��) : �ش� �÷����� �߿� ���� ū �� ���ؼ� ��ȯ
    5. COUNT(*|Į��|DISTINCT) : ��ȸ�� �� ������ ���� ��ȯ
       COUNT(*) : ��ȸ�� ����� ��� �� ������ ���� ��ȯ
       COUNT(�÷�) : ������ �ش� �÷����� NULL�� �ƴ� �͸� �� ������ ���� ��ȯ
       COUNT(DISTINCT �÷�) : �ش� �÷��� �ߺ� ������ �� �� ���� ���� ��ȯ
*/

-- ��ü ����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE; -- ��ü ����� �� �׷����� ����

-- ���� ������� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); -- ���ڻ������ �� �׷����� ����

-- �μ��ڵ尡 D5�� ������� �� ������(���ʽ�������)
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- ��ü����� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM employee; -- ��ü �����

SELECT COUNT(BONUS)
FROM EMPLOYEE; -- ���ʽ��� �޴� ��� ��(NULL�ƴ� �����)

SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('1', '3'); -- ���� ��� �� ���ʽ��� �޴� ��� ��

-- �μ���ġ�� ���� ��� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE; --���� ������� ��� �μ��� �����Ǿ��ִ���(�ߺ� ����)