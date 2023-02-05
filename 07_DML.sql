-- DML(Data Manupluation Language)
-- INSERT, UPDATE, DELETE
-- : ������ ���� ���. ���̺��� ���� �����ϰų� �����ϰų� �����ϰų� ��ȸ�ϴ� ���

-- INSERT : ���ο� ���� �߰��ϴ� �����̴�. ���̺��� �� ������ �����Ѵ�.
-- [ǥ����]
-- ���̺��� �Ϻ� �÷��� INSERT�� ��
-- INSERT INTO ���̺��� (�÷���, �÷���, ...)VALUES (������, ������,...);

-- ���̺��� ��� �÷��� INSERT�� ��
-- INSERT INTO ���̺��� VALUES (������, ������, ...);

-- ������ ��� �÷��� INSERT�� ���� �÷����� ��� �ϴ� ���� �ǹ� �ľǿ��� �� ����.
INSERT
    INTO EMPLOYEE
(
  EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE,
  DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, BONUS,
  MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN
)
VALUES
(
 '900', '��ä��', '901123-2080503', 'jang_ch@greedy.com' , '01012345784',
 'D1', 'J7', 'S3', 4300000, 0.2,
 '200', SYSDATE, NULL, DEFAULT
);

-- INSERT�ÿ� VALUES ��� ���� ������ �̿��� �� �ִ�.
CREATE TABLE EMP_01 (
 EMP_ID NUMBER,
 EMP_NAME VARCHAR2(30),
 DEPT_TITLE VARCHAR2(20)
 );
 
INSERT 
  INTO EMP_01
(
  EMP_ID
, EMP_NAME
, DEPT_TITLE
)
(
  SELECT
         EMP_ID
        ,EMP_NAME
        ,DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    );
    
SELECT
        E.*
  FROM EMP_01 E;

-- INSERT ALL : INSERT�ÿ� ����ϴ� ���� ������ ���� ��� �� �� �̻��� ���̺���
-- INSERT ALL�� �̿��Ͽ� �� ���� �����͸� ������ �� �ִ�.
-- ��, ���������� �������� ���ƾ� �Ѵ�.
CREATE TABLE EMP_DEPT_D1
AS
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE 1 = 0;
 
SELECT
        ED.*
  FROM EMP_DEPT_D1 ED;

CREATE TABLE EMP_MANAGER
AS
SELECT
       EMP_ID
     , EMP_NAME
     , MANAGER_ID
  FROM EMPLOYEE
 WHERE 1 = 0;

SELECT
        EM.*
  FROM EMP_MANAGER EM;
  
-- EMP_DEPT_D1 ���̺��� �μ��ڵ尡 D1�� ������ ��ȸ�ؼ�
-- ���,�̸�,�ҼӺμ�, �Ի����� �����ϰ�
-- EMP_MANAGER ���̺��� �μ��ڵ尡 D1�� ������ ��ȸ�ؼ�
-- ���, �̸�, ������ ����� �����Ѵ�.
INSERT ALL
  INTO EMP_DEPT_D1
VALUES
(
  EMP_ID
, EMP_NAME
, DEPT_CODE
, HIRE_DATE
)
INTO EMP_MANAGER
VALUES
(
  EMP_ID
, EMP_NAME
, MANAGER_ID
)
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , HIRE_DATE
      , MANAGER_ID
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1';

-- �Ի��� �������� 2000�� 1�� 1�� ���� �Ի��� ����� ���, �̸�, �Ի���, �޿��� ��ȸ�Ͽ�
-- EMP_OLD ���̺��� �����ϰ� �� ���Ŀ� �Ի��� ����� EMP_NEW ���̺��� ����
CREATE TABLE EMP_OLD
AS
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
     , SALARY
  FROM EMPLOYEE
  WHERE 1 = 0;
CREATE TABLE EMP_NEW
AS
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
     , SALARY
  FROM EMPLOYEE
 WHERE 1 = 0;
 
INSERT ALL 
 WHEN HIRE_DATE < '2000/01/01'
 THEN 
 INTO EMP_OLD
VALUES
(
  EMP_ID
, EMP_NAME
, HIRE_DATE
, SALARY
)
 WHEN HIRE_DATE >= '2000/01/01'
 THEN
 INTO EMP_NEW
 VALUES
(
  EMP_ID
, EMP_NAME
, HIRE_DATE
, SALARY
)
SELECT
        EMP_ID
      , EMP_NAME
      , HIRE_DATE
      , SALARY
  FROM EMPLOYEE;

