/*
    < 함수 FUNTION >
    전달된 컬럼 값을 읽어들여서 함수를 실행한 결과를 반환
    
    1) 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴(똑같은 갯수의 값을 반환)
    2) 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴
    
    - SELECT 절에 단일행함수랑 그룹함수를 함께 사용 못함
    => 결과 행의 개수가 다르기 때문에
    
    - 함수 쓸 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
*/

/*
    < 문자 처리 함수 >
    LENGTH / LENGTHB        => 결과값 NUMBER(숫자) 타입 출력
     LENGTH(컬럼)('문자열값') : 해당 문자열값의 글자수 반환
     LENGTHB(컬럼)('문자열값') : 해당 문자열값의 바이트수 반환
     
     +) '김', '나', 'ㄱ' 한글자당 3BYTE
        영문자, 숫자, 특문 한글자당 1BYTE
*/
SELECT SYSDATE FROM DUAL; -- DUAL 가상 테이블

SELECT LENGTH('티니핑'), LENGTHB('티니핑')
FROM DUAL;

SELECT LENGTH('ping'), LENGTHB('ping')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), 
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- 매행마다 다 실행되고 있음 -> 단일행 함수

/*
    INSTR
    문자열로부터 특정 문자의 시작 위치를 찾아서 반환
    
    INSTR(컬럼|'문자열', '찾고자하는 문자', ['찾을위치의 시작값']) => 결과값은 NUMBER 타입(index 숫자로 출력)
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 찾을 값을 1로 주면 앞에서부터 찾음
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 찾을 값을 -1로 주면 뒤에서부터 찾음
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 찾을 값을 1로 주고 2번째 b를 찾음
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL; -- 찾을 값을 1로 주고 2번째 b를 찾음

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_의 위치", INSTR(EMAIL, '@') AS "@의 위치"
FROM EMPLOYEE;

------------------------------------------------------------------------------

/*
    SUBSTR
    문자열에서 특정 문자열을 추출해서 반환(자바에서의 substring() 메소드의 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH])      => 결과 값이 CHARACTER 타입 출력
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7번째 자리부터 부여줌
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; -- 5번째 자리부터 2개 문자 출력
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; -- 1번째 자리부터 6개 문자 출력
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- 뒤에서부터 8번째 자리부터 3개 문자 출력

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

-- 여자 사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO,8,1) IN ('2', '4');

-- 남자 사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1, 3) -- 내부적으로 자동 형변환
ORDER BY 1;

-- 함수 중첩 사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "아이디"
FROM EMPLOYEE;
---------------------------------------------------------------------------------
/*
    LPAD / RPAD
    문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
    
    LPAD/RPAD(STRING, 최족적으로 반환 할 문자의 길이, [덧붙이고자하는 문자])
*/

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) -- 덧붙이고자하는 문자 생략시 기본값이 공백
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, EMAIL, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101 - 2****** -> 총 14글자
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

SELECT RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 8) || '******'
FROM EMPLOYEE;
--------------------------------------------------------------------
/*
    LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    LTRIM / RTRIM(STRING, ('제거할문자들')) => 생략하면 공백 제거
*/

SELECT LTRIM('    K  H  ')FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL; -- 1,2,3을 시작부터 찾아서 제거하다가 다른 문자가 나오면 종료
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT RTRIM('5782KH123', 'D123456789') FROM DUAL;

/*
    TRIM
    문자열의 앞 / 뒤/ 양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    TRIM(STRING)
    
    +) 특정 문자열이 나올때
    TRIM([제거하고자 하는 문자들 FROM], '문자열')
*/
SELECT TRIM('     K  H   ') FROM DUAL; -- 기본적으로는 양쪽에 있는 문자들 다 찾아서 제거
-- SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;

-----------------------------------------------------------------------------------
/*
    LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP(STRING) => 결과값은 CHARCTER 타입
*/

SELECT LOWER('Welcome To The Show') FROM DUAL;
SELECT UPPER('Welcome To The Show') FROM DUAL;
SELECT INITCAP('welcome to the show') FROM DUAL; -- 단어의 공백이 있을때마다 시작 단어는 대문자

