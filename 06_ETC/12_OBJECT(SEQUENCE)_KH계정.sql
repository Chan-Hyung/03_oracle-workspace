/*
     < ������ SEQUENCE >
     �ڵ����� ��ȣ �߻������ִ� ������ �ϴ� ��ü
     ���� ���� ���������� �������� �����ø鼭 ����(�⺻������ 1�� ����)
     
     EX) �����ȣ, ȸ����ȣ, �Խñ۹�ȣ �� ���� ���ļ��� �ȵǴ� �����͵�
*/
/*
    1. ������ ��ü ����
    ǥ����
    CREATE SEQUENCE ��������
    
    (�� ǥ����)
    CREATE SEQUENCE ��������
    [START WITH ���ۼ���]  -- ó�� �߻���ų ���۰� ���� (�⺻�� 1)
    [INCREMENT BY ����]   -- � ������ų���� (�⺻�� 1)
    [MAXVALUE ����]       -- �ִ� ���� (�⺻�� ŭ)
    [MINVALUE ����]       -- �ּҰ� ���� (�⺻�� 1) => �ִ� ��� ó������ �ٽ� ���ƿͼ� �����ϰ� �� �� ����
    [CYCLE / NOCYCLE]    -- �� ��ȯ ���� ���� (�⺻�� NOCYCLE)
    [NOCACHE / CACHE ����Ʈ ũ��] -- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)
    
    - ĳ�� �޸� : �ӽ����� ����
                  �̸� �߻��� ������ �����ؼ� �����صδ� ����
                  �Ź� ȣ��� ������ ������ ��ȣ�� �����ϴ°� �ƴ϶�
                  ĳ�� �޸� ������ �̸� ������ ������ ������ �� �� ����(�ӵ��� ������)
                  ������ �����Ǹ� => ĳ�ø޸𸮿� �̸� ����� �� ��ȣ���� ����
                  ��ȣ �����ϰ� �ο� �ȵ� �� ������ Ȯ���� �� �ؾ���   
*/
CREATE SEQUENCE SEQ_TEST;

-- ����Ŭ�� ������ �ִ� �⺻ SEQUENCE
SELECT * FROM USER_SEQUENCES;

-- �� �ɼ�
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. ������ ���
    ��������.CURRVAL : ���� ������ ��(���������� ���������� ����� NEXTVAL�� ��)
    ��������.NEXTVAL : ������ ���� ���� ���� �������Ѽ� �߻��� ��
                      ��������� ������ INCREMENT BY ����ŭ ������ ��
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
-- *Action:   select NEXTVAL from the sequence before selecting CURRVAL 

-- SELECT ������ ġ�� �ȵ�
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- ���������� ������ NEXTVAL ��

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305(������5 => INCREMENT BY 5)
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- ������ MAXVALUE��(MAXVALUE 310)�� �ʰ��߱� ������ ���� �߻�
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

/*
    3. ������ ���� ����
    ALTER SEQUENCE ��������
    [INCREMENT BY ����]   -- � ������ų���� (�⺻�� 1)
    [MAXVALUE ����]       -- �ִ� ���� (�⺻�� ŭ)
    [MINVALUE ����]       -- �ּҰ� ���� (�⺻�� 1) => �ִ� ��� ó������ �ٽ� ���ƿͼ� �����ϰ� �� �� ����
    [CYCLE / NOCYCLE]    -- �� ��ȯ ���� ���� (�⺻�� NOCYCLE)
    [NOCACHE / CACHE ����Ʈ ũ��] -- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)
    
    �� START WITH ���� �Ұ�
*/
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320(������ ���� => INCREMENT BY 10)

-- 4. ������ ����
DROP SEQUENCE SEQ_EMPNO;
---------------------------------------------------------------------------------------------------

-- �����ȣ�� Ȱ���� ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 400
NOCACHE;

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
    (
      SEQ_EID.NEXTVAL
    , 'ȫ�浿'
    , '990101-1111111'
    , 'J7'
    , 'S1'
    , SYSDATE
    );
    
SELECT * FROM EMPLOYEE;
      
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
    (
      SEQ_EID.NEXTVAL
    , 'ȫ���'         -- ?
    , '990101-2222222'-- ?
    , 'J6'            -- ?
    , 'S1'            -- ?
    , SYSDATE
    );
-- ���߿� ������ �ؼ� �ڹٶ� �����ؼ� ���� ��������




















































































