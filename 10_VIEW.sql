-- VIEW (뷰)
-- SELECT 쿼리문을 저장한 객체로 실질적인 데이터를 저장하고 있지 않은 논리적인 테이블이나
-- 테이블을 사용하는 것과 동일하게 사용할 수 있다.
-- 1) 복잡한 SELECT 문을 다시 작성할 필요가 없다.
-- 2) 민감한 데이터를 숨길 수 있다.

-- [표현식]
-- CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리;
-- [OR REPLACE] = 중복되는 뷰가 있으면 덮어쓴다.
-- 사번, 이름, 직급멱, 부서명, 근무지역을 조회하고 그 결과를 V_RESULT_EMP라는 뷰로 생성
CREATE OR REPLACE VIEW V_RESULT_EMP
AS
SELECT
        EMP_ID
      , EMP_NAME
      , JOB_NAME
      , DEPT_TITLE
      , LOCAL_NAME
  FROM EMPLOYEE E
  LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
  LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- 직원 관리 계정에는 뷰 객체 생성 권한이 부여되어 있지 않아 권한이 불충분하다는 오류가 발생
-- 시스템 계정으로 변환하여 뷰 객체 생성 권한을 부여한 뒤 작업한다.
GRANT CREATE VIEW TO C##EMPLOYEE;  /* SYSTEM 계정으로 권한을 부여받는다. */

SELECT
       V.*
  FROM V_RESULT_EMP V
 WHERE V.EMP_ID = '205';
 
-- 데이터 딕셔너리(Data Dictionary)
-- 자원을 효율적으로 관리하기 위해 다양한 정보를 저장하는 시스템 테이블
-- 사용자가 테이블을 생성하거나, 사용자를 변경하는 등의 작업을 할 때 데이터베이스 서버에
-- 의해 자동으로 갱신되는 테이블로 사용자는 데이터 딕셔너리 내용을 직접 수정하거나 삭제할 수 있다.
-- 원본 테이블을 커스터마이징 해서 보여주는 원본 테이블의 가상 테이블(VIEW)이다.

-- 뷰에 대한 정보를 확인하는 데이터 디겨너리
SELECT
        UV.*
  FROM USER_VIEWS UV;
  
-- 뷰에 별칭을 부여해서 생성
CREATE OR REPLACE VIEW V_EMP
(
  사번
, 이름
, 부서
)
AS
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
  FROM EMPLOYEE;
  
SELECT
  V.*
  FROM V_EMP V;
  
-- 뷰 삭제
DROP VIEW V_EMP;

-- 베이스 테이블에서 정보 변경
COMMIT;

UPDATE 
        EMPLOYEE
    SET EMP_NAME = '홍길동'
 WHERE EMP_ID = '200';
 
SELECT
E.*
FROM EMPLOYEE E
WHERE EMP_ID = '200';

-- 베이스테이블의 정보가 변경 되면 VIEW도 같이 변경된다
SELECT
  V.*
  FROM V_RESULT_EMP V
 WHERE EMP_ID = '200';

ROLLBACK;

DROP VIEW V_RESULT_EMP;

-- 뷰 서브쿼리 안에 연산의 결과를 포함할 수 있으며
-- 이 때는 반드시 별칭을 부여해서 생성해야 한다.
CREATE OR REPLACE VIEW V_EMP_JOB
(
  사번
, 이름
, 직급
, 성별
, 근무년수
)
AS
SELECT
        EMP_ID
      , EMP_NAME
      , JOB_NAME
      , DECODE(SUBSTR(EMP_NO, 8,1), 1, '남','여')
      , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
  FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE);
 
SELECT
       V.*
  FROM V_EMP_JOB V;
  
-- VIEW를 통한 DML 구문 동작 테스트
CREATE OR REPLACE VIEW V_JOB
AS
SELECT
        JOB_CODE
      , JOB_NAME
  FROM JOB;
  
INSERT
  INTO V_JOB
  (
   JOB_CODE
,  JOB_NAME
  )
