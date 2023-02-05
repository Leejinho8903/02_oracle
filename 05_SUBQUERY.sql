-- SUBQUERY

-- 부서 코드가 노옹철 사원과 같은 소속의 직원 명단 조회

-- 사원명이 노옹철인 사람의 부서 조회
SELECT
       DEPT_CODE
 FROM EMPLOYEE
 WHERE EMP_NAME = '노옹철';

-- 부서코드가 D9인 직원 조회
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';

-- 위의 두 쿼리를 하나로 작성한다.
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT  
                            DEPT_CODE
                       FROM EMPLOYEE
                      WHERE EMP_NAME = '노옹철');


-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번,이름,직급코드,급여조회
SELECT 
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
 FROM EMPLOYEE
 WHERE SALARY> (SELECT
                        AVG(SALARY)
                       FROM EMPLOYEE);
                       

-- 서브쿼리의 유형
-- 단일행,다중행,다중열,다중행 다중열 서브쿼리
-- 서브쿼리의 유형에 따라 서브쿼리 앞에 붙는 연산자가 다르다.
-- 단일행 서브쿼리는 앞에 일반 비교 연산자를 사용한다.
-- >, <, >=, <=, =, !=/^=/<>

-- 노옹철 사원의 급여보다 많이 받는 직원의 사번,이름,부서,직급,급여 조회
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (SELECT SALARY
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '노옹철');
-- 가장 적은 급여를 받는 직원의 사번, 이름, 부서, 직급, 급여 조회
SELECT 
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
 FROM EMPLOYEE
 WHERE SALARY = (SELECT
                        MIN(SALARY)
                       FROM EMPLOYEE);
                       
-- HAVING절에서 사용 되는 경우
-- 부서별 급여의 합계 중 합계가 가장 큰 부서의 부서명, 급여 합계를 조회
SELECT
       DEPT_TITLE
     , SUM(SALARY)
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT 
                            MAX(SUM(SALARY))
                           FROM EMPLOYEE
                          GROUP BY DEPT_CODE);

-- 다중행 서브쿼리
-- 다중행 서브쿼리 앞에는 일반 비교 연산자를 사용할 수 없다.
-- IN/ NOT IN
-- > ANY / < ANY : 여러 개의 결과 값 중에서도 한 개라도 큰 | 작은 경우
-- > ALL / < ALL : 모든 값 보다 큰 | 작은 경우
-- EXIST / NOT EXIST : 서브쿼리에만 사용하는 연산자로 값이 존자하는가? | 존재하지않는가?

-- 부서별 최고 급여를 받는 지원의 이름, 직급, 부서, 급여 조회
SELECT
       EMP_NAME
     , JOB_CODE
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (SELECT
                        MAX(SALARY)
                       FROM EMPLOYEE
                    GROUP BY DEPT_CODE);
                    
-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의
-- 사번,이름,직급명,급여를 조회
SELECT
       EMP_NAME
     , JOB_NAME
     , SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  WHERE JOB_NAME = '과장';

SELECT
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , SALARY
  FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '대리'
   AND SALARY > ANY (SELECT
                              SALARY
                         FROM EMPLOYEE
                         JOIN JOB USING(JOB_CODE)
                            WHERE JOB_NAME = '과장');
                            
-- 차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의
-- 사번, 이름, 직급명, 급여를 조회
SELECT 
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , SALARY
  FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '과장'
   AND SALARY > ALL(SELECT
                                 SALARY
                            FROM EMPLOYEE
                            JOIN JOB USING(JOB_CODE)
                            WHERE JOB_NAME = '차장');
                            
-- 다중열 서브쿼리
-- 퇴직한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름,직급,부서,입사일 조회
SELECT
       EMP_NAME
     , JOB_CODE
     , DEPT_CODE
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO,8,1) ='2'
                       AND ENT_YN = 'Y')
  AND JOB_CODE = (SELECT
                         JOB_CODE
                    FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO,8,1) = '2'
                     AND ENT_YN = 'Y');
                     
-- 다중열 서브쿼리로 변경한다.
SELECT
       EMP_NAME
     , JOB_CODE
     , DEPT_CODE
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE (DEPT_CODE,JOB_CODE) = (SELECT
                                     DEPT_CODE
                                   , JOB_CODE
                                 FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO,8,1) ='2'
                                  AND ENT_YN = 'Y');
  
