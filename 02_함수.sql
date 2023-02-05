-- 함수(FUNCTION) : 칼럼 값을 읽어서 계산한 결과를 리턴한다.
-- 단일행(SINGLE ROW)함수 : 컬럼에 기록 된 N개의 값을 읽어서 N개의 결과를 리턴
-- 그룹 (GROUP)함수 : 컬럼에 기록 된 N개의 값을 읽어서 한 개의 결과를 리턴

-- 따라서 SELECT절에 단일행 함수와 그룹 함수를 함께 사용할 수 없다.
-- 결과 행의 갯수가 다르다.

-- 그룹 함수 : SUM, AVG, MAX, MIN, COUNT
-- SUM(숫자가 기록된 컬럼명) : 합계를 구하여 리턴
SELECT 
       SUM(SALARY)
  FROM EMPLOYEE;
  
-- AVG(숫자가 기록된 컬럼명) : 평균을 구하여 리턴
SELECT 
       AVG(SALARY)
  FROM EMPLOYEE;
  
-- MAX(컬럼명) : 컬럼에서 가장 큰 값 리턴, 취급하는 자료형은 ANY TYPE
SELECT 
       MAX(EMAIL)
     , MAX(HIRE_DATE)
     , MAX(SALARY)
  FROM EMPLOYEE;
  
-- MIN(컬럼명) : 컬럼에서 가장 작은 값을 리턴, 취급하는 자료형은 ANY TYPE
SELECT 
       MIN(EMAIL)
     , MIN(HIRE_DATE)
     , MIN(SALARY)
  FROM EMPLOYEE;
  
-- COUNT(* | 컬럼명) : 행의 갯수를 헤아려서 리턴한다
-- COUNT([DISTINCT] 컬럼명) : 중복을 제거한 행 갯수 리턴
-- COUNT(*) : NULL을 포함한 전체 행 갯수 리턴
-- COUNT(컬럼명) : NULL을 제외한 실제 값이 기록 된 행 갯수 리턴
SELECT 
       COUNT(*)
     , COUNT(DEPT_CODE)
     , COUNT(DISTINCT DEPT_CODE)
  FROM EMPLOYEE;

-- 단일행 함수
-- 문자 관련 함수
-- : LENGTH, LENGTHB, SUBSTR, UPPER, LOWER, INSTR...
SELECT
       LENGTH('오라클')
     , LENGTHB('오라클')
  FROM DUAL;

SELECT
       LENGTH(EMAIL)
     , LENGTHB(EMAIL)
  FROM EMPLOYEE;
  
-- INSTR('문자열' | 컬럼명, '문자', 찾을 위치의 시작값, [빈도])
SELECT
       EMAIL
     , INSTR(EMAIL, '@', -1) 위치
  FROM EMPLOYEE; 
  
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;  
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;
  
-- LPAD / RPAD : 주어진 컬럼 문자열에 임의의 문자열을 덧붙여
--               길이 N의 문자열을 반환하는 함수
SELECT
       LPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;
  
SELECT
       RPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;  

SELECT
       LPAD(EMAIL, 10)
  FROM EMPLOYEE;

SELECT
       RPAD(EMAIL, 10)
  FROM EMPLOYEE;

