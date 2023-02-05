-- TCL(Transaction Control Language)
-- Ʈ����� ���� ��� (COMMIT, ROLLBACK)

-- Ʈ������̶�?
-- �Ѳ����� ���� �Ǿ�� �� �ּ��� �۾� ������ ���Ѵ�.
-- ������ �۾� ����(Logical Unit of Work : LUW)
-- �ϳ��� Ʈ��������� �̷���� �۾��� �ݵ�� �Ѳ����� �Ϸ�(COMMIT)
-- �Ǿ�� �ϸ� �׷��� ���� ��쿡�� �Ѳ����� ���(ROLLBACK)�Ǿ�� �Ѵ�.

-- COMMIT : Ʈ����� �۾��� ���� �Ϸ� �ǰ� ���� ���� ������ ������ ����
-- ROLLBACK : Ʈ����� �۾��� ����ϰ� �ֱ� COMMIT�� �������� �̵�
-- SAVEPOINT ���̺�����Ʈ�� : ���� Ʈ����� �۾� ������ �̸��� ������. �ϳ��� Ʈ����� �ȿ��� ������ ����
-- ROLLBACK TO ���̺�����Ʈ�� : Ʈ����� �۾��� ����ϰ� SAVEPOINT �������� �̵�

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
  
-- DML(INSERT, UPDATE, DELETE) ������ �ݵ�� COMMIT�� �ؾ� �ݿ��ȴ�!!!