SELECT
        EO.*
  FROM EMP_OLD EO;

SELECT
        EN.*
  FROM EMP_NEW EN;
  
-- UPDATE : ���̺��� ��� �� �÷��� ���� �����ϴ� �����̴�.
-- ���̺��� ��ü �� ������ ��ȭ�� ����.
-- [ǥ����]
-- UPDATE ���̺��� SET �÷��� = �ٲܰ�, �÷��� = �ٲܰ�, ...
-- [WHERE �÷��� �񱳿����� �񱳰�];
CREATE TABLE DEPT_COPY
AS
SELECT D.*
  FROM DEPARTMENT D;
  
SELECT
        DC.*
  FROM DEPT_COPY DC;

UPDATE 
        DEPT_COPY
  SET DEPT_TITLE = '������ȹ��'
  WHERE DEPT_ID = 'D9';

-- UPDATE�ÿ��� ���������� ����� �� �ִ�.
-- UPDATE ���̺��� SET �÷��� = (��������)
-- ���� ����� ����� �η����ϴ� ����� ����� �޿��� ���ʽ����� ����� ����� �����ϰ�
-- �������ֱ�� �ߴ�. UPDATE ���� �ۼ�.
CREATE TABLE EMP_SALARY
AS
SELECT
        EMP_ID
      , EMP_NAME
      , DEPT_CODE
      , SALARY
      , BONUS
  FROM EMPLOYEE;

UPDATE
        EMP_SALARY
  SET SALARY = (SELECT
                        SALARY
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '�����'
                    )
    , BONUS = (SELECT
                        BONUS
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '�����'
                    )
 WHERE EMP_NAME = '�����';
 
-- ���߿� ���������� �����Ѵ�.
UPDATE
        EMP_SALARY
  SET (SALARY,BONUS) = (SELECT
                              SALARY
                            , BONUS 
                          FROM EMP_SALARY
                         WHERE EMP_NAME = '�����'
                    )  
 WHERE EMP_NAME = '�����';

SELECT
      ES.*
  FROM EMP_SALARY ES;

-- EMP_SALARY ���̺����� �ƽþ� �ٹ� ������ �ٹ��ϴ� ������ ���ʽ��� 0.5�� �����ϴ�
-- UPDATE ���� �ۼ�, WHERE���� ������ ���������� ����ϸ� ������ �˾ƿ� ����
-- EMPLOYEE, DEPARTMENT, LOCATION ���̺� �״�� ���
UPDATE
        EMP_SALARY ES
  SET ES.BONUS = 0.5
  WHERE ES.EMP_ID IN(SELECT
                       E1.EMP_ID
                FROM EMPLOYEE E1
                JOIN DEPARTMENT D1 ON(E1.DEPT_CODE = D1.DEPT_ID)
                JOIN LOCATION L1 ON(D1.LOCATION_ID = L1.LOCAL_CODE)
                WHERE L1.LOCAL_NAME LIKE 'ASIA%'
                );  
 
-- UPDATE�� ���� ���� �ش� �÷��� ���� ���� ���ǿ� ������� �ʾƾ� �Ѵ�.

-- EMPLOYEE ���̺��� DEPT_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT (DEPT_ID);

-- DEPARTMETN ���̺��� DEPT_ID�μ� �������� �ʴ� ������ UPDATE �� �� ����.
-- ���Ἲ ���� ������ �����Ѵ� (�θ� ����)
UPDATE 
       EMPLOYEE
  SET DEPT_CODE = '20'
 WHERE DEPT_CODE = 'D6';
 
-- NOT NULL ���� ���� ����
UPDATE
        EMPLOYEE
  SET EMP_NAME = NULL
 WHERE EMP_ID = '200';

-- DELETE : ���̺��� ���� �����ϴ� �����̴�. ���̺��� ���� ������ �پ���
-- DELETE FROM ���̺��� WHERE ����
-- ���� WHERE���� ������ �������� ������ ��� ���� �� ���� �ȴ�.
COMMIT;

DELETE 
  FROM EMPLOYEE;

SELECT
       E.*
  FROM EMPLOYEE E;
  
ROLLBACK;

DELETE 
  FROM EMPLOYEE
 WHERE EMP_NAME = '��ä��';

