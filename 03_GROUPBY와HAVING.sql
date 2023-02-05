-- GROUP BY 와 HANING

/* 순서
    5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
    1 : FROM 참조할 테이블명
    2 : WHERE 컬럼명 | 함수식 비교 연산자 비교값
    3 : GROUP BY 그룹을 묶을 컬럼명
    4 : HAVING 그룹 함수식 비교연산자 비교값
    6 : ORDER BY 컬럼명 | 별칭 | 컬럼순법 정렬방식 [NULLS FIRST | LAST]
*/

-- DETP_CODE 기준으로 그루핑
SELECT
       COUNT(*)
     , DEPT_CODE
  FROM EMPLOYEE
 GROUP BY DEPT_CODE;

-- GROUP BY절 : 같은 값들이 여러 개 기록 된 컬럼을 가지고 같은 값들을 하나의 그룹으로 묶는다.
-- GROUP BY 컬럼명 | 함수식 ...
-- 그룹으로 묶은 값에 대해서 SELECT 절에서 그룹 함수를 사용한다.

-- 부서별 급여 합계, 평균(정수처리), 인원수 조회 후 부서코드 순 오름차순 정렬
SELECT 
       DEPT_CODE 부서
     , SUM(SALARY) 합계
     , ROUND (AVG(SALARY)) 평균
     , COUNT(*) 인원수
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
  ORDER BY DEPT_CODE;
-- ORDER BY 부서;
-- ORDER BY 1 DESC NULLS LAST;

-- 직급 코드별로 보너스를 받는 사원수를 조회하고 직급 코드 오름차순 정렬
SELECT
       JOB_CODE
     , COUNT(BONUS)
  FROM EMPLOYEE
 GROUP BY JOB_CODE
 ORDER BY JOB_CODE;
 
-- 직급 코드별로 보너스를 받는 사원수를 조회하고 직급 코드 오름차순 정렬
-- 단, 보너스를 받는 사람이 없는 직급 코드의 경우 RESULT SET에서 제외
SELECT
       JOB_CODE
     , COUNT(BONUS)
  FROM EMPLOYEE
 WHERE BONUS IS NOT NULL
 GROUP BY JOB_CODE 
 ORDER BY JOB_CODE;
 
-- GROUP BY절에 하나 이상의 그룹을 지정할 수 있다.
-- DEPT_CODE, JOB_CODE 기준으로 그루핑
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , COUNT(*)
  FROM EMPLOYEE
 GROUP BY DEPT_CODE
        , JOB_CODE
 ORDER BY 1;
 
-- GROUP BY절에서 함수식을 사용할 수 있다.
-- 성별 그룹으로 급여 평균(정수 처리), 합계, 인원수를 조회한 뒤 인원수로 내림차순 정렬
SELECT
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') AS 성별
     , ROUND(AVG(SALARY)) 평균
     , SUM(SALARY) 합계
     , COUNT(*) 인원수
  FROM EMPLOYEE
 GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여')
-- GROUP BY 성별 (SELECT절의 별칭을 사용할 수 없다. 아직 SELECT 절은 수행되지 않았다.)
 ORDER BY 인원수 DESC; --ORDER BY 절은 마지막에 수행 되므로 SELECT절 별칭 사용 가능
 
-- HAVING절 : 그룹 함수로 구해올 그룹에 대해 조건을 설정할 떄 사용한다.
-- HAVING 컬럼명 | 함수식 비교연산자 비교값

-- 300만원 이상의 월급을 받는 사원들을 대상으로 부서별 월급 평균 계산

-- 모든 직원을 대상으로 부서별 월급 평균을 구한 뒤 평균이 300만원 이상인 부서 조회
SELECT
       DEPT_CODE
     , ROUND(AVG(SALARY)) 평균
  FROM EMPLOYEE
 WHERE SALARY >= 3000000
 GROUP BY DEPT_CODE
 ORDER BY 1;
 
-- 모든 직원을 대상으로 부서별 월급 평균을 구한 뒤 평균이 300만원 이상인 부서 조회
SELECT
       DEPT_CODE
     , ROUND(AVG(SALARY)) 평균
  FROM EMPLOYEE