-----------------------------------------------------------------------------------------------
/*
    CONCAT
    문자열 2개를 받아서 하나로 합친 후 결과 반환
    CONCAT(STRING, STRING)
*/
SELECT CONCAT('ABC', '초콜릿') FROM DUAL;
SELECT 'ABC' || '초콜릿' FROM DUAL;

SELECT CONCAT('ABC', '초콜릿', '맛있다') FROM DUAL; -- 2개의 문자열만 합쳐줘서 오류발생
SELECT 'ABC' || '초콜릿' || '맛있다.' FROM DUAL;

--------------------------------------------------------------------------------
/*
    REPLACE : 출력할 때 바꿔줌
    REPLACE(STRING, STR,STR)
*/
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

---------------------------------------------------------------------------
/*
    ABS
    숫자의 절대값을 구해주는 함수
    
    ABS(NUMBER)
*/
SELECT ABS(-10) FROM DUAL;

-------------------------------------------------------------------------------------
/*
    MOD
    두 수를 나눈 나머지값을 반환해주는 함수
    MOD(NUMBER, NUMBER)
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;
-----------------------------------------------------------------------
/*
    ROUND
    반올림한 결과를 반환
    ROUND(NUMBER, [NUMBER]) 숫자를 넣어 몇번째 자리까지 출력해주고 바로 뒤에서 반올림해줌
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
-----------------------------------------------------------------------------------------
/*
    CEIL
    올림처리 해주는 함수
    CEIL(NUMBER)
*/
SELECT CEIL(123.152) FROM DUAL;
-----------------------------------------------------------------------------------------
/*
    FLOOR
    소수점 아래 버림처리 하는 함수
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.952) FROM DUAL;
-------------------------------------------------------------------------------
/*
    TRUNC
    위치 지정 가능한 버림 처리해주는 함수
    TRUNC(NUMBER, [NUMBER])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
-----------------------------------------------------------------------------------
/*
    날짜 처리 함수
    SYSDATE : 시스템 날짜 및 시간 반환
    MONTHS_BETWEEN(DATE, DATE) : 두 날짜 사이의 개월수
    ADD_MONTHS(DATE, NUMBER) : 특정날짜에 해당 숫자만큼의 개월수 더해서 반환
    NEXT_DAY (DATE, 요일) : 해당 날짜 이후에 가장 가까운 요일의 날짜를 반환
    LAST_DAY(DATE) : 해당월의 마지막 날짜를 반환
*/
SELECT SYSDATE FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, FLOOR (SYSDATE-HIRE_DATE) || '일' AS "근무일수", CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "근무개월수"
FROM EMPLOYEE;

SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS "수습기간 끝난 날짜"
FROM EMPLOYEE;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '화요일') FROM DUAL;

SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE AS "입사한 월에 근무일수"
FROM EMPLOYEE;

/*
    EXTRACT : 특정날짜로부터 년도 | 월 | 일 값을 추출해서 반환하는 함수
    EXTRACT(YEAR FROM DATE) : 년도만 추출
    EXTRACT(MONTH FROM DATE) : 월만 추출
    EXTRACT(DAY FROM DATE) : 일만 추출
*/
-- 사원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME,
EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",
EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
ORDER BY "입사년도", "입사월", "입사일";
-------------------------------------------------------------
/*
    형변환 함수
    TO_CHAR : 숫자, 날짜 타입의 값을 문자타입으로 변환시켜주는 함수
    TO_CHAR(숫자|날짜, [포맷])
*/
-- 숫자타입 => 문자타입
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

-- 1990년 02월 06일 형식으로
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"')
FROM EMPLOYEE;

-- 년에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DDD'),
        TO_CHAR(SYSDATE, 'DD'),
         TO_CHAR(SYSDATE, 'D')
FROM DUAL;

-- 요일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
-----------------------------------------------------------------------
/*
    TO_DATE : 숫자타입 또는 문자타입 데이터를 날짜 타입으로 변환시켜주는 함수
    
    TO_DATE(숫자|문자, [포맷])
*/
SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL;
SELECT TO_DATE('070101') FROM DUAL; -- 첫글자가 0인 경우에는 무조건 문자타입으로 변경해야함

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 2098 => 무조건 현재 세기로 반영

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;
-- RR : 해당 두자리 년도 값이 50미안일 경우 현재세기 반영 <=> 50이상일 경우 이전세기 반영

