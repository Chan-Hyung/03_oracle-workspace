/*
     < 시퀀스 SEQUENCE >
     자동으로 번호 발생시켜주는 역할을 하는 객체
     정수 값을 순차적으로 일정값씩 증가시면서 생성(기본적으로 1씩 증가)
     
     EX) 사원번호, 회원번호, 게시글번호 등 절대 겹쳐서는 안되는 데이터들
*/
/*
    1. 시퀀스 객체 생성
    표현식
    CREATE SEQUENCE 시퀀스명
    
    (상세 표현식)
    CREATE SEQUENCE 시퀀스명
    [START WITH 시작숫자]  -- 처음 발생시킬 시작값 지정 (기본값 1)
    [INCREMENT BY 숫자]   -- 몇씩 증가시킬건지 (기본값 1)
    [MAXVALUE 숫자]       -- 최댓값 지정 (기본값 큼)
    [MINVALUE 숫자]       -- 최소값 지정 (기본값 1) => 최댓값 찍고 처음부터 다시 돌아와서 시작하게 할 수 있음
    [CYCLE / NOCYCLE]    -- 값 순환 여부 지정 (기본값 NOCYCLE)
    [NOCACHE / CACHE 바이트 크기] -- 캐시메모리 할당 (기본값 CACHE 20)
    
    - 캐시 메모리 : 임시저장 공간
                  미리 발생될 값들을 생성해서 저장해두는 공간
                  매번 호출될 때마다 새로이 번호를 생성하는게 아니라
                  캐시 메모리 공간에 미리 생성된 값들을 가져다 쓸 수 잇음(속도가 빨라짐)
                  접속이 해제되면 => 캐시메모리에 미리 만들어 둔 번호들은 날라감
                  번호 일정하게 부여 안될 수 있으니 확인을 잘 해야함   
*/
CREATE SEQUENCE SEQ_TEST;

-- 오라클이 가지고 있는 기본 SEQUENCE
SELECT * FROM USER_SEQUENCES;

-- 상세 옵션
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. 시퀀스 사용
    시퀀스명.CURRVAL : 현재 시퀀스 값(마지막으로 성공적으로 수행된 NEXTVAL의 값)
    시퀀스명.NEXTVAL : 시퀀스 값에 일정 값을 증가시켜서 발생된 값
                      현재시퀀스 값에서 INCREMENT BY 값만큼 증가된 값
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
-- *Action:   select NEXTVAL from the sequence before selecting CURRVAL 

-- SELECT 여러번 치면 안됨
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 마지막으로 성공한 NEXTVAL 값

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305(증가값5 => INCREMENT BY 5)
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 지정한 MAXVALUE값(MAXVALUE 310)을 초과했기 때문에 오류 발생
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

/*
    3. 시퀀스 구조 변경
    ALTER SEQUENCE 시퀀스명
    [INCREMENT BY 숫자]   -- 몇씩 증가시킬건지 (기본값 1)
    [MAXVALUE 숫자]       -- 최댓값 지정 (기본값 큼)
    [MINVALUE 숫자]       -- 최소값 지정 (기본값 1) => 최댓값 찍고 처음부터 다시 돌아와서 시작하게 할 수 있음
    [CYCLE / NOCYCLE]    -- 값 순환 여부 지정 (기본값 NOCYCLE)
    [NOCACHE / CACHE 바이트 크기] -- 캐시메모리 할당 (기본값 CACHE 20)
    
    ● START WITH 변경 불가
*/
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320(증가값 변경 => INCREMENT BY 10)

-- 4. 시퀀스 삭제
DROP SEQUENCE SEQ_EMPNO;
---------------------------------------------------------------------------------------------------

-- 사원번호로 활용할 시퀀스 생성
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
    , '홍길동'
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
    , '홍길순'         -- ?
    , '990101-2222222'-- ?
    , 'J6'            -- ?
    , 'S1'            -- ?
    , SYSDATE
    );
-- 나중에 저렇게 해서 자바랑 연동해서 값을 넣을거임




















































































