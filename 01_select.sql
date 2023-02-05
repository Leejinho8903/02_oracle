-- SELECT 기본 문법 및 연산자

-- 모든 행, 컬럼 조회

-- 대소문자를 구분하지 않으며 코딩 컨벤션에 따라서 키워드만 대문자로 사용하는 경우도 있고
-- 모두 대문자, 모두 소문자로 사용하는 경우도 있을 수 있다.
SELECT
       *
  FROM EMPLOYEE;
  
-- 원하는 컬럼 조회
-- 사번, 이름 조회
SELECT
       EMP_ID
     , EMP_NAME
  FROM EMPLOYEE;

-- 원하는 행 조회
-- 부서 코드가 D9인 사원 조회
SELECT
        *
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
 
-- 직급 코드가 J1인 사원 조회
SELECT
       *
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J1';
 
-- 원하는 행과 컬럼 조회
--급여가 300만원 이상(>=)인 사원의 사번, 이름, 부서코드, 급여를 조회
SELECT
       EMP_ID
      ,EMP_NAME
      ,DEPT_CODE
      ,SALARY
 FROM EMPLOYEE
 WHERE SALARY >= 3000000;

-- 컬럼에 별칭 짓기
-- AS + 별칭을 기술하여 별칭을 지을 수 있다.
SELECT
       EMP_NAME AS 이름
     , SALARY * 12 "1년 급여"
     , (SALARY + (SALARY * BONUS)) * 12 AS "총 소득"
     , (SALARY + (SALARY * NVL(BONUS,0))) * 12 "총 소득"
 FROM EMPLOYEE;

-- 임의로 지정한 문자열을 SELECT절에서 사용할 수 있다.
SELECT
        EMP_ID
       ,EMP_NAME
       ,SALARY
       ,'원' AS 단위
  FROM EMPLOYEE;
  
-- DISINCT 키워드는 중복 된 컬럼 값을 제거하여 조회한다.
SELECT 
       DISTINCT JOB_CODE
  FROM EMPLOYEE;

-- DISINCT 키워드는 SELECT 절에 딱 한 번만 사용할 수 있다.
-- 여러 개의 컬럼을 묶어서 중복을 제외 시킨다.
SELECT 
       DISTINCT JOB_CODE
      ,/*DISTINCT*/ DEPT_CODE 
  FROM EMPLOYEE;
  
-- WHERE절
-- 테이블에서 조건을 만족하는 값을 가진 행을 골라낸다.
-- 여러 개의 조건을 만족하는 행을 골라 낼 떄 AND 혹은 OR을 사용할 수 있다.

-- 부서코드가 D6D이고 급여가 200만원을 초과하는 직원의
-- 이름, 부서코드, 급여 조회
SELECT
      EMP_NAME
     ,DEPT_CODE
     ,SALARY
  FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
  AND SALARY > 2000000;
  
-- NULL값 조회
-- 보너스를 지급받지 않는 사원의 사번, 이름, 급여, 보너스를 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
 FROM EMPLOYEE
 WHERE BONUS IS NULL;
 
-- NULL이 아닌 값 조회
-- 보너스를 지급받는 사원의 사번, 이름, 급여, 보너스를 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , BONUS
 FROM EMPLOYEE
 WHERE BONUS IS NOT NULL;

-- 연결 연산자를 이용하여 여러 컬럼을 하나의 컬럼인 것처럼 연결할 수 있다.(||)

-- 컬러과 컬럼의 연결
SELECT
       EMP_NAME || SALARY
  FROM EMPLOYEE;
  
-- 컬럼과 리터럴 연결
SELECT
       EMP_NAME || '의 월급은' || SALARY || '원 입니다.'
  FROM EMPLOYEE;
  
-- 비교 연산자
-- = 같다, > 크다, < 작다, >= 크거나 같다, <= 작거나 같다
-- !=, ^=, <> 같지 않다

-- 부서코드가 D9가 아닌 사원의 사번, 이름, 부서코드 조회
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
 WHERE DEPT_CODE <> 'D9';
 