-- LTRIM / RTRIM : 주어진 컬럼이나 문자열 왼쪽/오른쪽에서
--                 지정한 문자 혹은 문자열을 제거한 나머지를 반환하는 함수이다.
SELECT LTRIM('   GREEDY') FROM DUAL;
SELECT LTRIM('   GREEDY', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123GREEDY', '123') FROM DUAL;
SELECT LTRIM('132123GREEDY123', '123') FROM DUAL;
SELECT LTRIM('ACABACGREEDY', 'ABC') FROM DUAL;
SELECT LTRIM('5782GREEDY', '0123456789') FROM DUAL;

SELECT RTRIM('GREEDY   ') FROM DUAL;
SELECT RTRIM('GREEDY   ', ' ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('GREEDY123123', '123') FROM DUAL;
SELECT RTRIM('123123GREEDY123', '123') FROM DUAL;
SELECT RTRIM('GREEDYACABAC', 'ABC') FROM DUAL;
SELECT RTRIM('GREEDY5782', '0123456789') FROM DUAL;

-- TRIM : 주어진 컬럼이나 문자열의 앞/뒤에 지정한 문자를 제거
SELECT TRIM('   GREEDY   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치로부터 지정한 갯수의 문자열을
--          잘라서 리턴하는 함수이다.
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

-- 직원들의 주민번호를 조회하여 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다
SELECT
       EMP_NAME AS 사원명
     , SUBSTR(EMP_NO,1, 2) AS 생년
     , SUBSTR(EMP_NO,3, 2) "생월"
     , SUBSTR(EMP_NO,5, 2) "생일"
  FROM EMPLOYEE;
  
-- 날짜 데이터에서도 사용할 수 있다.
-- 직원들의 입사일에서도 입사년도, 입사월, 입사 날짜로 분리하여 조회
SELECT
       EMP_NAME 이름
     , HIRE_DATE 
     , SUBSTR(HIRE_DATE,1, 2) 입사년도
     , SUBSTR(HIRE_DATE,4, 2) 입사월
     , SUBSTR(HIRE_DATE,7, 2) "입사 날짜"
  FROM EMPLOYEE;

-- WHERE절에서도 함수를 사용할 수 있다.
-- EMP_NO를 통해 성별을 판단하여 여성 직원들의 모든 칼럼 정보를 조회한다.
SELECT
       *
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO,8, 1 ) = '2';
 
-- WHERE절에는 단일행 함수만 사용 가능하다.
SELECT 
       *
  FROM EMPLOYEE
 WHERE AVG(SALARY) > 100;
 
-- 함수 중첩 사용 가능 : 함수 안에서 함수를 사용할 수 있다.
-- 사원명, 주민번호 조회, 주민번호는 생년월일만 보이게 하고 '-' 다음의 값은 '*'로 바꿔 출력.
SELECT
       EMP_NAME
     , RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*')
  FROM EMPLOYEE;
-- 사원명, 이메일, 이메일의 @ 이후를 제외한 아이디 조회
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
  FROM EMPLOYEE;
  
-- SUBSTRB : 바이트 단위로 추출하는 함수
SELECT 
       SUBSTR('ORACLE', 3, 2)
     , SUBSTRB('ORACLE', 3, 2)
  FROM DUAL;
  
SELECT 
       SUBSTR('오라클', 2, 2)
     , SUBSTRB('오라클', 4, 6)
  FROM DUAL;  

-- LOWER / UPPER / INITCAP : 대소문자 변경해주는 함수
-- LOWER(문자열 | 컬럼) : 소문자로 변경해주는 함수
SELECT
       LOWER('Welcome To My World')
  FROM DUAL;

-- UPPER(문자열 | 컬럼) : 대문자로 변경해주는 함수
SELECT
       UPPER('Welcome To My World')
  FROM DUAL;

-- INITCAP(문자열 | 컬럼) : 앞 글자만 대문자로 변경해주는 함수
SELECT
       INITCAP('welcome to my world')
  FROM DUAL;

-- CONCAT : 문자열 혹은 컬럼 두 개를 입력 받아 
--          하나로 합친 후 리턴
SELECT
       CONCAT('가나다라', 'ABCD')
  FROM DUAL;

SELECT
       '가나다라' || 'ABCD'
  FROM DUAL;

-- REPLACE : 컬럼 혹은 문자열을 입력 받아 변경하고자 하는 문자열을
--           변경하려고 하는 문자열로 바꾼 후 리턴
SELECT
       REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동')
  FROM DUAL;

-- 숫자 처리 함수 : ABS, MOD, ROUND, FLOOR, TRUNC, CEIL
-- ABS(숫자 | 숫자로 된 컬럼명) : 절대값 구하는 함수
SELECT
       ABS(-10)
     , ABS(10)
  FROM DUAL;

-- MOD(숫자 | 숫자로 된 컬럼명, 숫자 | 숫자로 된 컬럼명)
-- : 두 수를 나누어서 나머지를 구하는 함수
--   처음 인자는 나누어지는 수, 두 번째 인자는 나눌 수
SELECT 
       MOD(10, 5)
     , MOD(10, 3)
  FROM DUAL;
  
-- ROUND(숫자 | 숫자로 된 컬럼명, [위치]) 
-- : 반올림해서 리턴하는 함수
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-- FLOOR(숫자 | 숫자로 된 컬럼명) : 내림처리하는 함수
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(숫자 | 숫자로 된 컬럼명, [위치]) : 내림처리(절삭) 함수
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL(숫자 | 숫자로 된 컬럼명) : 올림 처리 함수
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

SELECT
       ROUND(123.456)
     , FLOOR(123.456)
     , TRUNC(123.456)
     , CEIL(123.456)
  FROM DUAL;
  
-- 날짜 처리 함수
-- SYSDATE : 시스템이 저장 되어 있는 날짜를 반환하는 함수
SELECT SYSDATE  FROM DUAL;

-- MONTHS_BETWEEN(날짜, 날짜) : 두 날짜의 개월 수 차이를 숫자로 리턴
SELECT
       EMP_NAME
     , HIRE_DATE
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) 
  FROM EMPLOYEE;
  
-- ADD_MONTHS(날짜, 숫자) : 날짜에 숫자만큼 개월 수 더해서 날짜로 리턴
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;
  
-- 근무년수가 20년 이상인 직원의 모든 컬럼 조회
SELECT
       *
  FROM EMPLOYEE
-- WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
 WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;
 
-- NEWT_DAY(기준날짜, 요일(문자 | 숫자)) : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
-- 숫자는 1~7이며 일요일부터 시작한다.
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;

-- 시스템 환경에 따라 언어 설정되어 있으므로 변경을 원하면 설정을 변경해서 사용한다.
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY(날짜) : 해당 월의 마지막 날짜를 구하여 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- 사원명, 입사일, 입사한 월의 근무일수(주말 포함)
SELECT 
       EMP_NAME
     , HIRE_DATE
     , LAST_DAY(HIRE_DATE) - HIRE_DATE +1 "입사월의 근무일수"
  FROM EMPLOYEE;
  
-- EXTRACT : 년, 월, 일 정보를 추출하여 리턴하는 함수
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 일만 추출
SELECT 
       EXTRACT(YEAR FROM SYSDATE) 년도
     , EXTRACT(MONTH FROM SYSDATE) 월
     , EXTRACT(DAY FROM SYSDATE) 일
  FROM DUAL;
  
-- 직원의 이름, 입사일, 근무년수 조회
-- 근무년수는 현재년도 - 입사년도로 조회한다.
SELECT
       EMP_NAME
     , HIRE_DATE
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
  FROM EMPLOYEE;

-- 근무년수를 만으로 계산하는 경우에는 월의 차이를 계산해야 한다
SELECT
       EMP_NAME
     , HIRE_DATE
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) "만 근무년수"
  FROM EMPLOYEE;
