-- TCL(Transaction Control Language)
-- 트랜잭션 제어 언어 (COMMIT, ROLLBACK)

-- 트랜잭션이란?
-- 한꺼번에 수행 되어야 할 최소의 작업 단위를 말한다.
-- 논리적인 작업 단위(Logical Unit of Work : LUW)
-- 하나의 트랜잭션으로 이루어진 작업은 반드시 한꺼번에 완료(COMMIT)
-- 되어야 하며 그렇지 않은 경우에는 한꺼번에 취소(ROLLBACK)되어야 한다.

-- COMMIT : 트랜잭션 작업이 정상 완료 되고 나면 변경 내용을 영구히 저장
-- ROLLBACK : 트랜잭션 작업을 취소하고 최근 COMMIT한 시점으로 이동
-- SAVEPOINT 세이브포인트명 : 현재 트랜잭션 작업 시점에 이름을 정해줌. 하나의 트랜잭션 안에서 구역을 나눔
-- ROLLBACK TO 세이브포인트명 : 트랜잭션 작업을 취소하고 SAVEPOINT 시점으로 이동

CREATE TABLE TBL_USER (
  USERNO NUMBER UNIQUE,
  ID VARCHAR2(20) PRIMARY KEY,
  PASSWORD CHAR(20) NOT NULL
);

INSERT 
  INTO TBL_USER
(
  USERNO
, ID
, PASSWORD
)
VALUES
(
  1
, 'test1'
, 'pass1'
);

INSERT 
  INTO TBL_USER
(
  USERNO
, ID
, PASSWORD
)
VALUES
(
  2
, 'test2'
, 'pass2'
);

INSERT 
  INTO TBL_USER
(
  USERNO
, ID
, PASSWORD
)
VALUES
(
  3
, 'test3'
, 'pass3'
);

COMMIT;

SELECT
        UT.*
  FROM TBL_USER UT;
  
INSERT 
  INTO TBL_USER
(
  USERNO
, ID
, PASSWORD
)
VALUES
(
  4
, 'test4'
, 'pass4'
);

SELECT
        UT.*
  FROM TBL_USER UT;
  
ROLLBACK;

SELECT
        UT.*
  FROM TBL_USER UT;

INSERT 
  INTO TBL_USER
(
  USERNO
, ID
, PASSWORD
)
VALUES
(
  4
, 'test4'
, 'pass4'
);

SAVEPOINT SP1;

INSERT 
  INTO TBL_USER
(
  USERNO
, ID
, PASSWORD
)
VALUES
(
  5
, 'test5'
, 'pass5'
);

SELECT
        UT.*
  FROM TBL_USER UT;
  
ROLLBACK TO SP1;

SELECT
        UT.*
  FROM TBL_USER UT;
  
ROLLBACK;

SELECT
        UT.*
  FROM TBL_USER UT;
  
-- DML(INSERT, UPDATE, DELETE) 구문은 반드시 COMMIT를 해야 반영된다!!!