-- 웹상에서 날짜의 데이터를 넘겨도 무조건 문자로 넘어옴

-------------------------------------------------------------------------------
/*
    TO_NUMBER : 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    TO_NUMBER(문자, [포맷])
*/
SELECT TO_NUMBER('0124894513898') FROM DUAL;
SELECT '1000000' + '55000' FROM DUAL;
--SELECT '1,000,000' + '55,000' FROM DUAL; 숫자만 있어야함

SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('55,000', '99,999') FROM DUAL;
------------------------------------------------------------------------------------------
/*
     NULL 처리 함수
     NVL(컬럼, 해당 컬럼값이 NULL일 경우 반환할 값)
     NVL2(컬럼, 반환값1, 반환값2) : 컬럼값이 존재할 경우 반환값1 반환
                                 컬럼값이 NULL일 경우 반환값2 반환
     NULLIF(비교대상1, 비교대상2) : 두 개의 값이 일치하면 NULL 반환
                                  두 개의 값이 일치하지 않으면 비교대상1 값을 반환
*/
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 이름, 보너스포함 연봉
SELECT EMP_NAME, BONUS, (SALARY+SALARY*BONUS)*12, (SALARY+SALARY*NVL(BONUS, 0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE, '부서없음')
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '부서있음', '부서없음')
FROM EMPLOYEE;

SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;
------------------------------------------------------------------------------------
/*
    < 선택 함수>
    DECODE(비교하고자하는 대상, 비교값1, 결과값1, 비교값2, 결과값2, ...)
    => SWITCH랑 비슷함
*/
-- 사번, 사원명, 주민번호
SELECT EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS "성별"
FROM EMPLOYEE;

-- 직원의 급여 조회시 각 직급별로 인상해서 조회
-- J7인 사원은 급여를 10%인상 (SALARY * 1.1)
-- J8인 사원은 급여를 15% 인상 (SALARY * 1.15)
-- J5인 사원은 그병를 20% 인상 (SALARY * 1.2)
-- 그 왜의 사원은 급여 5% 인상 (SALARY * 1.05)

-- 사원명,직급코드, 기존급여, 인상된급여
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE (JOB_CODE, 'J7', SALARY * 1.1, 
                   'J6', SALARY * 1.5, 
                   'J5', SALARY * 1.2,
                   SALARY * 1.05) AS "인상된 급여"
FROM EMPLOYEE;
-------------------------------------------------------------------------------------
/*
    CASE WHEN THEN
    
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         ...
         ELSE 결과값N
    END
*/
SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY >= 5000000 THEN '고급개발자'
             WHEN SALARY >= 3500000 THEN '중급개발자'
             ELSE '초급개발자'
        END AS "레벨"
FROM EMPLOYEE;
-----------------------------------------------------------------
/*
    그룹 함수
    1. SUM(숫자타입컬럼) : 해당 컬럼 값들의 총 합계를 구해서 반환해주는 함수
    2. AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환
    3. MIN(여러타입) : 해당 컬럼값들 중에 가장 작은 값 구해서 반환
    4. MAX(여러타입) : 해당 컬럼값들 중에 가장 큰 값 구해서 반환
    5. COUNT(*|칼람|DISTINCT) : 조회된 행 개수를 세서 반환
       COUNT(*) : 조회된 결과의 모든 행 개수를 세서 반환
       COUNT(컬럼) : 제시한 해당 컬럼값이 NULL이 아닌 것만 행 개수를 세서 반환
       COUNT(DISTINCT 컬럼) : 해당 컬럼값 중복 제거한 후 행 개수 세서 반환
*/

-- 전체 사원의 초 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 전체 사원이 한 그룹으로 묶임

-- 남자 사원들의 초 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); -- 남자사원들이 한 그룹으로 묶임

-- 부서코드가 D5인 사원들의 총 연봉합(보너스미포함)
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 전체사원의 평균 급여 조회
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM employee; -- 전체 사원수

SELECT COUNT(BONUS)
FROM EMPLOYEE; -- 보너스를 받는 사원 수(NULL아닌 사람만)

SELECT COUNT(BONUS)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('1', '3'); -- 남자 사원 중 보너스를 받는 사원 수

-- 부서배치를 받은 사원 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE; --현재 사원들이 몇개의 부서에 분포되어있는지(중복 제거)