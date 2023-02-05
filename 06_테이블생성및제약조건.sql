-- DDL(CREAT TABLE) �� ��������

-- [ǥ����]
-- CREATE TABLE ���̺�� (�÷��� �ڷ���(ũ��), �÷��� �ڷ���(ũ��),...);
CREATE TABLE MEMBER(
  MEMBER_ID VARCHAR2(20),
  MEMBER_PWD VARCHAR2(20),
  MAMBER_NAME VARCHAR2(20)
  );
  
SELECT 
        M.*
  FROM MEMBER M;

-- �÷��� �ּ� �ޱ�
-- [ǥ����]
-- COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�'; 
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';

-- �ش� ������ �����ϰ� �ִ� ���̺�, �÷� ��ȸ ����
SELECT
       UT.*
  FROM USER_TABLES UT;
  
SELECT
        UTC.*
  FROM USER_TAB_COLUMNS UTC
 WHERE UTC.TABLE_NAME = 'MEMBER';

-- ���� ����
-- ���̺� �ۼ� �� �� �÷��� ���� �� ��Ͽ� ���� ���� ������ ������ �� �ִ�.
-- ������ ���Ἲ ������ �������� �Ѵ�.
-- �Է��ϰų� �����ϴ� �����Ϳ� ������ ������ �ڵ����� �˻��Ѵ�.
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

-- �ش� ������ �����ϰ� �ִ� ���� ���� ��ȸ ����
SELECT
        UC.*
  FROM USER_CONSTRAINTS UC;

SELECT 
        UCC.*
  FROM USER_CONS_COLUMNS UCC;

-- NOT NULL : �ش� �÷��� �ݵ�� ���� ��� �Ǿ�� �ϴ� ��� ���
--            ���� | ���� �� NULL ���� ������� �ʵ��� �ϸ� "�÷� ����"���� ����

-- ���������� ���� ���̺� ����
CREATE TABLE USER_NOCONS (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30),
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

-- ���������� ���� USER_NOCONS ���̺� ������ 1�� ����
INSERT
  INTO USER_NOCONS
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- �ƹ��� ���� ���� ���� ���̺��� �����ϸ� �ʼ� ������ NULL�� ���� �Ǿ ���� ���� ����
INSERT
  INTO USER_NOCONS
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  2
, NULL
, NULL
, NULL
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- "�÷� ����"�� NOT NULL ���� ������ �����Ѵ�.
CREATE TABLE USER_NOTNULL (
  USER_NO NUMBER NOT NULL,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30)NOT NULL,
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

-- ������� USER_NOTNULL ���̺��� ���� ���� �˻�
SELECT
       UC.*
      ,UCC.*
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.TABLE_NAME = 'USER_NOTNULL';
 
-- USER_NOTNULL ���̺��� ���� ���� �׽�Ʈ
INSERT
  INTO USER_NOTNULL
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, NULL
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- UNIQUE ���� ���� : �÷��� �Է� ���� ���� �ߺ��� �����ϴ� ���� ����
--                  "�÷� ����", "���̺� ����" ��� ���� ����
-- UNIQUE ���� ������ ���� USER_NOCONS���� ������ ������ ���� �����ص� ������ ����.
-- ���̵� ���� �÷��� �ߺ��� ����ϸ� �ȵǹǷ� UNIQUE ���������� �ʿ��ϴ�.
INSERT
  INTO USER_NOCONS
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- UNIQUE ���� ������ �÷� �������� ������ USER_UNIQUE ���̺� ����
CREATE TABLE USER_UNIQUE (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

-- USER_UNIQUE ���̺� USER_ID�� ������ ���� ���� �Ұ������� �׽�Ʈ
INSERT
  INTO USER_UNIQUE
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- ���� ���Ǹ��� �̿��ؼ� ���� ���� �˻�
SELECT
        UCC.TABLE_NAME
      , UCC.COLUMN_NAME
      , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
      ,USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007353';

-- UNIQUE ���� ������ "���̺� ����"���� ������ USER_UNIQUE2 ���̺� ����
CREATE TABLE USER_UNIQUE2 (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_ID)
);
-- USER_UNIQUE2 ���̺� USER_ID�� ������ ���� ���� �Ұ������� �׽�Ʈ
INSERT
  INTO USER_UNIQUE2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- ���� ���Ǹ��� �̿��ؼ� ���� ���� �˻�
