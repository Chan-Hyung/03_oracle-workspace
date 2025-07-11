/*
    < SELECT >
    데이터 조회할 때 사용되는 구문
    >> RESULT SET : SELECT문을 통해 조회된 결과물(즉, 조회된 행들의 집합)
    
    (표현법)
    SELECT 조회하고자 하는 컬럼1, 컬럽2, ... FROM 테이블명;
    
    * 반드시 존재하는 컬럼을 써야함, 없는 컬럼을 쓰면 오류발생
*/

-- EMPLOYEE 테이블의 모든 컬럼 조회
-- SELECT EMP_ID, EMP_NAME, ...
SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT * FROM JOB;

--------------------------- 실습 문제 ---------------------------
-- 1. JOB 테이블의 직급명만 조회
SELECT job_name FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT * FROM department;

-- 3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT dept_id, dept_title from department;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT emp_name, email, phone, hire_date, salary from employee;


/*
    < 컬럼값을 통한 산술 연산 >
    select절 컬럼명 작성 산술연산 기술 가능(이때, 산술연산된 결과 조회)
*/

-- employee 테이블의 사원명, 사원의 연봉(급여 * 12) 조회
SELECT emp_name, salary*12 FROM employee;

-- employee 테이블의 사원명, 급여, 보너스 조회
SELECT emp_name, salary, bonus from employee;

-- employee 테이블의 사원명, 급여, 보너스, 연봉, 보너스포함된연봉((급여 + 급여 * 보너스) * 12 ) 조회
select emp_name, salary, salary, bonus, salary*12, ((salary+salary*bonus)*12) from employee;
--> 산술 연산 과정중 null 값이 존재할 경우 산술연산한 결과값 마저도 무조건 null로 나옴.

-- employee 사원명, 입사일
select emp_name, hire_date from employee;

-- employee에 사원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식끼리 연산 가능
-- 오늘날짜 : SYSDATE
SELECT emp_name, hire_date, sysdate - hire_date from employee;
-- date - date : 결과값은 일 단위가 맞음
-- 단, 값이 지저분한 이유는 date 형식은 년/월/일/시/분/초 단위로 시간정보까지도 관리를 하기 때문

-----------------------------------------------------------------------------
/*
    < 컬럼명에 별칭 지정하기 >
    산술연산을 하게 되면 컬럼명 지저분한데, 이때 컬럼명으로 별칭 부여해서 깔금하게 보임

    (표현법)
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    AS는 붙이든 안붙이든간에 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 ""으로 기술해야함
    (없으면 AS 빼도 됨)
*/

SELECT emp_name 사원명, salary AS 급여, salary * 12 "연봉(원)", ((salary + salary * bonus)*12) AS "*총소득(보너스)"from employee;
-------------------------------------------------------------------------------------------------------------
/*
    < 리터럴 >
    임의로 지정한 문자열('')
    
    SELECT절에 리터럴을 제시하면 마치 테이블에 존재하는 데이터처럼 조회 가능
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위" FROM EMPLOYEE;

/*
    <연결 연산자 : ||>
    여러 컬럼값들을 마치 하나의 컬럼인 것 처럼 연결, 컬럼값과 리터럴 값을 연결할 수 있음
    
    System.out.oprintln("num의 값 : " + num); => 에서 +와 같은 역할
*/

-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY FROM EMPLOYEE;

-- 컬럼값과 리터럴을 연결
-- XXX의 월급은 XXX원 입니다.

SELECT EMP_ID || '의 월급은' || SALARY || '원 입니다.' AS "급여정보" FROM EMPLOYEE;
---------------------------------------------------------------------
/*
    < DISTINCT >
    컬럼에 중복된 값들을 한번씩만 표시하고자 할 때 사용
*/
-- 현재 우리 회사에 어떤 직급의 사람들이 존재하는지 궁금
SELECT JOB_CODE FROM EMPLOYEE;

-- EMPLOYEE에 직급코드(중복제거)조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE; -- NULL 아직 부서배치가 안된 사람

-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE;
--> 유의사항 : DISTINCT 한 번만 쓸 수 있음.

SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;

-- -------------------------------------------------------------------------

/*
    <WHERE 절>
    조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
    이때 WHERE절에는 조건식을 제시하게 됨
    조건식에서는 다양한 연산자들 사용 가능
    
    (표현법)
    SELECT 컬럼1, 컬럼2, ... 
    FROM 테이블명
    WHERE 조건식;
    
    (비교 연산자)
    >, <, >=, <=     ----> 대소비교
    =                ----> 동등비교
    !=, ^=, <>       ----> 비동등 비교
*/

