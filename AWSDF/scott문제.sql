SELECT * FROM EMP;
--1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ
SELECT COMM 
FROM EMP
WHERE COMM IS NOT NULL;
--2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NOT NULL;
--3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ
SELECT ENAME, MGR
FROM EMP
WHERE MGR IS NULL;
--4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC;
--5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
SELECT SAL, COMM
FROM EMP
ORDER BY SAL DESC, COMM DESC;
--6. EMP���̺��� �����ȣ, �����,����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE ASC;
--7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;
--8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ
-- (�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��)
SELECT EMPNO, HIREDATE, ENAME, SAL
FROM EMP
ORDER BY DEPTNO ASC, HIREDATE ASC;
--9. ���� ��¥�� ���� ���� ��ȸ
SELECT SYSDATE FROM DUAL;
--10. EMP���̺��� ���, �����, �޿� ��ȸ
-- (��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
SELECT EMPNO, ENAME, FLOOR(SAL / 100)
FROM EMP
ORDER BY SAL DESC;
--11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) = 1;
--12. EMP���̺��� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'YYYY'), TO_CHAR(HIREDATE, 'MM')
FROM EMP;
--13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
SELECT ENAME, HIREDATE
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
--14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
SELECT ENAME,
TO_CHAR(HIREDATE, 'YY')
FROM EMP
WHERE HIREDATE LIKE '81%';
--15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '%E';
--16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
--16-1. LIKE ���
SELECT ENAME
FROM EMP
WHERE ENAME LIKE '__R%';
--16-2. SUBSTR() �Լ� ���
SELECT ENAME
FROM EMP
WHERE SUBSTR(ENAME, 3, 1) = 'R';
--17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 40*12)
FROM EMP;
--18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT ENAME, HIREDATE
FROM EMP;
--19. ���� ��¥���� �⵵�� ����
SELECT TO_CHAR(SYSDATE, 'YYYY')
FROM DUAL;