HAVING ROUND (AVG(SALARY)) > = 3000000
 GROUP BY DEPT_CODE
 ORDER BY 1;
 
-- 집계 함수 : GROUP BY 절에서만 사용하는 함수--------------------------

-- ROLLUP, CUBE : 그룹별로 중간 집계 처리를 하는 함수
-- 그룹별로 묶인 값에 대한 중간 집계와 총 집계를 구할 때 사용
SELECT 
       JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(JOB_CODE)
 ORDER BY 1;
 
SELECT 
       JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY CUBE(JOB_CODE)
 ORDER BY 1; 

-- ROLLUP 함수는 인자로 전달한 그룹 중 가낭 먼저 지정한 그룹별 합계와 총 합계를 구하는 함수
SELECT 
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY ROLLUP(DEPT_CODE,JOB_CODE)
 ORDER BY 1;
-- CUBE 함수는 그룹으로 지정 된 모든 그룹에 대한 집계와 총 합계를 구하는 함수
SELECT 
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
  FROM EMPLOYEE
 GROUP BY CUBE(DEPT_CODE,JOB_CODE)
 ORDER BY 1;

-- GROUPING 함수 : ROLLUP이나 CUBE에 의한 산출물이 인자로 전달 받은 컬럼 집하의
-- 산출물이면 0을 반환하고, 아니면 1을 반환하는 함수
SELECT
       DEPT_CODE
     , JOB_CODE
     , SUM(SALARY)
     , COUNT(*)
     , GROUPING(DEPT_CODE) "부서별 그룹 묶인 상태"
     , GROUPING(JOB_CODE) "직급별 그룹 묶인 상태"
  FROM EMPLOYEE
 GROUP BY CUBE(DEPT_CODE, JOB_CODE)
 ORDER BY 1;
 
SELECT
       NVL(DEPT_CODE, '부서없음')
     , JOB_CODE
     , SUM(SALARY)
     , CASE
         WHEN GROUPING(NVL(DEPT_CODE, '부서없음')) = 0 AND GROUPING(JOB_CODE) = 1 THEN '부서별합계'
         WHEN GROUPING(NVL(DEPT_CODE, '부서없음')) = 1 AND GROUPING(JOB_CODE) = 0 THEN '직급별합계'
         WHEN GROUPING(NVL(DEPT_CODE, '부서없음')) = 0 AND GROUPING(JOB_CODE) = 0 THEN '그룹별합계'
         ELSE '총합계'
       END 구분
  FROM EMPLOYEE
 GROUP BY CUBE(NVL(DEPT_CODE, '부서없음'), JOB_CODE)
 ORDER BY 1;

-- SET OPEARTION(집합 연산)-----------------------------------------
-- UNION : 여러 개의 쿼리 결과를 하나로 합치는 연산자
-- 중복 된 영역을 제외하여 하나로 합친다.
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;     
 
-- UNION ALL : 여러 개의 쿼리를 하나로 합치는 연산자
-- UNION과의 차이는 중복 영역을 모두 포함시킨다는 것이다.

SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 UNION ALL
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;  

-- INTERSECT : 여러 개의 SELECT한 결과에서 공통 부분만 결과로 추출
-- 수학에서 교집합과 유사하다.

SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;  
 
-- MINUS : 선행 SELECT 결과에서 후행 SELECT 결과와 겹치는 부분을 제외한 나머지만 추출
-- 수학에서 차집합과 유사하다.

SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
 MINUS
SELECT 
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > 3000000;  
 
-- GROUPING SET : 그룹별로 처리 된 여러 개의 SELECT문을 하나로 합칠 때 사용한다.
-- SET OPERATION과 결과 동일하다.
SELECT
       DEPT_CODE
     , JOB_CODE
     , MANAGER_ID
     , FLOOR(AVG(SALARY))
  FROM EMPLOYEE
 GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID)
                     ,  (DEPT_CODE, MANAGER_ID)
                     ,  (JOB_CODE, MANAGER_ID)
                     );