-- FK ���� ������ ���� �Ǿ� �ִ� ��� ���� �ǰ� �ִ� ���� ���ؼ��� ���� �Ұ�
-- �⺻ ���� ���� ���� �������� ���� �Ǿ� �ֱ� ����
DELETE
  FROM DEPARTMENT
 WHERE DEPT_ID = 'D1';
-- FK ���� ������ ���� �Ǿ� �־ ���� �ǰ� ���� ���� ���� ���ؼ��� ���� ����
DELETE
  FROM DEPARTMENT
 WHERE DEPT_ID = 'D3';
 
SELECT 
      D.*
  FROM DEPARTMENT D ;

ROLLBACK;

-- TRUNCATE : ���̺��� ��ü ���� ������ �� ����Ѵ�.
--            DELETE���� ���� �ӵ��� �� ������ ROLLBACK�� ���� ���� �� �� ����.
SELECT
       ES.*
  FROM EMP_SALARY ES;

COMMIT;

DELETE
  FROM EMP_SALARY;

SELECT
       ES.*
  FROM EMP_SALARY ES;

ROLLBACK;

SELECT
       ES.*
  FROM EMP_SALARY ES;

TRUNCATE TABLE EMP_SALARY;
         
SELECT
       ES.*
  FROM EMP_SALARY ES;  

ROLLBACK;

SELECT
       ES.*
  FROM EMP_SALARY ES;  
  
-- MERGE : ������ ���� �� ���� ���̺��� �ϳ��� ��ġ�� ����� �Ѵ�.
--         ���̺����� �����ϴ� ������ ���� �����ϸ� UPDATE
--         ������ ���� ������ INSERT��
CREATE TABLE EMP_M01
AS
SELECT E.* 
  FROM EMPLOYEE E;
  
CREATE TABLE EMP_M02
AS
SELECT E.*
  FROM EMPLOYEE E
 WHERE E.JOB_CODE = 'J4';

INSERT
  INTO EMP_M02 A
(
  A.EMP_ID, A.EMP_NAME, A.EMP_NO, A.EMAIL, A.PHONE
, A.DEPT_CODE, A.JOB_CODE, A.SAL_LEVEL, A.SALARY, A.BONUS
, A.MANAGER_ID, A.HIRE_DATE, A.ENT_DATE, A.ENT_YN
)
VALUES
(
  999, '�캰��', '000101-4567890', 'woo_bl@greedy.com', '01011112222'
, 'D9', 'J4', 'S1', 9000000, 0.5
, NULL, SYSDATE, NULL, DEFAULT
);

SELECT
       EM1.*
  FROM EMP_M01 EM1;
 
SELECT
       EM2.*
  FROM EMP_M02 EM2; 
 
UPDATE
       EMP_M02
   SET SALARY = 0;

MERGE
 INTO EMP_M01 M1
USING EMP_M02 M2
   ON (M1.EMP_ID = M2.EMP_ID)
 WHEN MATCHED THEN
UPDATE
   SET M1.EMP_NAME = M2.EMP_NAME
     , M1.EMP_NO = M2.EMP_NO
     , M1.EMAIL = M2.EMAIL
     , M1.PHONE = M2.PHONE
     , M1.DEPT_CODE = M2.DEPT_CODE
     , M1.JOB_CODE = M2.JOB_CODE
     , M1.SAL_LEVEL = M2.SAL_LEVEL
     , M1.SALARY = M2.SALARY
     , M1.BONUS = M2.BONUS
     , M1.MANAGER_ID = M2.MANAGER_ID
     , M1.HIRE_DATE = M2.HIRE_DATE
     , M1.ENT_DATE = M2.ENT_DATE
     , M1.ENT_YN = M2.ENT_YN
 WHEN NOT MATCHED THEN
INSERT
(
  M1.EMP_ID, M1.EMP_NAME, M1.EMP_NO, M1.EMAIL, M1.PHONE
, M1.DEPT_CODE, M1.JOB_CODE, M1.SAL_LEVEL, M1.SALARY, M1.BONUS
, M1.MANAGER_ID, M1.HIRE_DATE, M1.ENT_DATE, M1.ENT_YN
)
VALUES
(
  M2.EMP_ID, M2.EMP_NAME, M2.EMP_NO, M2.EMAIL, M2.PHONE
, M2.DEPT_CODE, M2.JOB_CODE, M2.SAL_LEVEL, M2.SALARY, M2.BONUS
, M2.MANAGER_ID, M2.HIRE_DATE, M2.ENT_DATE, M2.ENT_YN
);

SELECT
       EM.*
  FROM EMP_M01 EM;