-- FROM 절에서 서브쿼리 사용
-- 서브쿼리의 결과(RESULT SET)을 테이블 대신 사용할 수 있다.
-- 인라인 뷰(INLINE VIEW)라고도 한다.

-- 인라인뷰로 직급별 평균 급여를 계산한 테이블을 만들고 EMPLOYEE와 JOIN시
-- 평균 급여가 본인의 급여와 동일하면 조인하게 조건을 줘서
-- 직급별 평균 급여에 맞는 급여를 받고 있는 직원을 조회하는 구문
SELECT 
       E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
  FROM (SELECT
                 JOB_CODE
               , TRUNC(AVG(SALARY), -5) AS JOBAVG
            FROM EMPLOYEE
           GROUP BY JOB_CODE) V
    JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND V.JOB_CODE = E. JOB_CODE)
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    ORDER BY J.JOB_NAME;
    
-- 인라인뷰 사용 시 유의할 점
-- 인라인뷰의 결과만이 남아 있으므로 서브쿼리에서 조회에 사용하지 않은 컬럼은
-- 조회할 수 없으며 별칭을 사용했다면 해당 별칭으로 조회해야 한다.
SELECT
       EMP_NAME
     , 부서명
     , 직급명
  FROM (SELECT
                EMP_NAME
              , DEPT_TITLE AS 부서명
              , JOB_NAME AS 직급명
            FROM EMPLOYEE
            LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
            JOIN JOB USING(JOB_CODE))
    WHERE 부서명 = '인사관리부';
    
-- 인라인뷰를 사용한 TOP-N 분석
-- ORDER BY한 결과에 ROWNUM을 붙힌다. (ROWNUM은 행 번호를 의미)

-- SALARY 기준 내림차순 정렬
-- 현재는 WHERE절에서 ROWNUM이 결정되어 급여를 많이 받는 순서와 관계없는 번호를 가진다.
SELECT
       ROWNUM
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 ORDER BY SALARY DESC;
-- 따라서 원하는 순서에 ROWNUM이 붙게 하려면 인라인뷰를 활용해야 한다.
SELECT
       ROWNUM
     , V.EMP_NAME
     , V.SALARY
  FROM (SELECT E.*
          FROM EMPLOYEE E
         ORDER BY E.SALARY DESC) V
         WHERE ROWNUM <= 5;
         
-- 6위에서 10위 까지 조회         
-- WHERE절에서 ROWNUM은 1로 시작하고 해당 값이 FALSE가 되어 다음 행을 확일할 때 다시 1로 확인하여
-- 모든 행이 6~10사이라는 조건을 만족할 수 없어 결과가 0행이 된다.
SELECT
       ROWNUM
     , V.EMP_NAME
     , V.SALARY
  FROM (SELECT E.*
          FROM EMPLOYEE E
         ORDER BY E.SALARY DESC) V
         WHERE ROWNUM BETWEEN 6 AND 10;
    
-- 6위에서 10위까지 조회
SELECT 
        V2.RNUM
      , V2.EMP_NAME
      , V2.SALARY
  FROM (SELECT
                ROWNUM RNUM
              , V.EMP_NAME
              , V.SALARY
            FROM (SELECT E.*
                    FROM EMPLOYEE E 
                    ORDER BY E.SALARY DESC) V) V2
                    WHERE RNUM BETWEEN 6 AND 10;
                    
-- STOPKEY 사용
SELECT 
        V2.RNUM
      , V2.EMP_NAME
      , V2.SALARY
  FROM (SELECT
                ROWNUM RNUM
              , V.EMP_NAME
              , V.SALARY
            FROM (SELECT E.*
                    FROM EMPLOYEE E 
                    ORDER BY E.SALARY DESC) V
                    WHERE ROWNUM < 11
                    )V2
                    WHERE RNUM BETWEEN 6 AND 10;
                    
-- 급여 평균(10만원 단위에서 절삭) 3위 안에 드는 부서의 부서코드,부서명,평균 급여 조회
SELECT
       V.DEPT_CODE
     , V.DEPT_TITLE
     , V.평균급여
  FROM (SELECT
               E.DEPT_CODE
             , D.DEPT_TITLE
             , ROUND(AVG(E.SALARY),0) 평균급여
          FROM EMPLOYEE E
          JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
          GROUP BY E.DEPT_CODE, D.DEPT_TITLE
          ORDER BY ROUND(AVG(E.SALARY),0) DESC
          ) V
          WHERE ROWNUM <= 3;
          
