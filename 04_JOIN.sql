-- JOIN : 두 개 이상의 테이블을 하나로 합쳐서 결과를 조회

-- 오라클 전용 구문
-- FROM절에 ','로 구분하여 합치게 될 테이블명을 기술하고 WHERE절에 합치기에 사용할
-- 컬럼명을 명시한다.

-- 연결에 사용할 두 컬럼명이 다른 경우
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
-- 연결에 사용할 두 컬럼명이 같은 경우
-- 테이블명을 지정하지 않으면 열의 정의가 애매하다는 오류가 발생한다.
SELECT 
        EMP_ID
      , EMPLOYEE.EMP_NAME
      , EMPLOYEE.JOB_CODE
      , JOB.JOB_NAME
  FROM  EMPLOYEE
      , JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 테이블명에 별칭을 사용해서 수정한다.
SELECT 
        EMP_ID
      , E.EMP_NAME
      , E.JOB_CODE
      , J.JOB_NAME
  FROM  EMPLOYEE E
      , JOB J
 WHERE E.JOB_CODE = J.JOB_CODE;
 
-- ANSI 표준 구문
-- 연결에 사용할 칼럼명이 같은 경우 USING(컬럼명)을 사용한다.
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE);

-- 연결에 사용할 컬럼명이 다른 경우 ON()을 사용한다.
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
  
-- 컬럼명이 같은 경우에도 ON으로 작성할 수 있다.
SELECT
       EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , J.JOB_NAME
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
  
-- DEPARTMENT 테이블과 LOCATION 테이블을 조인하여 테이블에 있는 모든 컬럼 조회(*)
-- ORACLE 전용
SELECT
       *      
  FROM DEPARTMENT
     , LOCATION
 WHERE LOCATION_ID = LOCAL_CODE;

-- ANSI 표준
SELECT 
        *
     FROM DEPARTMENT
    JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID);
   
-- 조인은 기본이 EQUAL JOIN이다. 연결 되는 컬럼 값이 일치하는 행들만 조인이 된다.
-- 일치하는 값이 없는 행은 조인에서 제외된다. => INNER JOIN

-- OUTER JOIN : 두 테이블에서 지정하는 컬럼 값이 일치하지 않는 행도 조인에 포함시킨다.
-- 반드시 OUTER JOIN임을 명시해야 한다.
-- LEFT OUTER JOIN : 합치기에 사용한 두 테이블 중 왼편에 기술 된 테이블을 기준으로 JOIN
-- RIGHT OUTER JOIN : 합치기에 사용한 두 테이블 중 오른편에 기술 된 테이블을 기준으로 JOIN
-- FULL OUTER JOIN : 합치기에 사용한 두 테이블이 가진 모든 행을 결과에 포함하여 JOIN

-- LEFT OUTER JOIN
-- ANSI 표준
SELECT 
        EMP_NAME
      , DEPT_TITLE
  FROM EMPLOYEE
--  LEFT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); 이것도 됨
  LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);   -- 이것도 됨 

-- 오라클 전용 구문
SELECT 
        EMP_NAME
      , DEPT_TITLE
  FROM EMPLOYEE
      , DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);

-- RIGHT OUTER JOIN
-- ANSI 표준
SELECT 
        EMP_NAME
      , DEPT_TITLE
  FROM EMPLOYEE
--  RIGHT OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); 이것도 됨
  RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);   -- 이것도 됨 

-- 오라클 전용 구문
SELECT 
        EMP_NAME
      , DEPT_TITLE
  FROM EMPLOYEE
      , DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID;
 
-- FULL OUTER JOIN
-- ANSI 표준
SELECT 
        EMP_NAME
      , DEPT_TITLE
  FROM EMPLOYEE
--  FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); 이것도 됨
  FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);   -- 이것도 됨 

-- 오라클 전용 구문
-- FULL OUTER JOIN을 하지 못한다
SELECT 
        EMP_NAME
      , DEPT_TITLE
  FROM EMPLOYEE
      , DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID(+);
 
-- CROSS JOIN : 카테이션 곱이라고도 한다.
-- 조인 되는 테이블의 각 행들이 모두 매핑 된 데이터가 검색 되는 방법이다.
SELECT
        EMP_NAME
      , DEPT_TITLE
  FROM EMPLOYEE
 CROSS JOIN DEPARTMENT;
 
-- NON EQUAL JOIN
-- 지정한 컬럼의 값이 일치하는 경우가 아니라 값의 범위에 포함되는 행들을 연결하는 방식

-- ANSI 표준
SELECT 
        EMP_NAME
      , SALARY
      , E.SAL_LEVEL "EMPLOYEE의 SAL_LEVEL"
      , S.SAL_LEVEL "SAL_GRADE의 SAL_LEVEL"
  FROM EMPLOYEE E
  JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- 오라클 전용
SELECT 
        EMP_NAME
      , SALARY
      , E.SAL_LEVEL "EMPLOYEE의 SAL_LEVEL"
      , S.SAL_LEVEL "SAL_GRADE의 SAL_LEVEL"
  FROM EMPLOYEE E
      ,SAL_GRADE S
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
 
-- SELF JOIN : 같은 테이블을 조인하는 경우, 자기 자신과 조인을 맺는 것
-- 오라클 전용
SELECT 
        E1.EMP_ID
      , E1.EMP_NAME 사원명
      , E1.MANAGER_ID
      , E2.EMP_NAME 관리자명
  FROM EMPLOYEE E1
      ,EMPLOYEE E2
 WHERE E1.MANAGER_ID = E2.EMP_ID;
 
-- ANSI 표준
SELECT 
        E1.EMP_ID
      , E1.EMP_NAME 사원명
      , E1.MANAGER_ID
      , E2.EMP_NAME 관리자명
  FROM EMPLOYEE E1
  JOIN EMPLOYEE E2 ON(E1.MANAGER_ID = E2.EMP_ID);

-- 다중 JOIN : N개의 테이블을 조회할 때 사용된다.

-- ANSI 표준
-- 조인 구문 나열 순서에 유의
SELECT 
       EMP_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- 오라클 전용
-- 테이블명 서술 순서와 관계 없다.
SELECT 
       EMP_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE 
     , DEPARTMENT
     , LOCATION
 WHERE DEPT_CODE = DEPT_ID 
   AND LOCATION_ID = LOCAL_CODE;
   
-- 직급이 대리이면서 아시아 지역에 근무하는 직원의
-- 이름, 직급명, 부서명, 근무지역명 조회
-- ANSI 표준
SELECT
        EMP_NAME
      , JOB_NAME
      , DEPT_CODE
      , LOCAL_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE JOB_NAME = '대리'
   AND LOCAL_NAME LIKE 'ASIA%';
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
 FROM EMPLOYEE E 
     ,DEPARTMENT D 
     ,LOCATION L
     ,JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND J.JOB_NAME = '대리'
   AND L.LOCAL_NAME LIKE 'ASIA%';