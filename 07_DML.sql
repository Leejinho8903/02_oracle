-- DML(Data Manupluation Language)
-- INSERT, UPDATE, DELETE
-- : 데이터 조작 언어. 테이블에 값을 삽입하거나 수정하거나 삭제하거나 조회하는 언어

-- INSERT : 새로운 행을 추가하는 구문이다. 테이블의 행 갯수가 증가한다.
-- [표현식]
-- 테이블의 일부 컬럼에 INSERT일 때
-- INSERT INTO 테이블명 (컬럼명, 컬럼명, ...)VALUES (데이터, 데이터,...);

-- 테이블의 모든 컬럼에 INSERT할 때
-- INSERT INTO 테이블명 VALUES (데이터, 데이터, ...);

-- 하지만 모든 컬럼에 INSERT할 떄도 컬럼명을 기술 하는 것이 의미 파악에는 더 좋다.
INSERT
    INTO EMPLOYEE
(
  EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE,
  DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, BONUS,
  MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
)
VALUES
(
 '900', '장채헌', '901123-2080503', 'jang_ch@greedy.com' , '01012345784',
 'D1', 'J7', 'S3', 4300000, 0.2,
 '200', SYSDATE, NULL, DEFAULT
);

-- INSERT시에 VALUES 대신 서브 쿼리를 이용할 수 있다.
CREATE TABLE EMP_01 (
 EMP_ID NUMBER,
 EMP_NAME VARCHAR2(30),
 DEPT_TITLE VARCHAR2(20)
 );
 
INSERT 
  INTO EMP_01
(
  EMP_ID
, EMP_NAME
, DEPT_TITLE
)
(
  SELECT
         EMP_ID
        ,EMP_NAME
        ,DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    );
    
SELECT
        E.*
  FROM EMP_01 E;

-- INSERT ALL : INSERT시에 사용하는 서브 쿼리가 같은 경우 두 개 이상의 테이블에
-- INSERT ALL을 이용하여 한 번에 데이터를 삽입할 수 있다.
-- 단, 서브쿼리의 조건절이 같아야 한다.
CREATE TABLE EMP_DEPT_D1
AS
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE 1 = 0;
 
SELECT
        ED.*
  FROM EMP_DEPT_D1 ED;

CREATE TABLE EMP_MANAGER
AS
SELECT
       EMP_ID
     , EMP_NAME
     , MANAGER_ID
  FROM EMPLOYEE
 WHERE 1 = 0;

SELECT
        EM.*
  FROM EMP_MANAGER EM;
  
-- EMP_DEPT_D1 테이블에 부서코드가 D1인 직원을 조회해서
-- 사번,이름,소속부서, 입사일을 삽입하고
-- EMP_MANAGER 테이블에 부서코드가 D1인 직원을 조회해서
-- 사번, 이름, 관리자 사번을 삽입한다.
INSERT ALL
  INTO EMP_DEPT_D1
VALUES
(
  EMP_ID
, EMP_NAME
, DEPT_CODE
, HIRE_DATE
)
INTO EMP_MANAGER
VALUES
(
  EMP_ID
, EMP_NAME
, MANAGER_ID
)
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , HIRE_DATE
      , MANAGER_ID
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1';

-- 입사일 기준으로 2000년 1월 1일 전에 입사한 사원의 사번, 이름, 입사일, 급여를 조회하여
-- EMP_OLD 테이블에 삽입하고 그 이후에 입사한 사원은 EMP_NEW 테이블에 삽입
CREATE TABLE EMP_OLD
AS
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
     , SALARY
  FROM EMPLOYEE
  WHERE 1 = 0;
CREATE TABLE EMP_NEW
AS
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
     , SALARY
  FROM EMPLOYEE
 WHERE 1 = 0;
 
INSERT ALL 
 WHEN HIRE_DATE < '2000/01/01'
 THEN 
 INTO EMP_OLD
VALUES
(
  EMP_ID
, EMP_NAME
, HIRE_DATE
, SALARY
)
 WHEN HIRE_DATE >= '2000/01/01'
 THEN
 INTO EMP_NEW
 VALUES
(
  EMP_ID
, EMP_NAME
, HIRE_DATE
, SALARY
)
SELECT
        EMP_ID
      , EMP_NAME
      , HIRE_DATE
      , SALARY
  FROM EMPLOYEE;