VALUES
(
 'J8'
,'인턴'
);

SELECT
   V.*
  FROM V_JOB V;
  
SELECT
   J.*
  FROM JOB J;

UPDATE 
        V_JOB V
  SET JOB_NAME = '알바'
 WHERE JOB_CODE = 'J8';
 
SELECT
   V.*
  FROM V_JOB V;
  
SELECT
   J.*
  FROM JOB J;

DELETE
  FROM V_JOB
 WHERE JOB_CODE = 'J8';

SELECT
   V.*
  FROM V_JOB V;
  
SELECT
   J.*
  FROM JOB J;
  
-- DML 명령어로 VIEW 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중에, 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정 된 경우
-- 3. 산술 표현식으로 정의 된 경우
-- 4. JOIN을 이용해 여러 테이블을 연결한 경우
-- 5. DISTINCT를 포함한 경우
-- 6. 그룹함수나 GROUP BY절을 포함한 경우

-- 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB2
AS
SELECT J.JOB_CODE
  FROM JOB J;

SELECT
       V.*
  FROM V_JOB2 V;
-- JOB_NAME 부적합한 식별자 오류
INSERT
  INTO V_JOB2
(
  JOB_CODE
, JOB_NAME
)
VALUES
(
  'J8'
, '인턴'
);
-- JOB_NAME 부적합한 식별자 오류
UPDATE
       V_JOB2 V
   SET V.JOB_NAME = '인턴'
 WHERE V.JOB_CODE = 'J7';
-- 뷰 정의에 사용 된 컬럼만 사용하므로 삽입 가능
INSERT
  INTO V_JOB2
(
  JOB_CODE
)
VALUES
(
  'J8'
);

SELECT
       J.*
  FROM JOB J;
-- 뷰 정의에 사용 된 컬럼만 사용하여 DELETE 가능
DELETE
  FROM V_JOB2
 WHERE JOB_CODE = 'J8';
  
-- 뷰에 포함되지 않은 컬럼 중에 
-- 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB3
AS
SELECT J.JOB_NAME
  FROM JOB J;
 
SELECT 
       V.*
  FROM V_JOB3 V;
-- JOB_CODE 뷰 정의에 없어 부적합한 식별자 오류
INSERT
  INTO V_JOB3
(
  JOB_CODE
, JOB_NAME
)
VALUES
(
  'J8'
, '인턴'
);
-- JOB_CODE에는 NULL이 삽입 될 수 없어 오류
INSERT
  INTO V_JOB3
(
  JOB_NAME
)
VALUES
(
  '인턴'
);  
-- 뷰에 정의 된 컬럼만을 사용한 UPDATE 수행 가능
UPDATE
       V_JOB3 V
   SET V.JOB_NAME = '인턴'
 WHERE V.JOB_NAME = '사원';
 
-- 산술표현식으로 정의된 경우
CREATE OR REPLACE VIEW EMP_SAL
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.SALARY
     , (E.SALARY + (E.SALARY * NVL(E.BONUS, 0))) * 12 연봉
  FROM EMPLOYEE E;
 
SELECT
       ES.*
  FROM EMP_SAL ES;
-- 산술표현식으로 연산 된 가상 컬럼 연봉에는 INSERT 불가
INSERT
  INTO EMP_SAL
(
  EMP_ID
, EMP_NAME
, SALARY
, 연봉
)
VALUES
(
  '800'
, '정진훈'
, 3000000
, 4000000
);
-- 산술표현식으로 연산 된 가상 컬럼 연봉은 UPDATE 불가  
UPDATE
       EMP_SAL ES
   SET ES.연봉 = 80000000
 WHERE ES.EMP_ID = '200';

-- DELETE의 조건으로는 사용 가능
DELETE
  FROM EMP_SAL ES
 WHERE ES.연봉 = 124800000;
 
ROLLBACK;
 
-- JOIN을 이용해 여러 테이블을 연결한 경우
CREATE OR REPLACE VIEW V_JOINEMP
AS
SELECT E.EMP_ID 
     , E.EMP_NAME
     , D.DEPT_TITLE
  FROM EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID);
  
