-- VIEW (��)
-- SELECT �������� ������ ��ü�� �������� �����͸� �����ϰ� ���� ���� ������ ���̺��̳�
-- ���̺��� ����ϴ� �Ͱ� �����ϰ� ����� �� �ִ�.
-- 1) ������ SELECT ���� �ٽ� �ۼ��� �ʿ䰡 ����.
-- 2) �ΰ��� �����͸� ���� �� �ִ�.

-- [ǥ����]
-- CREATE [OR REPLACE] VIEW ���̸� AS ��������;
-- [OR REPLACE] = �ߺ��Ǵ� �䰡 ������ �����.
-- ���, �̸�, ���޸�, �μ���, �ٹ������� ��ȸ�ϰ� �� ����� V_RESULT_EMP��� ��� ����
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

-- ���� ���� �������� �� ��ü ���� ������ �ο��Ǿ� ���� �ʾ� ������ ������ϴٴ� ������ �߻�
-- �ý��� �������� ��ȯ�Ͽ� �� ��ü ���� ������ �ο��� �� �۾��Ѵ�.
GRANT CREATE VIEW TO C##EMPLOYEE;  /* SYSTEM �������� ������ �ο��޴´�. */

SELECT
       V.*
  FROM V_RESULT_EMP V
 WHERE V.EMP_ID = '205';
 
-- ������ ��ųʸ�(Data Dictionary)
-- �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�
-- ����ڰ� ���̺��� �����ϰų�, ����ڸ� �����ϴ� ���� �۾��� �� �� �����ͺ��̽� ������
-- ���� �ڵ����� ���ŵǴ� ���̺�� ����ڴ� ������ ��ųʸ� ������ ���� �����ϰų� ������ �� �ִ�.
-- ���� ���̺��� Ŀ���͸���¡ �ؼ� �����ִ� ���� ���̺��� ���� ���̺�(VIEW)�̴�.

-- �信 ���� ������ Ȯ���ϴ� ������ ��ܳʸ�
SELECT
        UV.*
  FROM USER_VIEWS UV;
  
-- �信 ��Ī�� �ο��ؼ� ����
CREATE OR REPLACE VIEW V_EMP
(
  ���
, �̸�
, �μ�
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
  
-- �� ����
DROP VIEW V_EMP;

-- ���̽� ���̺��� ���� ����
COMMIT;

UPDATE 
        EMPLOYEE
    SET EMP_NAME = 'ȫ�浿'
 WHERE EMP_ID = '200';
 
SELECT
E.*
FROM EMPLOYEE E
WHERE EMP_ID = '200';

-- ���̽����̺��� ������ ���� �Ǹ� VIEW�� ���� ����ȴ�
SELECT
  V.*
  FROM V_RESULT_EMP V
 WHERE EMP_ID = '200';

ROLLBACK;

DROP VIEW V_RESULT_EMP;

-- �� �������� �ȿ� ������ ����� ������ �� ������
-- �� ���� �ݵ�� ��Ī�� �ο��ؼ� �����ؾ� �Ѵ�.
CREATE OR REPLACE VIEW V_EMP_JOB
(
  ���
, �̸�
, ����
, ����
, �ٹ����
)
AS
SELECT
        EMP_ID
      , EMP_NAME
      , JOB_NAME
      , DECODE(SUBSTR(EMP_NO, 8,1), 1, '��','��')
      , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
  FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE);
 
SELECT
       V.*
  FROM V_EMP_JOB V;
  
-- VIEW�� ���� DML ���� ���� �׽�Ʈ
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
,'����'
);

SELECT
   V.*
  FROM V_JOB V;
  
SELECT
   J.*
  FROM JOB J;

UPDATE 
        V_JOB V
  SET JOB_NAME = '�˹�'
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
  
-- DML ��ɾ�� VIEW ������ �Ұ����� ���
-- 1. �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
-- 2. �信 ���Ե��� ���� �÷� �߿�, ���̽��� �Ǵ� ���̺� �÷��� NOT NULL ���������� ���� �� ���
-- 3. ��� ǥ�������� ���� �� ���
-- 4. JOIN�� �̿��� ���� ���̺��� ������ ���
-- 5. DISTINCT�� ������ ���
-- 6. �׷��Լ��� GROUP BY���� ������ ���

-- �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW V_JOB2
AS
SELECT J.JOB_CODE
  FROM JOB J;

SELECT
       V.*
  FROM V_JOB2 V;
-- JOB_NAME �������� �ĺ��� ����
INSERT
  INTO V_JOB2
(
  JOB_CODE
, JOB_NAME
)
VALUES
(
  'J8'
, '����'
);
-- JOB_NAME �������� �ĺ��� ����
UPDATE
       V_JOB2 V
   SET V.JOB_NAME = '����'
 WHERE V.JOB_CODE = 'J7';
-- �� ���ǿ� ��� �� �÷��� ����ϹǷ� ���� ����
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
-- �� ���ǿ� ��� �� �÷��� ����Ͽ� DELETE ����
DELETE
  FROM V_JOB2
 WHERE JOB_CODE = 'J8';
  
-- �信 ���Ե��� ���� �÷� �߿� 
-- ���̽��� �Ǵ� ���̺� �÷��� NOT NULL ���������� ������ ���
CREATE OR REPLACE VIEW V_JOB3
AS
SELECT J.JOB_NAME
  FROM JOB J;
 
SELECT 
       V.*
  FROM V_JOB3 V;