-- EMPLOYEE 에서 ㅜ서코드가 'D9'인 사원들만 조회 (이때, 모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- MEPLOYEE 에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- 제직 중(ENT_YN = 'N')인 사원들의 사번, 이름, 입사일
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

------------------------------------- 실습 문제 ----------------------------------
-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스미포함) 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12
FROM EMPLOYEE
WHERE salary >= 3000000;

-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY*12 AS "연봉", DEPT_CODE -- 3
FROM EMPLOYEE -- 보는 순서 1
WHERE SALARY*12 >= 50000000; -- 2 (WHERE 절에서는 SELECT절에서 작성한 별칭 사용 불가)
--WHERE 연봉 >= 50000000;
-- 쿼리 실행순서
-- FROM 절 => WHERE 절 => SELECT절

-- 3. 직급코드가 'J3'이 아닌 사람들의 사번, 사원명, 직급코드, 회사여부 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE ^= 'J3';

-- 부서코드가 'D9' 이면서 급여가 500만원 이상인 사원들의 사번, 사원명, 급여, 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6' 이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 코드
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상 ~ 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;
------------------------------------------------------------------
/*
    <BETWEEN A AND B>
    조건식에서 사용되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
    
    (표현법)
    비교대상컬럼 BETWEEN A(값) AND B(값)
    => 해당 걸럼값이 A이상이고 B이하인 경우
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000 ;

-- 위의 쿼리 범위 밖의 사람들 조회하고자 한다면?
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR salary >6000000;
WHERE /*NOT*/ SALARY NOT BETWEEN 3500000 AND 6000000 ;
--> NOT : 논리부정연산자
-- 컬럼명 앞 또는 뒤에 해도 가능

-- 입사일 '90/01/01' = '01/01/01'
SELECT *
FROM EMPLOYEE
-- WHERE hire_date >= '90/01/01' AND HIRE_DATE <='01/01/01';
WHERE hire_date BETWEEN '90/01/01' AND '01/01/01';

-----------------------------------------------------------------
/*
    < LIKE >
    비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    (표현법)
    비교대상컬럼 LIKE '특정패턴'
    
    - 특정 패턴 제시시 '%', '_' 와일드카드로 쓸 수 있다.
    >>'%' : 0글자 이상
    EX) 비교대상컬럼 LIKE '문자%'; => 비교대상의 컬럼값이 문자로 "시작"되는걸 조회
        비교대상컬럼 LIKE '%문자' => 비교대상의 컬럼값이 문자로 "끝"나는걸 조회
        비교대상 컬럼 LIKE '%문자%' => 비교대상의 컬럼값에 문자가 "포함"되는걸 조회
        
    >>'_' : 1글자 이상
    EX) 비교대상컬럼 LIKE '_문자' => 비교 대상의 컬럼 값에 문자앞에 무조건 한 글자가 올 경우 조회
        비교대상컬럼 LIKE '__문자' => 비교 대상의 컬럼 값에 문자앞에 무조건 두 글자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_' => 비교 대상의 컬럼 값에 문자 앞과 뒤에 무조건 한 글자씩 올 경우 조회
*/

-- 사원들 중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름중에 하가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 하인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM MEPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의  3번째 자리가 1인 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM employee
WHERE PHONE LIKE '__1%';

-- 특이케이스
-- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___%'; -- 원했던 결과 안 나옴
-- 와일드카드로 사용하고 있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 출력 X
--> 어떤게 와일드 카드고 어떤게 데이터 값인지 구분 지워야함
--> 데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드카드를 제시하고, ESCAPE OPTION으로 등록해야함.

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%'ESCAPE '$';

--------------------------- 실습 문제 ---------------------------------------
-- 1. EMPLOYEE에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE  LIKE '010%';

-- 3. EMPLOYEE에서 이름에 '하'가 포함되어 있고 급여가 240만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

-- 4. DEPARTMENT 에서 해외영업부인 부서들 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
where dept_title like '해외영업%';
---------------------------------------------------------------
/*
    < IS NULL / IS NOT NULL >
    컬럼값에 NULL이 있을 경우 NULL 값 비교에 사용 되는 연산자
*/

-- 보너스를 받지 않는 사원(BONUS 값이 NULL)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL; => SQL은 = NULL로 쓸 수 없다.
WHERE BONUS IS NULL;

