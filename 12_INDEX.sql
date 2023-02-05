-- INDEX(인덱스)
-- : SQL 명령문의 검색 처리 속도를 향상시키기 위해 컬럼에 대해 생성하는 오라클 객체
--   하드 디스크의 어떤 위치에 대한 정보를 가진 주소록으로 인덱스는 DATA와 ROWID로 구성되어 있다.

-- ROWID의 구조 : 오브젝트 번호, 상대파일 번호, 블록 번호, 데이터 번호
SELECT
        ROWID
      , EMP_ID
      , EMP_NAME
    FROM EMPLOYEE;

-- 인덱스의 내부 구조는 이진 트리 형식으로 구성되어 있다. (정렬)
-- 인덱스를 생성하기 위해서는 시간이 필요하며 인덱스를 위한 추가 저장 공간이 필요하기 때문에
-- 항상 장점만 있는 것은 아니다. 인덱스가 생성 된 컬럼에서 DML 작업이 빈번한 경우 처리 속도가 느려진다.


-- 인덱스를 관리하는 데이터 딕셔너리
-- PK, UNIQUE 제약조건이 걸린 컬럼은 자동으로 INDEX 객체가 생성이 된다.
SELECT
        UIC.*
    FROM USER_IND_COLUMNS UIC;
    
-- 인덱스의 종류
-- 1. 고유 인덱스(UNIQUE INDEX)
-- 2. 비고유 인덱스(NOUNIQUE INDEX)
-- 3. 단일 인덱스(SINGLE INDEX)
-- 4. 결합 인덱스(COMPSITE INDEX)
-- 5. 함수 기반 인덱스(FUNCTION BASED INDEX)

-- UNIQUE INDEX
-- 고유 인덱스로 생성 된 컬럼에는 중복 값이 포함 될 수 없으며
-- PK, UNIQUE 제약 조건을 생성하면 자동으로 해당 컬럼에 UNIQUE INDEX가 생성 된다.
-- 해당 컬럼으로 ACCESS 하는 경우 성능 향상의 효과가 있다.

-- 인덱스 힌트
-- 일반적으로는 옵티마이저가 적절한 인덱스를 타거나 풀 스캐닝 해서 비용이 적게 드는
-- 효율적인 방식을 선택한다. 하지만 우리가 원하는 테이블에 있는 인덱스를 사용할 수 있도록
-- 하는 구문(힌트)을 통해서 선택할수도 있다. SELECT절 첫 줄에 힌트 주석(/*+ 내용 */)DMF
-- 작성하여 적절한 인덱스를 부여할 수 있다.
SELECT /*+ INDEX(E 엔터티1_PK)*/
        E.*
  FROM EMPLOYEE E;
  
-- 인덱스 영역에서 역방향으로 스캔하라는 의미(INDEX_DESC)
SELECT /*+ INDEX_DESC(E 엔터티1_PK)*/
        E.*
  FROM EMPLOYEE E;

-- 중복 값이 없는 컬럼은 UNIQUE 인덱스를 생성할 수 있다.
CREATE UNIQUE INDEX IDX_EMPNO
ON EMPLOYEE(EMP_NO);

-- 중복 값이 있는 컬럼은 UNIQUE 인덱스를 생성하지 못한다.
CREATE UNIQUE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- NONUNIQUE INDEX(비고유 인덱스)
-- WHERE절에서 빈번하게 사용되는 일반 컬럼을 대상으로 생성한다.
CREATE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- COMPOSITE INDEX(결합 인덱스)
-- 결합 인덱스는 중복 값이 낮은 값이 먼저 오는 것이 검색 속도를 향상 시킨다.
CREATE INDEX IDX_DEPT
ON DEPARTMENT(DEPT_ID, DEPT_TITLE);

SELECT /*+ INDEX_DESC(D IDX_DEPT)*/
       D.DEPT_ID
  FROM DEPARTMENT D 
 WHERE D.DEPT_TITLE > '0'
   AND D.DEPT_ID > '0';

-- 함수 기반 인덱스
-- SELECT절이나 WHERE절에서 산술 계산식이나 함수가 사용 된 경우 계산에 포함된 컬럼은
-- 인덱스의 적용을 받지 않는다. 계산식으로 검색하는 경우가 많다면, 수식이나 함수식으로
-- 이루어진 컬럼을 인덱스로 만들수도 있다.
CREATE INDEX IDX_EMP_SALCALC
ON EMPLOYEE((SALARY + (SALARY * NVL(BONUS,0))) * 12);

SELECT /*+ INDEX_DESC(E IDX_EMP_SALCALC)*/
        E.EMP_ID
      , E.EMP_NAME
      , (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 연봉
  FROM EMPLOYEE E
 WHERE (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 > 1000000;
 
-- 인덱스의 장점
-- 검색 속도 향상, 시스템 부하를 줄여(FULL SCAN을 하지 않으므로) 시스템 성능 향상

-- 인덱스의 단점
-- 추가 저장 공간, 생성 시간 필요
-- DML이 빈번하면 REBUILD 작업을 주기적으로 해야 하며 REBUILD 하지 않으면 오히려 성능 저하

-- 일반적으로 데이터 전체 로우의 15% 이하의 데이터를 조회할 때 인덱스를 생성해서 사용한다.