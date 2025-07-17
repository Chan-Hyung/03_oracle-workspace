-- 1. 23�⿡ �� ����� �̸��� ������ ��ǰ�� ������ ���
SELECT C.NAME, B.PCODE, B.QUANTITY,
EXTRACT(YEAR FROM B.BUY_DATE)
FROM TBL_BUY B
JOIN TBL_CUSTOM C ON (B.CUSTOMID = C.CUSTOM_ID)
WHERE EXTRACT(YEAR FROM B.BUY_DATE) = 2023;

-- 2. ������ �� ��ǰ�� Ȯ���� �� �ֵ��� VIEW�� ���(�� �̸� VW_TBL, ���Գ�¥ ����� 0000��, 00��, 00��)                                           
CREATE OR REPLACE VIEW VW_TBL
AS SELECT C.NAME AS "�̸�", P.PNAME AS "��ǰ�̸�", B.QUANTITY AS "����", TO_CHAR(B.BUY_DATE, 'YYYY"��" MM"��" DD"��"') AS "���Գ�¥"
FROM TBL_CUSTOM C
JOIN TBL_BUY B ON (B.CUSTOMID = C.CUSTOM_ID)
JOIN TBL_PRODUCT P ON (P.PCODE = B.PCODE)
ORDER BY "�̸�", "����";

SELECT * FROM VW_TBL;