-- 보너스를 받지 사원(BONUS 값이 NULL이 아닌)들의 사번, 이름 , 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS != NULL;  => != 연산자를 쓸 수 없다.
-- WHERE NOT BONUS NOT NULL; => 가능 &
WHERE BONUS IS NOT NULL;
-- NOT은 컬럼명 앞 또는 IS 뒤에서 사용 가능

-- 사수가 없는 사원(MANAGER_ID 값이 NULL)들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서배치를 아직 받지는 않았지만 보너스는 받는 사원들의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-------------------------------------------------------------------
/*
    < IN >
    비교대상컬럼값이 내가 제시한 목록중에 일치하는 값이 있는지
    
    (표현법)
    비교대상컬럼 IN ('값1', '값2', ...);  
*/

-- 부서코드가 D6이거나 D8이거나 D5인 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 그 외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE NOT DEPT_CODE IN ('D6', 'D8', 'D5'); 가능하고 &
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5'); 

------------------------------------------------------------------------
/*
    < 연산자 우선순위 >
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL / IN NOT NULL / LIKE '특정패턴' / IN
    5. BETWEEN A AND B
    6. NOT (논리부정연산자)
    7. AND (논리연산자)
    8. OR (논리연산자)
*/

-- 직급코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR  JOB_CODE = 'J2') AND SALARY >= 2000000;
-- OR보다 AND가 먼저 연산되어 이상하게 실행되기 때문에 괄호를 해줘야한다.

--------------------------------------------------------------------------------------
-- 1. 사수가 없고 부서배치도 받지 않은 사원들의 (사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. 연봉(보너스미포함)이 3000만원 이상이고 보너스를 받지 않는 사원들의 (사번, 사원명, 급여, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000 AND BONUS IS NULL;

-- 3. 입사일이 '95/01/01' 이상이고 부서배치를 받은 사원들의 (사번, 사원명, 입사일, 부서코드) 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. 급여가 200만원 이상 500만원 이하이고 입사일이 '01/01/01' 이상이고 보너스를 받지 않는 사원들의
-- (사번, 사원명, 급여, 입사일, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 5000000) AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. 보너스 포함 연봉이 NULL이 아니고 이름에 '하'가 포함되어 있는 사원들의 (사번, 사원명, 급여, 보너스포함 연봉) 조회(별칭부여)
SELECT EMP_ID AS "코드", EMP_NAME AS "이름", SALARY AS "급여", (SALARY+ SALARY * BONUS)*12 AS "보너스 포함 연봉"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL AND EMP_NAME LIKE '%하%';

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE IS NULL;

-------------------------------------------------------------------
/*
    < ORDER BY 절 >
    구문에서 가장 마지막줄에 작성하고 실행순서 또한 마지막에 실행됨

    (표현법)
    SELECT 조회할 컬럼, 컬럼2, ...
    FROM EMPLOYEE
    WHERE 조건식
    ORDER BY 정렬하고 싶은 컬럼 | 별칭 | 컬럼순번 [ASC|DESC] [오름차순|내림차순, NULLS FIRST|NULLS LAST]
    - ASC : 오름차순 정렬(생략시 기본값)
    -DESC : 내림차순 정렬
    - NULLS FIRST : 정렬하고자 하는 값에 NULL이 있을 경우 해당 데이터를 맨 앞에 배치 (생략시 DESC일때의 기본값)
    - NULLS LAST : 정렬하고자 하는 값에 NULL이 있을 경우 해당 데이터를 맨 뒤에 배치 (생략시 ASC 일때의 기본값)
*/

SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS;
-- ORDER BY BONUS ASC; -- 오름차순 정렬 일 때 기본적으로 NULLS LAST
-- ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC; -- 내림차순 정렬 일때는 기본적으로 NULLS FIRST
ORDER BY BONUS DESC, SALARY ASC; -- 정렬기준 여러개 제시 가능(첫 번째 기준의 컬럼값이 동일한 경우 두 번째 기준 컬럼가지고 정렬)

-- 전체 사원의 사원명, 연봉 조회 (이때 연봉별 내림차순 정렬조회)
SELECT EMP_NAME, SALARY*12 AS "연봉"
FROM  EMPLOYEE
-- ORDER BY SALARY*12 DESC;
-- ORDER BY 연봉 DESC; -- 실생 순서때문에 별칭 사용 가능
ORDER BY 2 DESC; -- 컬럼 순번 사용 가능( 컬럼 개수보다 큰 숫자 안됨)


