SELECT
       V.*
  FROM V_JOINEMP V;
-- 조인 뷰에 의하여 하나 이상의 기본 테이블을 수정할 수 없습니다.
INSERT
  INTO V_JOINEMP
(
  EMP_ID
, EMP_NAME
, DEPT_TITLE
)
VALUES
(
  888
, '조세오'
, '인사관리부'
);
-- 키-보존된것이 아닌 테이블로 대응한 열을 수정할 수 없습니다
UPDATE
       V_JOINEMP V
   SET V.DEPT_TITLE = '인사관리부';
  
DELETE
  FROM V_JOINEMP V
 WHERE V.EMP_ID = '219';
  
SELECT
       V.*
  FROM V_JOINEMP V
 WHERE V.EMP_ID = '219';
 
ROLLBACK;
  
-- DISTINCT를 포함한 경우
CREATE OR REPLACE VIEW V_DT_EMP
AS
SELECT DISTINCT E.JOB_CODE
  FROM EMPLOYEE E;
-- 뷰에 대한 데이터 조작이 부적합합니다
INSERT
  INTO V_DT_EMP
(
  JOB_CODE
)
VALUES
(
  'J9'
);
-- 뷰에 대한 데이터 조작이 부적합합니다
UPDATE
       V_DT_EMP V
   SET V.JOB_CODE = 'J9'
 WHERE V.JOB_CODE = 'J7';
-- 뷰에 대한 데이터 조작이 부적합합니다
DELETE
  FROM V_DT_EMP V
 WHERE V.JOB_CODE = 'J7';
 
-- 그룹 함수나 GROUP BY 절을 포함한 경우
CREATE OR REPLACE VIEW V_GROUPDEPT
AS
SELECT E.DEPT_CODE
     , SUM(E.SALARY) 합계
     , AVG(E.SALARY) 평균
  FROM EMPLOYEE E
 GROUP BY E.DEPT_CODE;

SELECT
       V.*
  FROM V_GROUPDEPT V;
-- 가상 열은 사용할 수 없습니다
INSERT
  INTO V_GROUPDEPT
(
  DEPT_CODE
, 합계
, 평균
)
VALUES
(
  'D0'
, 60000000
, 4000000
);
-- 뷰에 대한 데이터 조작이 부적합합니다
UPDATE
       V_GROUPDEPT V
   SET V.DEPT_CODE = 'D10'
 WHERE V.DEPT_CODE = 'D1';
-- 뷰에 대한 데이터 조작이 부적합합니다
DELETE
  FROM V_GROUPDEPT V
 WHERE V.DEPT_CODE = 'D1';

-- VIEW 옵션
-- ON REPLACE : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고 존재하지 않으면 새로 생성하는 옵션
-- FORCE : 서브 쿼리에 사용 된 테이블이 존재하지 않아도 뷰 생성하는 옵션
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE
     , TNAME
     , TCONTENT
  FROM TT;

-- NOFORCE : 서브쿼리에 테이블이 존재해야만 뷰를 생성하는 옵션(기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP
AS
SELECT TCODE
     , TNAME
     , TCONTENT
  FROM TT;
  
-- WITH CHECK OPTION : 조건절에 사용 된 컬럼의 값을 수정하지 못하게 하는 옵션
CREATE OR REPLACE VIEW V_EMP2
AS
SELECT
       E.*
  FROM EMPLOYEE E
 WHERE MANAGER_ID = '200'
 WITH CHECK OPTION;

-- 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
UPDATE 
      V_EMP2
  SET MANAGER_ID = '900'
  WHERE MANAGER_ID = '200';
  
-- WITH READ ONLY : DML 수행이 불가능하게 하는 옵션
CREATE OR REPLACE VIEW V_DEPT
AS
SELECT
        D.*
  FROM DEPARTMENT D
  WITH READ ONLY;

-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
DELETE
  FROM V_DEPT;
  