SELECT
        EO.*
  FROM EMP_OLD EO;

SELECT
        EN.*
  FROM EMP_NEW EN;
  
-- UPDATE : 테이블에 기록 된 컬럼의 값을 수정하는 구문이다.
-- 테이블의 전체 행 갯수는 변화가 없다.
-- [표현식]
-- UPDATE 테이블명 SET 컬럼명 = 바꿀값, 컬럼명 = 바꿀값, ...
-- [WHERE 컬럼명 비교연산자 비교값];
CREATE TABLE DEPT_COPY
AS
SELECT D.*
  FROM DEPARTMENT D;
  
SELECT
        DC.*
  FROM DEPT_COPY DC;

UPDATE 
        DEPT_COPY
  SET DEPT_TITLE = '전략기획팀'
  WHERE DEPT_ID = 'D9';

-- UPDATE시에도 서브쿼리를 사용할 수 있다.
-- UPDATE 테이블명 SET 컬럼명 = (서브쿼리)
-- 평상시 유재식 사원을 부러워하던 방명수 사원의 급여와 보너스율을 유재식 사원과 동일하게
-- 변경해주기로 했다. UPDATE 구문 작성.
CREATE TABLE EMP_SALARY
AS
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , SALARY
      , BONUS
  FROM EMPLOYEE;

UPDATE
        EMP_SALARY
  SET SALARY = (SELECT
                        SALARY
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '유재식'
                    )
    , BONUS = (SELECT
                        BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '유재식'
                    )
 WHERE EMP_NAME = '방명수';
 
-- 다중열 서브쿼리로 수정한다.
UPDATE
        EMP_SALARY
  SET (SALARY,BONUS) = (SELECT
                              SALARY
                            , BONUS 
                          FROM EMP_SALARY
                         WHERE EMP_NAME = '유재식'
                    )  
 WHERE EMP_NAME = '방명수';

SELECT
      ES.*
  FROM EMP_SALARY ES;

-- EMP_SALARY 테이블에서 아시아 근무 지역에 근무하는 직원의 보너스를 0.5로 변경하는
-- UPDATE 구문 작성, WHERE에서 다중행 서브쿼리를 사용하며 조건을 알아올 때는
-- EMPLOYEE, DEPARTMENT, LOCATION 테이블 그대로 사용
UPDATE
        EMP_SALARY ES
  SET ES.BONUS = 0.5
  WHERE ES.EMP_ID IN(SELECT
                       E1.EMP_ID
                FROM EMPLOYEE E1
                JOIN DEPARTMENT D1 ON(E1.DEPT_CODE = D1.DEPT_ID)
                JOIN LOCATION L1 ON(D1.LOCATION_ID = L1.LOCAL_CODE)
                WHERE L1.LOCAL_NAME LIKE 'ASIA%'
                );  
 
-- UPDATE시 변경 값은 해당 컬럼에 대한 제약 조건에 위배되지 않아야 한다.

-- EMPLOYEE 테이블의 DEPT_CODE에 외래키 제약조건 추가
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);

-- DEPARTMETN 테이블의 DEPT_ID로서 존재하지 않는 값으로 UPDATE 할 수 없다.
-- 무결성 제약 조건을 위배한다 (부모가 없음)
UPDATE 
       EMPLOYEE
  SET DEPT_CODE = '20'
 WHERE DEPT_CODE = 'D6';
 
-- NOT NULL 제약 조건 위배
UPDATE
        EMPLOYEE
  SET EMP_NAME = NULL
 WHERE EMP_ID = '200';

-- DELETE : 테이블의 행을 삭제하는 구문이다. 테이블의 행의 갯수가 줄어든다
-- DELETE FROM 테이블명 WHERE 조건
-- 만약 WHERE절의 조건을 설정하지 않으면 모든 행이 다 삭제 된다.
COMMIT;

DELETE 
  FROM EMPLOYEE;

SELECT
       E.*
  FROM EMPLOYEE E;
  
ROLLBACK;

DELETE 
  FROM EMPLOYEE
 WHERE EMP_NAME = '장채헌';

-- FK 제약 조건이 설정 되어 있는 경우 참조 되고 있는 값에 대해서는 삭제 불가
-- 기본 삭제 룰이 삭제 제한으로 설정 되어 있기 때문
DELETE
  FROM DEPARTMENT
 WHERE DEPT_ID = 'D1';