-- 형변환 함수 ------------------------------------------------------------------
-- TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자형 데이터로 변경 ---------------------
-- TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자형 데이터로 변경
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, '00000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, '00,000') FROM DUAL;
SELECT TO_CHAR(1234, '999') FROM DUAL;

-- 직원 테이블에서 사원명, 급여 조회
-- 급여는 '\9,000,000' 형식으로 표시하세요
SELECT
      EMP_NAME
     ,TO_CHAR(SALARY, 'L99,999,999')
     FROM EMPLOYEE;

-- 날짜 데이터 포맷 적용 시에도 TO_CHAR 함수 사용
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
  FROM EMPLOYEE;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 입사일
  FROM EMPLOYEE;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') 상세입사일
  FROM EMPLOYEE;

-- 오늘 날짜에 대해 년도 4자리, 년도 2자리,
-- 년도 이름으로 출력
SELECT
       TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'RRRR')
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RR')
     , TO_CHAR(SYSDATE, 'YEAR')
  FROM DUAL;

-- RR과 YY의 차이
-- RR은 두자리 년도를 네자리로 바꿀 때 바꿀 년도가 50년 미만이면 2000년을 적용하고
-- 50년 이상이면 1900년을 적용한다.
-- YY는 년도를 바꿀 때 현재 세기(2000년)를 적용한다.

SELECT
       TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYRR-MM-DD')
  FROM DUAL; 

SELECT
       TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD')
  FROM DUAL; 
  
-- 오늘 날짜에서 월만 출력
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
  FROM DUAL;
  
-- 오늘 날짜에서 일만 출력
SELECT
       TO_CHAR(SYSDATE, '"1년 기준 " DDD"일 째"')
     , TO_CHAR(SYSDATE, '"달 기준 " DD"일 째"')
     , TO_CHAR(SYSDATE, '"주 기준 " D"일 째"')
  FROM DUAL;
  