SELECT
        UCC.TABLE_NAME
      , UCC.COLUMN_NAME
      , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
      ,USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007356';

-- �� �� �̻��� �÷��� ��� �ϳ��� UNIQUE ���� ������ ������ ���� �ִ�.
-- �� ���� ���̺� �������� �ۿ��� ������ �� ����.
CREATE TABLE USER_UNIQUE3 (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_NO, USER_ID)
);

-- USER_UNIQUE3�� USER_NO, USER_ID�� ���� �ߺ� �� �Է� �Ұ����� �׽�Ʈ
INSERT
  INTO USER_UNIQUE3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);
-- ���� ���Ǹ��� �̿��ؼ� ���� ���� �˻�
SELECT
        UCC.TABLE_NAME
      , UCC.COLUMN_NAME
      , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
      ,USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007359';

-- �������ǿ� �̸��� �ٿ��� ���̺� ����
CREATE TABLE CONS_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
  TSET_DATA2 VARCHAR2(20) CONSTRAINT UN_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(30),
  CONSTRAINT UN_TEST_DATA3 UNIQUE(TEST_DATA3)
);

-- CONS_NAME ���̺��� ���� ���� �˻�
SELECT
       UC.*
  FROM USER_CONSTRAINTS UC
 WHERE TABLE_NAME = 'CONS_NAME';
 
-- CHECK ���� ���� : �÷��� ��� �Ǵ� ���� ���� ������ �� �� �ִ�.
-- CHECK(�÷��� �񱳿����� �񱳰�)
-- ���� : �񱳰��� ���ͷ��� ����� �� ����, ���ϴ� ���̳� �Լ��� ��� ����
CREATE TABLE USER_CHECK (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��','��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
);

-- USER_CHECK�� GENDER�� ���� '��', OR '��' �ܿ� �Է� �Ұ����� �׽�Ʈ
INSERT
  INTO USER_CHECK
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  3
, 'user03'
, 'pass03'
, '��������'
, '����'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- ���̺� �������� CHECK ���� ���� ����
CREATE TABLE TEST_CHECK(
  TEST_NUMBER NUMBER,
  CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
);

-- TEST_CHECK ���̺� ���� �׽�Ʈ
INSERT 
   INTO TEST_CHECK
(
  TEST_NUMBER
)
VALUES
(
    -10
);
-- ȸ�� ���Կ� ���̺� ����(USER_TEST)
-- �÷��� : USER_NO(ȸ����ȣ)
--         USER_ID(ȸ�����̵�) -- �ߺ� ����, NULL�� ��� ����
--         USER_PWD(ȸ����й�ȣ) -- NULL�� ��� ����
--         PNO(�ֹε�Ϲ�ȣ) -- �ߺ� ����, NULL�� ��� ����
--         GENDER(����) -- '��' �Ǵ� '��'�� �Է�
--         PHONE(����ó) 
--         ADDRESS(�ּ�)
--         STATUS(Ż�𿩺�) -- NOT NULL, 'Y' Ȥ�� 'N'���� �Է�
-- �� �������� �̸� �ο�
-- 5�� �̻� ȸ�� ���� INSERT
-- �� �÷����� �ڸ�Ʈ ����

CREATE TABLE USER_TEST (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) CONSTRAINT NNUN_TEST_DATA1 UNIQUE NOT NULL,
  USER_PWD VARCHAR2(20) CONSTRAINT NN_TEST_DATA2 NOT NULL,
  PNO VARCHAR2(30) CONSTRAINT NNUN_TEST_DATA3 UNIQUE NOT NULL,
  GENDER VARCHAR2(10) CONSTRAINT CK_TEST_DATA4 CHECK(GENDER IN('��', '��')),
  ADDRESS VARCHAR2(50),
  STATUS VARCHAR2(10) CONSTRAINT NNCK_TEST_DATA5 NOT NULL CHECK(STATUS IN('Y', 'N'))
  );
COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ'; 
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN USER_TEST.PNO IS '�ֹε�Ϲ�ȣ'; 
COMMENT ON COLUMN USER_TEST.GENDER IS '����';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';

INSERT
  INTO USER_TEST
(
  USER_NO
, USER_ID
, USER_PWD
, PNO
, GENDER
, ADDRESS
, STATUS
)
VALUES
(
  1
, 'user01'
, 'pass01'
, '123456_7891011'
, '��'
, '����� ����'
, 'N'
);
INSERT
  INTO USER_TEST
(
  USER_NO
, USER_ID
, USER_PWD
, PNO
, GENDER
, ADDRESS
, STATUS
)
VALUES
(
  2
, 'user02'
, 'pass01'
, '223456_7891011'
, '��'
, '������ ����'
, 'N'
);
INSERT
  INTO USER_TEST
(
  USER_NO
, USER_ID
, USER_PWD
, PNO
, GENDER
, ADDRESS
, STATUS
)
VALUES
(
  3
, 'user03'
, 'pass01'
, '323456_7891011'
, '��'
, '����� ����'
, 'N'
);
INSERT
  INTO USER_TEST
(
  USER_NO
, USER_ID
, USER_PWD
, PNO
, GENDER
, ADDRESS
, STATUS
)
VALUES
(
  4
, 'user04'
, 'pass01'
, '124456_7891011'
, '��'
, '������ ����'
, 'Y'
);
INSERT
  INTO USER_TEST
(
  USER_NO
, USER_ID
, USER_PWD
, PNO
, GENDER
, ADDRESS
, STATUS
)
VALUES
(
  5
, 'user05'
, 'pass01'
, '123256_7891011'
, '��'
, '����� �������'
, 'N'
);
---------------------------------------------------------------
-- PRIMARY KEY(�⺻Ű) ���� ����
-- : ���̺��� �� ���� ������ ã�� ���� ����� �÷��� �ǹ��Ѵ�.
--   ���̺� ���� �ĺ��� ������ �Ѵ�.
--   NOT NULL + UNIQUE�� �ǹ̸� ������
-- �� ���̺�� �ϳ��� ������ �� ������ Į�� ����, ���̺� ���� �� �� ���� �����ϴ�.
-- �� �� �÷��� ������ ���� �ְ�, ���� ���� �÷��� ��� ������ ���� �ִ�.

-- �÷� �������� PK ����
CREATE TABLE USER_PRIMARYKEY (
  USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��','��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
);

-- PRIMARY KEY�� NOT NULL, UNIQUE �׽�Ʈ
INSERT
  INTO USER_PRIMARYKEY
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1212-1221'
, 'HASODSDJ@GREEDY.COM'
);

-- ���̺� �������� PK ����(����Ű�� ����)
CREATE TABLE USER_PRIMARYKEY2 (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��','��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  CONSTRAINT PK_USER_NO2 PRIMARY KEY(USER_NO, USER_ID)
);

-- PRIMARY KEY�� NOT NULL, UNIQUE �׽�Ʈ
INSERT
  INTO USER_PRIMARYKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1212-1221'
, 'HASODSDJ@GREEDY.COM'
);

-- FOREIGN KEY(�ܺ�Ű|�ܷ�Ű) ���� ����
-- ����(REFERENCES) �� �ٸ� ���̺��� �����ϴ� ���� ����� �� �ִ�.
-- ���� ���Ἲ�� �������� �ʱ� ���ؼ� ����Ѵ�.
-- FOREIGN KEY ���� ���ǿ� ���ؼ� ���̺� ���� ���谡 ���� �Ǹ� �����Ǵ� �� �ܿ��� NULL�� ����� �� �ִ�.

-- �÷� ������ ���
-- �÷��� �ڷ���(ũ��) [CONSTRAINT ���� ���Ǹ�] REFERENCES �������̺�� [(�����÷���)] [������]