-- FK 제약 조건이 설정 되어 있어도 참조 되고 있지 않은 값에 대해서는 삭제 가능
DELETE
  FROM DEPARTMENT
 WHERE DEPT_ID = 'D3';
 
SELECT 
      D.*
  FROM DEPARTMENT D ;

ROLLBACK;

-- TRUNCATE : 테이블의 전체 행을 삭제할 시 사용한다.
--            DELETE보다 수행 속도가 더 빠르며 ROLLBACK을 통해 복구 할 수 없다.
SELECT
       ES.*
  FROM EMP_SALARY ES;

COMMIT;

DELETE
  FROM EMP_SALARY;

SELECT
       ES.*
  FROM EMP_SALARY ES;

ROLLBACK;

SELECT
       ES.*
  FROM EMP_SALARY ES;

TRUNCATE TABLE EMP_SALARY;
         
SELECT
       ES.*
  FROM EMP_SALARY ES;  

ROLLBACK;

SELECT
       ES.*
  FROM EMP_SALARY ES;  
  
-- MERGE : 구조가 같은 두 개의 테이블을 하나로 합치는 기능을 한다.
--         테이블에서 지정하는 조건의 값이 존재하면 UPDATE
--         조건의 값이 없으면 INSERT됨
CREATE TABLE EMP_M01
AS
SELECT E.* 
  FROM EMPLOYEE E;
  
CREATE TABLE EMP_M02
AS
SELECT E.*
  FROM EMPLOYEE E
 WHERE E.JOB_CODE = 'J4';

INSERT
  INTO EMP_M02 A
(
  A.EMP_ID, A.EMP_NAME, A.EMP_NO, A.EMAIL, A.PHONE
, A.DEPT_CODE, A.JOB_CODE, A.SAL_LEVEL, A.SALARY, A.BONUS
, A.MANAGER_ID, A.HIRE_DATE, A.ENT_DATE, A.ENT_YN
)
VALUES
(
  999, '우별림', '000101-4567890', 'woo_bl@greedy.com', '01011112222'
, 'D9', 'J4', 'S1', 9000000, 0.5
, NULL, SYSDATE, NULL, DEFAULT
);

SELECT
       EM1.*
  FROM EMP_M01 EM1;
 
SELECT
       EM2.*
  FROM EMP_M02 EM2; 
 
UPDATE
       EMP_M02
   SET SALARY = 0;

MERGE
 INTO EMP_M01 M1
USING EMP_M02 M2
   ON (M1.EMP_ID = M2.EMP_ID)
 WHEN MATCHED THEN
UPDATE
   SET M1.EMP_NAME = M2.EMP_NAME
     , M1.EMP_NO = M2.EMP_NO
     , M1.EMAIL = M2.EMAIL
     , M1.PHONE = M2.PHONE
     , M1.DEPT_CODE = M2.DEPT_CODE
     , M1.JOB_CODE = M2.JOB_CODE
     , M1.SAL_LEVEL = M2.SAL_LEVEL
     , M1.SALARY = M2.SALARY
     , M1.BONUS = M2.BONUS
     , M1.MANAGER_ID = M2.MANAGER_ID
     , M1.HIRE_DATE = M2.HIRE_DATE
     , M1.ENT_DATE = M2.ENT_DATE
     , M1.ENT_YN = M2.ENT_YN
 WHEN NOT MATCHED THEN
INSERT
(
  M1.EMP_ID, M1.EMP_NAME, M1.EMP_NO, M1.EMAIL, M1.PHONE
, M1.DEPT_CODE, M1.JOB_CODE, M1.SAL_LEVEL, M1.SALARY, M1.BONUS
, M1.MANAGER_ID, M1.HIRE_DATE, M1.ENT_DATE, M1.ENT_YN
)
VALUES
(
  M2.EMP_ID, M2.EMP_NAME, M2.EMP_NO, M2.EMAIL, M2.PHONE
, M2.DEPT_CODE, M2.JOB_CODE, M2.SAL_LEVEL, M2.SALARY, M2.BONUS
, M2.MANAGER_ID, M2.HIRE_DATE, M2.ENT_DATE, M2.ENT_YN
);

SELECT
       EM.*
  FROM EMP_M01 EM;