-- 오늘 날짜에서 분기와 요일 출력 처리
SELECT
       TO_CHAR(SYSDATE, 'Q"분기"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;
  
-- EMPLOYEE 테이블에서 이름, 입사일 조회
-- 입사일 포맷은 '2018년 6월 15일 (수)' 형식으로 출력 처리 하세요
SELECT
      EMP_NAME
     ,TO_CHAR(HIRE_DATE, 'YYYY"년" FMMM"월" DD"일" (DY)')
     FROM EMPLOYEE;
     
-- TO_DATE : 문자 혹은 숫자형 데이터를 날짜형 데이터로 변환하여 리턴 ------------------
-- TO_DATE(문자형데이터, [포맷]) 
-- TO_DATE(숫자형데이터, [포맷])
SELECT
       TO_DATE('20100101', 'RRRRMMDD')
  FROM DUAL;

SELECT
       TO_CHAR(TO_DATE('20100101', 'RRRRMMDD'), 'RRRR, MON')
  FROM DUAL;
  
SELECT
       TO_DATE('041030 143000', 'RRMMDD HH24MISS')
  FROM DUAL;

SELECT
       TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
  FROM DUAL;

-- EMPLOYEE 테이블에서 2000년도 이후에 입사한 사원의
-- 사번, 이름, 입사일을 조회하세요
SELECT
       EMP_ID
      ,EMP_NAME
      ,HIRE_DATE
      FROM EMPLOYEE
-- WHERE HIRE_DATE >= TO_DATE('20000101', 'RRRRMMDD');
  WHERE HIRE_DATE >= '20000101'; -- 문자열은 날짜로 자동 형변환 된다
--WHERE HIRE_DATE >= TO_DATE(20000101, 'RRRRMMDD');
-- WHERE HIRE_DATE >= 20000101; -- 숫자는 날짜로 자동 형변환 되지 않는다
-- TO_NUMBER(문자데이터, [포맷]) : 문자 데이터를 숫자로 리턴 ------------------------
SELECT TO_NUMBER('123456789') FROM DUAL;

-- 자동형변환
SELECT '123' + '456' FROM DUAL;
-- 숫자로 된 문자열만 가능하다
SELECT '123' + '456A' FROM DUAL;

SELECT
       EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE HIRE_DATE = '90/02/06';   -- 자동 형변환

-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT
       *
  FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2) = 1; -- 자동 형변환

SELECT '1,000,000' + '500,000' FROM DUAL;

SELECT 
       TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999')
  FROM DUAL;

-- 직원 테이블에서 사원번호가 201인 사원의 이름, 주민번호 앞자리, 주민번호 뒷자리,
-- 주민번호 앞자리와 뒷자리의 합을 조회하세요. 단, 자동 형변환 사용하지 않고 조회
SELECT
       EMP_NAME
     , EMP_NO
     , SUBSTR(EMP_NO, 1,6) 앞자리
     , SUBSTR(EMP_NO, 8) 뒷자리
     , TO_NUMBER(SUBSTR(EMP_NO, 1,6)) + TO_NUMBER(SUBSTR(EMP_NO, 8)) 결과
 FROM EMPLOYEE
 WHERE EMP_ID = TO_CHAR(201);
 
 
-- NULL 처리 함수 -------------------------------------------------
-- NVL(컬럼명, 컬럼값이 NULL일때 바꿀 값)
SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
  FROM EMPLOYEE;
  
-- NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼이 값이 있으면 바꿀값1로 변경, 해당 컬럼이 NULL이면 바꿀값2로 변경

-- 보너스 포인트가 NULL인 직원은 0.5로 보너스 포인트가 NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT
       EMP_NAME
     , BONUS
     , NVL2(BONUS, 0.7, 0.5)
  FROM EMPLOYEE;

-- 선택함수 : 여러 가지 경우 선택할 수 있는 기능을 제공
-- DECODE(계산식 | 컬럼명, 조건값1, 선택값1, 조건값2, 선택값2 ...)

-- 성별을 구분하여 '남' 또는 '여'로 조회
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여')
  FROM EMPLOYEE;

-- 마지막 인자로 조건 값 없이 선택 값을 작성하면 아무런 조건에 해당하지 않을 때
-- 마지막에 작성한 선택 값을 무조건 선택한다.
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '여') 성별
  FROM EMPLOYEE;
  
-- 직원의 급여를 인상하고자 한다.
-- 직급 코드가 J7인 직원의 급여는 10%, J6인 직원은 15%, J5인 직원은 20%를 인상하고
-- 그 외 직급의 직원은 5%만 인상한다. 직원명, 직급코드, 급여, 인상급여(위 조건) 조회
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                              SALARY * 1.05)
  FROM EMPLOYEE;

/*
       CASE
         WHEN 조건식 THEN 결과값
         WHEN 조건식 THEN 결과값
         ELSE 결과값
        END
*/        

-- 급여가 500만원을 초과하면 '고급'. 300~500 사이면 '중급', 그 이하는 '초급'으로 출력
-- 처리하고 별칭은 '구분'으로 한다.
SELECT
       EMP_NAME
     , SALARY
     , CASE
        WHEN SALARY > 5000000 THEN '고급'
        WHEN SALARY BETWEEN 3000000 AND 5000000 THEN '중급'
        ELSE '초급'
    END 구분
  FROM EMPLOYEE;  