-- 퇴사 여부가 N인 직원을 조회하고 근무 여부라는 별칭으로 재직중이라는 문자열을
-- 결과 집합에 포함해서 조회한다. (사번, 이름, 입사일, 근무여부 조회)
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE 
     , '재직 중' 근무여부
  FROM EMPLOYEE
 WHERE ENT_YN = 'N';

-- 급여를 350만원 이상, 550원 이하 받는 지원의
-- 이름, 부서코드, 급여 조회
SELECT 
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY >= 3500000
   AND SALARY <= 5500000;
   
-- BETWEEN AND
-- 칼럼 명 BETWEEN 하한값 AND 상한값 : 하한값 이상 상한값 이하의 값
SELECT 
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY BETWEEN 3500000 AND 5500000;
 
-- 반대로 350만원 미만, 550만원 초과하는 직원 조회
-- NOT 연산자는 컬럼명 앞, 또는 BETWEEN 연산자 앞에 붙을 수 있다.
SELECT 
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
-- WHERE NOT SALARY BETWEEN 3500000 AND 5500000;
  WHERE SALARY NOT BETWEEN 3500000 AND 5500000;
  
-- LIKE 연산자 : 문자 패턴이 일치하는 값을 조회할 때 사용
-- 컬럼명 LIKE '문자 패턴'
-- 문자 패턴 : '글자%' (글자로 시작하는 값)
--           '%글자' (글자로 끝나는 값) 
--           '%글자%'(글자가 포함 된 값)

-- 성이 김씨인 직원의 이름, 입사일 조회
SELECT
       EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '김%';
 
-- 성이 김씨가 아닌 직원의 이름, 입사일 조회
SELECT
       EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
-- WHERE NOT EMP_NAME LIKE '김%';
 WHERE EMP_NAME NOT LIKE '김%';
 
-- 하 가 이름에 포함 된 직원의 이름, 부서코드 조회
SELECT 
       EMP_NAME
     , DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '%하%';
 
-- 전화번호 국번이 9로 시작하는 직원의 이름, 전화번호 조회
-- 와일드 카드 사용 : _(글자 한 자리), %(0개 이상의 글자) 010뒤에 9로시작하는
SELECT 
       EMP_NAME
     , PHONE
  FROM EMPLOYEE
 WHERE PHONE LIKE '___9%';
 
-- 전화번호 국번이 4자리이면서 9로 시작하는 직원의 이름, 전화번호 조회
SELECT 
       EMP_NAME
     , PHONE
  FROM EMPLOYEE
 WHERE PHONE LIKE '___9_______';
 
-- 이메일에서 _앞글자가 3자리인 이메일 주소를 가진 사원의 이름, 이메일 주소 조회
SELECT
       EMP_NAME
     , EMAIL
  FROM EMPLOYEE
 WHERE EMAIL LIKE '___#_%' ESCAPE '#';
 
-- IN 연산자 : 비교하는 값 목록에 일치하는 값이 있는지 확인

-- 부서 코드가 D6이거나 D8인 직원의 이름, 부서, 급여 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D6', 'D8');
 
-- 부서 코드가 D6이거나 D8인 직원을 제외한 나머지 직원들의 이름, 부서, 급여 조회
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
-- WHERE NOT DEPT_CODE IN ('D6', 'D8');
 WHERE DEPT_CODE NOT IN ('D6', 'D8')
-- NULL 값은 NOT IN 에서 취급되지 않으므로 별도로 처리해야 한다.
    OR DEPT_CODE IS NULL;

-- 연산자 우선순위 (AND, OR)

-- J2 직급의 급여 200만원 이상 받는 직원이거나
-- J7 직급인 직원의 이름, 급여, 직급 코드 조회
SELECT
       EMP_NAME
     , SALARY
     , JOB_CODE
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J7'
    OR JOB_CODE = 'J2'
   AND SALARY >= 2000000;
-- J7 직급이거나 J2 직급인 직원들 중
-- 급여가 200만원 이상인 직원의 이름, 급여, 직급 코드 조회
SELECT
       EMP_NAME
     , SALARY
     , JOB_CODE
  FROM EMPLOYEE
 WHERE (JOB_CODE = 'J7'
    OR  JOB_CODE = 'J2')
  AND SALARY >= 2000000;
    
 