-- ���̺� ������ ���
-- [CONSTRAINT �������Ǹ�] FOREIGN KEY(����Į����) REFERENCES �������̺�� [(�����÷���)] [������]

-- �������̺��� �����÷����� �����Ǹ� PRIMARY KEY�� ���� �� �÷��� �ڵ����� ���� �÷��� �ȴ�.
-- PRIMARY KEY �÷��� UNIQUE�� ������ �÷��� ���� �� �� �ִ�.

CREATE TABLE USER_GRADE(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
  );
  
INSERT 
    INTO USER_GRADE
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  10
, '�Ϲ�ȸ��'
);
INSERT 
    INTO USER_GRADE
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  20
, '���ȸ��'
);
INSERT 
    INTO USER_GRADE
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  30
, 'Ư��ȸ��'
);

SELECT
      UG.*
  FROM USER_GRADE UG;
  
  CREATE TABLE USER_FOREIGNKEY (
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��','��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);

INSERT
  INTO USER_FOREIGNKEY
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1212-1221'
, 'HASODSDJ@GREEDY.COM'
, 10
);

INSERT
  INTO USER_FOREIGNKEY
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  2
, 'user02'
, 'pass02'
, '������'
, '��'
, '010-1111-2222'
, 'YOO123@GREEDY.COM'
, 10
);
INSERT
  INTO USER_FOREIGNKEY
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  3
, 'user03'
, 'pass03'
, '������'
, '��'
, '010-1234-1567'
, 'YIYI123@GREEDY.COM'
, 30
);
-- FK�� NULL���� ���ȴ�.
INSERT
  INTO USER_FOREIGNKEY
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  4
, 'user04'
, 'pass04'
, '��������'
, '��'
, '010-442-1221'
, 'HASO23DJ@GREEDY.COM'
, NULL
);
-- �θ� Ű�� ���� �ܷ�Ű ���� ���� ����
INSERT
  INTO USER_FOREIGNKEY
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  5
, 'user05'
, 'pass05'
, '�Ż��Ӵ�'
, '��'
, '010-1212-1221'
, 'HA333DJ@GREEDY.COM'
, 50
);

-- ȸ�� ���̵�, ����, ����ó, ȸ�� ��޸� ��ȸ
SELECT
        UF.USER_ID
      , UF.GENDER
      , UF.PHONE
      , UG.GRADE_NAME
  FROM USER_FOREIGNKEY UF
  LEFT JOIN USER_GRADE UG ON (UF.GRADE_CODE = UG.GRADE_CODE);
  
-- ���� �ɼ�
-- : �θ� ���̺��� ������ ���� �� �ڽ� ���̺��� � ������ ó���� �������� ���� ����
DELETE 
  FROM USER_GRADE
 WHERE GRADE_CODE = 10;

-- ON DELETE RESTRICT : ���� �⺻ ���� ��
-- FK�� ���� �� �÷����� ��� �ǰ� �ִ� ���� ��� �����ϴ� �÷��� ���� ���� �Ұ�

-- �ڽ� ���ڵ�� ������ ���� ���� ���� ����
DELETE 
  FROM USER_GRADE
 WHERE GRADE_CODE = 20;
 
-- ON DELETE SET NULL : �θ�Ű�� ���� �� �ڽ� Ű�� NULL�� �����ϴ� �ɼ�
CREATE TABLE USER_GRADE2(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
  );
  
INSERT 
    INTO USER_GRADE2
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  10
, '�Ϲ�ȸ��'
);
INSERT 
    INTO USER_GRADE2
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  20
, '���ȸ��'
);
INSERT 
    INTO USER_GRADE2
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  30
, 'Ư��ȸ��'
);

SELECT
      UG.*
  FROM USER_GRADE UG;
  
  CREATE TABLE USER_FOREIGNKEY2 (
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��','��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
);

INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1212-1221'
, 'HASODSDJ@GREEDY.COM'
, 10
);

INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  2
, 'user02'
, 'pass02'
, '������'
, '��'
, '010-1111-2222'
, 'YOO123@GREEDY.COM'
, 10
);
INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  3
, 'user03'
, 'pass03'
, '������'
, '��'
, '010-1234-1567'
, 'YIYI123@GREEDY.COM'
, 30
);
-- FK�� NULL���� ���ȴ�.
INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  4
, 'user04'
, 'pass04'
, '��������'
, '��'
, '010-442-1221'
, 'HASO23DJ@GREEDY.COM'
, NULL
);
-- �θ� Ű�� ���� �ܷ�Ű ���� ���� ����
INSERT
  INTO USER_FOREIGNKEY2
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  5
, 'user05'
, 'pass05'
, '�Ż��Ӵ�'
, '��'
, '010-1212-1221'
, 'HA333DJ@GREEDY.COM'
, 50
);
-- ���� ������ �ɷ����� �ʾ� �ڽ� ���ڵ尡 �ִ��� ������ ����ȴ�.
DELETE
  FROM USER_GRADE2
 WHERE GRADE_CODE = 10;

SELECT 
       UG.*
  FROM USER_GRADE2 UG;
-- ��� ���� �� ���� ������ ���� �����Ƿ� NULL ������ ����Ǿ� �ִ� ���� Ȯ���� �� �ִ�.
SELECT 
       UF.*
  FROM USER_FOREIGNKEY2 UF;

-- ON DELETE CASCADE : �θ� Ű ���� �� �ڽ� Ű�� ���� �൵ �Բ� ����
CREATE TABLE USER_GRADE3(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
  );
  
INSERT 
    INTO USER_GRADE3
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  10
, '�Ϲ�ȸ��'
);
INSERT 
    INTO USER_GRADE3
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  20
, '���ȸ��'
);
INSERT 
    INTO USER_GRADE3
    (
    GRADE_CODE
,   GRADE_NAME
)
VALUES
(
  30
, 'Ư��ȸ��'
);

SELECT
      UG.*
  FROM USER_GRADE UG;
  
  CREATE TABLE USER_FOREIGNKEY3 (
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10) CHECK(GENDER IN ('��','��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
);

INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1212-1221'
, 'HASODSDJ@GREEDY.COM'
, 10
);

INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  2
, 'user02'
, 'pass02'
, '������'
, '��'
, '010-1111-2222'
, 'YOO123@GREEDY.COM'
, 10
);
INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  3
, 'user03'
, 'pass03'
, '������'
, '��'
, '010-1234-1567'
, 'YIYI123@GREEDY.COM'
, 30
);
-- FK�� NULL���� ���ȴ�.
INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  4
, 'user04'
, 'pass04'
, '��������'
, '��'
, '010-442-1221'
, 'HASO23DJ@GREEDY.COM'
, NULL
);
-- �θ� Ű�� ���� �ܷ�Ű ���� ���� ����
INSERT
  INTO USER_FOREIGNKEY3
(
  USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
  5
, 'user05'
, 'pass05'
, '�Ż��Ӵ�'
, '��'
, '010-1212-1221'
, 'HA333DJ@GREEDY.COM'
, 50
);
-- ���� ������ �ɷ����� �ʾ� �ڽ� ���ڵ尡 �ִ��� ���� ����
DELETE  
  FROM USER_GRADE3
 WHERE GRADE_CODE = 10;
 
SELECT
        UG.*
  FROM USER_GRADE3 UG;
-- ��� ���� �� ���� ������ �� �����Ƿ� �ڽ� ���̺��� �ش� ���� ���� ���� �Ǿ���.
SELECT
        UF.*
  FROM USER_FOREIGNKEY3 UF;

-- ���������� �̿��� ���̺� ����
-- �÷���, ������Ÿ��, ���� ����ǰ�, ���������� NOT NULL�� ����ȴ�.
CREATE TABLE EMPLOYEE_COPY
AS
SELECT
       E.*
  FROM EMPLOYEE E;
  
SELECT 
        EC.*
  FROM EMPLOYEE_COPY EC;