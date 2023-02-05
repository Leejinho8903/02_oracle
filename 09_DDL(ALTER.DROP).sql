-- DDL(Data Definition Language)
-- ALTER : 객체를 수정하는 구문
-- 테이블 객체 수정 : ALTER TABLE 테이블명 수정할내용;
-- 컬럼 추가/수정/삭제, 제약조건 추가/수정/삭제
-- 테이블명 변경, 제약조건 이름 변경

-- 컬럼 추가
SELECT
        DC.*
  FROM DEPT_COPY DC;

ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(20));

SELECT
        DC.*
  FROM DEPT_COPY DC;
  
-- 컬럼 삭제
ALTER TABLE DEPT_COPY
DROP COLUMN LNAME;

SELECT
        DC.*
  FROM DEPT_COPY DC;
  
-- 컬럼 생성 시 DAFAULT 값 지정
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20) DEFAULT '한국');

SELECT
        DC.*
  FROM DEPT_COPY DC;
  
-- 컬럼에 제약조건 추가
CREATE TABLE DEPT_COPY2
AS
SELECT D.*
  FROM DEPARTMENT D;
  
-- DEPT_COPY2에 PK 제약조건 추가
ALTER TABLE DEPT_COPY2
ADD CONSTRAINT PK_DEPT_ID2 PRIMARY KEY(DEPT_ID);

-- DEPT_COPY2에 UNIQUE 제약조건 추가
ALTER TABLE DEPT_COPY2
ADD CONSTRAINT UN_DEPT_TITLE2 UNIQUE(DEPT_TITLE);

-- DEPT_COPY2에 NOT NULL 제약조건 추가
-- NOT NULL 제약조건의 경우 ADD가 아닌 MODIFY 사용
ALTER TABLE DEPT_COPY2
MODIFY DEPT_TITLE CONSTRAINT NN_DEPT_TITLE2 NOT NULL;

-- 컬럼 자료형 수정
ALTER TABLE DEPT_COPY2
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(2);

-- 컬럼의 크기를 줄이는 경우 변경하려는 크기를 초과하는 컬럼 값이 없을 때만 변경할 수 있다.
ALTER TABLE DEPT_COPY2
MODIFY DEPT_TITLE VARCHAR2(10);

-- DEFATUL 값 변경
ALTER TABLE DEPT_COPY
MODIFY CNAME DEFAULT '미국';

SELECT
    DC.*
  FROM DEPT_COPY DC;

INSERT 
  INTO DEPT_COPY
VALUES
(
  'D0'
, '생산부'
, 'L2'
, DEFAULT
);

-- 컬럼 삭제 테스트
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;

SELECT
   DC.*
  FROM DEPT_COPY2 DC;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

SELECT
   DC.*
  FROM DEPT_COPY2 DC;

-- 테이블에 최소 한 개 이상이 컬럼이 남아있어야 하기 때문에 모든 열을 삭제할 수는 없다.
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

-- 제약 조건이 있는 컬럼 삭제
CREATE TABLE TB1(
  PK NUMBER PRIMARY KEY,
  FK NUMBER REFERENCES TB1,
  COL1 NUMBER,
  CHECK(PK > 0 AND COL1 >0)
);

-- 컬럼 삭제 시 참조하고 있는 컬럼이 있다면 삭제할 수 없다.
ALTER TABLE TB1
DROP COLUMN PK;

-- 제약 조건도 함께 삭제한다면 컬럼 삭제가 가능하다.
ALTER TABLE TB1
DROP COLUMN PK CASCADE CONSTRAINTS;

SELECT
TB.*
FROM TB1 TB;

-- 제약조건 삭제
CREATE TABLE CONST_EMP (
 ENAME VARCHAR2(20) NOT NULL,
 ENO VARCHAR2(15) NOT NULL,
 MARRIAGE CHAR(1) DEFAULT 'N',
 EID CHAR(3),
 EMAIL VARCHAR2(30),
 JID CHAR(2),
 MID CHAR(3),
 DID CHAR(2),
  -- 테이블 레벨로 제약 조건 설정
  CONSTRAINT CK_MARRIAGE CHECK(MARRIAGE IN('Y','N')),
  CONSTRAINT PK_EID PRIMARY KEY(EID),
  CONSTRAINT UN_ENO UNIQUE(ENO),
  CONSTRAINT UN_EMAIL UNIQUE(EMAIL),
  CONSTRAINT FK_JIN FOREIGN KEY(JID) REFERENCES JOB(JOB_CODE) ON DELETE SET NULL,
  CONSTRAINT FK_MIT FOREIGN KEY(MID) REFERENCES CONST_EMP ON DELETE SET NULL,
  CONSTRAINT FK_MID FOREIGN KEY(DID) REFERENCES DEPARTMENT ON DELETE CASCADE
);

-- 제약조건 1개 삭제 시
ALTER TABLE CONST_EMP
DROP CONSTRAINT CK_MARRIAGE;

-- 제약조건 여러 개 삭제 시
ALTER TABLE CONST_EMP
DROP CONSTRAINT FK_JIN
DROP CONSTRAINT FK_MIT
DROP CONSTRAINT FK_MID;

-- NOT NULL 제약 조건은 삭제 시 MODIFY 이용
ALTER TABLE CONST_EMP
MODIFY (ENAME NULL, ENO NULL);

-- 컬럼 이름 변경
CREATE TABLE DEPT_COPY3
AS SELECT * FROM DEPARTMENT;

SELECT
DC.*
  FROM DEPT_COPY3 DC;
 
ALTER TABLE DEPT_COPY3
RENAME COLUMN DEPT_ID TO DEPT_CODE;

-- 제약조건명 변경
ALTER TABLE DEPT_COPY3
ADD CONSTRAINT PK_DEPT_CODE3 PRIMARY KEY(DEPT_CODE);

ALTER TABLE DEPT_COPY3
RENAME CONSTRAINT PK_DEPT_CODE3 TO PK_DCODE;

-- 테이블 이름 변경
ALTER TABLE DEPT_COPY3
RENAME TO DEPT_TEST;

SELECT
DC.*
  FROM DEPT_COPY3 DC;
  
SELECT
DT.*
  FROM DEPT_TEST DT;
  
-- 테이블 삭제
DROP TABLE DEPT_TEST CASCADE CONSTRAINTS;

SELECT
DT.*
  FROM DEPT_TEST DT;