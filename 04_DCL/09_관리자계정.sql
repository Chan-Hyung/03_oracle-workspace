/*
    < DCL : DATA CONTROL LANGUAGE >
    ������ ���� ���
    
    �������� �ý��۱��� �Ǵ�  ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REVOKE) �ϴ� ����
    
    -> �ý��� ���� : DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    -> ��ü���ٱ��� : Ư�� ��ü���� ������ �� �ִ� ����
*/
/*
    - �ý��۱��� ����
    1) CREATE SESSION : ���� �� �� �ִ� ����
    2) CREATE TABLE : ���̺��� ������ �� �ִ� ����
    3) CREATE VIEW : �並 ������ �� �ִ� ����
    4) CREATE SEQUENCE : �������� ������ �� �ִ� ����
    ... : �Ϻδ� CONNECT�ȿ� ���Ե� ����
*/

-- 1. SAMPLE / SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- ����: ���� -�׽�Ʈ ����: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

-- 2. ������ ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

-- 3-1 ���̺��� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

-- 3-2 TABLESPACE �Ҵ�(������ �������� �� �� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-------------------------------------------------------------------
/*
    - ��ü ���� ���� ����
    Ư�� ��ü�� �����ؼ� ������ �� �ִ� ����
    
    - ���� ����         Ư�� ��ü
    1) SELECT     TABLE, VIEW, SEQUENCE
    2) INSERT     TABLE, VIEW
    3) UPDATE     TABLE, VIEW
    4) DELETE     TABLE, VIEW
    
    (ǥ����)
    GRANT �������� ON Ư����ü TO ����
    
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

-------------------------------------------------------------
GRANT CONNECT, RESOURCE TO ������;

/*
    < �� ROLE >
    - Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT : ������ �� �ִ� ���� CREATE SESSOIN
    RESOURCE : Ư�� ��ü���� ���� �� �� �ִ� ���� CREATE TABLE, CREATE SEQUENCE, ...
*/

SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE')
ORDER BY 1;




