-- RANK() : 동일한 순위 이후의 등수를 동일한 인원수만큼 건너 뛰고 다음 순위 계산
-- DENSE_RANK() : 중복되는 순위 이후의 등수를 이후 등수로 처리
SELECT
        EMP_NAME
      , SALARY
      , RANK() OVER(ORDER BY SALARY DESC) 순위
  FROM EMPLOYEE;

SELECT
        EMP_NAME
      , SALARY
      , DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
  FROM EMPLOYEE;
-- SALARY 기준 순위 5위까지 조회
SELECT
       V.*
  FROM (SELECT
        EMP_NAME
      , SALARY
      , RANK() OVER(ORDER BY SALARY DESC) 순위
  FROM EMPLOYEE) V
  WHERE V.순위 <= 5;
  
-- 보너스를 포함한 연봉 순위 5위까지의 사번,이름,부서명,직급명,입사일 조회
SELECT
         V.EMP_ID
       , V.EMP_NAME
       , V.DEPT_TITLE
       , V.JOB_NAME
       , V.HIRE_DATE
  FROM (SELECT
                E.EMP_ID
              , E.EMP_NAME
              , D.DEPT_TITLE
              , J.JOB_NAME
              , E.HIRE_DATE
              , (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12
              , RANK() OVER(ORDER BY (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 DESC) 순위
          FROM EMPLOYEE E
          JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
          JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
          ) V
          WHERE V.순위 < 6;

-- WITH 이름 AS (쿼리문)
-- 서브쿼리에 이름을 붙여주고 사용할 경우 붙여준 이름으로 재사용 할 수 있다.
-- 인라인뷰로 사용 될 서브쿼리에서 이용되며 같은 서브쿼리가 여러번 사용 될 경우
-- 중복해서 작성하지 않아도 되고, 실행 속도도 빨라진다는 장점이 있다.
 WITH
      TOPN_SAL
     AS (SELECT
                E.EMP_ID
              , E.EMP_NAME
              , E.SALARY
           FROM EMPLOYEE E
          ORDER BY E.SALARY DESC)
SELECT 
        ROWNUM
      , T.EMP_NAME
      , T.SALARY
  FROM TOPN_SAL T;
  
-- 상[호연]관 서브쿼리
-- 일반적으로는 서브쿼리가 만든 결과 값을 메인 쿼리가 비교 연산한다.
-- 상관 서브쿼리는 메인 쿼리가 사용하는 테이블의 값을 서브쿼리가 이용해서 결과를 만든다.
-- 메인 쿼리 테이블의 값이 변경 되면, 서브쿼리의 결과 값도 바뀌게 된다.

-- 관리자 사번이 EMPLOYEE 테이블에 존재하는 직원의 대한 조회
SELECT 
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.MANAGER_ID
  FROM EMPLOYEE E
  WHERE EXISTS (SELECT
                        E2.EMP_ID
                  FROM EMPLOYEE E2
                  WHERE E.MANAGER_ID = E2.EMP_ID);
                  
-- 스칼리 서브쿼리
-- 단일행 서브쿼리 + 상관 쿼리

-- 동일 직급의 급여 평균보다 급여를 많이 받고 있는 직원의 직원명, 직급코드, 급여조회
SELECT 
       EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE E
  WHERE SALARY > (SELECT
                        TRUNC(AVG(E2.SALARY),-5)
                    FROM EMPLOYEE E2
                    WHERE E.JOB_CODE = E2.JOB_CODE);

-- 모든 사원의 사번, 이름, 관리자 사번, 관리자명을 조회
-- SELECT절에서 스칼라 서브쿼리 사용예제
-- SELECT 절에서 서브쿼리 사용시 결과 값은 반드시 1행으로 나와야 함(스칼라 서브쿼리만 사용 가능)
SELECT
        EMP_ID
      , EMP_NAME
      , MANAGER_ID
      , NVL((SELECT EMP_NAME
                FROM EMPLOYEE E2
                WHERE E.MANAGER_ID = E2.EMP_ID
                ),'없음') 관리자명
    FROM EMPLOYEE E
    ORDER BY 1;