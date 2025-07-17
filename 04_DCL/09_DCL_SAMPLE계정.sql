CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);
--ORA-01031: insufficient privileges
-- CREATE TABLE 할 수 있는 권한이 없어서 오류 발생
-- 3-1 -> 권한을 받았지만 테이블을 만들 수 없음.
-- 3-2 TABLESPAACE 할당 받기

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, 'ㅎㅇ');
-- CREATE TABLE 권한 받으면 테이블들 조작 가능

----------------------------------------------------------------------
-- KH계정에 있는 EMPLOYEE 테이블에 접근
SELECT * FROM KH.EMPLOYEE;
-- 조회 권한이 없어서 오류 발생(객체접근권한을 받아야함)

-- INSERT ON KH.DEPARTMENT에 넣을 수 있는 권한을 부여
INSERT INTO KH.DEPARTMENT
VALUES('D0', '회계부', 'L1');

































