CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
--ORA-01031: insufficient privileges
-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�
-- 3-1 -> ������ �޾����� ���̺��� ���� �� ����.
-- 3-2 TABLESPAACE �Ҵ� �ޱ�

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '����');
-- CREATE TABLE ���� ������ ���̺�� ���� ����

----------------------------------------------------------------------
-- KH������ �ִ� EMPLOYEE ���̺� ����
SELECT * FROM KH.EMPLOYEE;
-- ��ȸ ������ ��� ���� �߻�(��ü���ٱ����� �޾ƾ���)

-- INSERT ON KH.DEPARTMENT�� ���� �� �ִ� ������ �ο�
INSERT INTO KH.DEPARTMENT
VALUES('D0', 'ȸ���', 'L1');

