-- JOB_CODE �� ���ǿ� ���� �������� �ĺ��� ����
INSERT
  INTO V_JOB3
(
  JOB_CODE
, JOB_NAME
)
VALUES
(
  'J8'
, '����'
);
-- JOB_CODE���� NULL�� ���� �� �� ���� ����
INSERT
  INTO V_JOB3
(
  JOB_NAME
)
VALUES
(
  '����'
);  
-- �信 ���� �� �÷����� ����� UPDATE ���� ����
UPDATE
       V_JOB3 V
   SET V.JOB_NAME = '����'
 WHERE V.JOB_NAME = '���';
 
-- ���ǥ�������� ���ǵ� ���
CREATE OR REPLACE VIEW EMP_SAL
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.SALARY
     , (E.SALARY + (E.SALARY * NVL(E.BONUS, 0))) * 12 ����
  FROM EMPLOYEE E;
 
SELECT
       ES.*
  FROM EMP_SAL ES;
-- ���ǥ�������� ���� �� ���� �÷� �������� INSERT �Ұ�
INSERT
  INTO EMP_SAL
(
  EMP_ID
, EMP_NAME
, SALARY
, ����
)
VALUES
(
  '800'
, '������'
, 3000000
, 4000000
);
-- ���ǥ�������� ���� �� ���� �÷� ������ UPDATE �Ұ�  
UPDATE
       EMP_SAL ES
   SET ES.���� = 80000000
 WHERE ES.EMP_ID = '200';

-- DELETE�� �������δ� ��� ����
DELETE
  FROM EMP_SAL ES
 WHERE ES.���� = 124800000;
 
ROLLBACK;
 
-- JOIN�� �̿��� ���� ���̺��� ������ ���
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
-- ���� �信 ���Ͽ� �ϳ� �̻��� �⺻ ���̺��� ������ �� �����ϴ�.
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
, '������'
, '�λ������'
);
-- Ű-�����Ȱ��� �ƴ� ���̺�� ������ ���� ������ �� �����ϴ�
UPDATE
       V_JOINEMP V
   SET V.DEPT_TITLE = '�λ������';
  
DELETE
  FROM V_JOINEMP V
 WHERE V.EMP_ID = '219';
  
SELECT
       V.*
  FROM V_JOINEMP V
 WHERE V.EMP_ID = '219';
 
ROLLBACK;
  
-- DISTINCT�� ������ ���
CREATE OR REPLACE VIEW V_DT_EMP
AS
SELECT DISTINCT E.JOB_CODE
  FROM EMPLOYEE E;
-- �信 ���� ������ ������ �������մϴ�
INSERT
  INTO V_DT_EMP
(
  JOB_CODE
)
VALUES
(
  'J9'
);
-- �信 ���� ������ ������ �������մϴ�
UPDATE
       V_DT_EMP V
   SET V.JOB_CODE = 'J9'
 WHERE V.JOB_CODE = 'J7';
-- �信 ���� ������ ������ �������մϴ�
DELETE
  FROM V_DT_EMP V
 WHERE V.JOB_CODE = 'J7';
 
-- �׷� �Լ��� GROUP BY ���� ������ ���
CREATE OR REPLACE VIEW V_GROUPDEPT
AS
SELECT E.DEPT_CODE
     , SUM(E.SALARY) �հ�
     , AVG(E.SALARY) ���
  FROM EMPLOYEE E
 GROUP BY E.DEPT_CODE;

SELECT
       V.*
  FROM V_GROUPDEPT V;
-- ���� ���� ����� �� �����ϴ�
INSERT
  INTO V_GROUPDEPT
(
  DEPT_CODE
, �հ�
, ���
)
VALUES
(
  'D0'
, 60000000
, 4000000
);
-- �信 ���� ������ ������ �������մϴ�
UPDATE
       V_GROUPDEPT V
   SET V.DEPT_CODE = 'D10'
 WHERE V.DEPT_CODE = 'D1';
-- �信 ���� ������ ������ �������մϴ�
DELETE
  FROM V_GROUPDEPT V
 WHERE V.DEPT_CODE = 'D1';

-- VIEW �ɼ�
-- ON REPLACE : ������ ������ �� �̸��� �����ϴ� ��� ����� �������� ������ ���� �����ϴ� �ɼ�
-- FORCE : ���� ������ ��� �� ���̺��� �������� �ʾƵ� �� �����ϴ� �ɼ�
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE
     , TNAME
     , TCONTENT
  FROM TT;

-- NOFORCE : ���������� ���̺��� �����ؾ߸� �並 �����ϴ� �ɼ�(�⺻��)
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP
AS
SELECT TCODE
     , TNAME
     , TCONTENT
  FROM TT;
  
-- WITH CHECK OPTION : �������� ��� �� �÷��� ���� �������� ���ϰ� �ϴ� �ɼ�
CREATE OR REPLACE VIEW V_EMP2
AS
SELECT
       E.*
  FROM EMPLOYEE E
 WHERE MANAGER_ID = '200'
 WITH CHECK OPTION;

-- ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
UPDATE 
      V_EMP2
  SET MANAGER_ID = '900'
  WHERE MANAGER_ID = '200';
  
-- WITH READ ONLY : DML ������ �Ұ����ϰ� �ϴ� �ɼ�
CREATE OR REPLACE VIEW V_DEPT
AS
SELECT
        D.*
  FROM DEPARTMENT D
  WITH READ ONLY;

-- �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.
DELETE
  FROM V_DEPT;
  









