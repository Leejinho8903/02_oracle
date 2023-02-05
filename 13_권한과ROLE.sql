-- ���Ѱ� ROLED

-- ����� ���� : ������� ������ ��ȣ ����, ���� �ο�
-- ������ ���� ������ ���̽� ������ : ����ڰ� ������ ���̽��� ��ü(���̺�, �� ��)��
-- ���� Ư�� ������ ���� �� �ֱ� �ϴ� ������ �ִ�. �ټ��� ����ڰ� �����ϴ� �����ͺ��̽�
-- ������ ���� ���� ������ �Ѵ�.

-- 1. �ý��� ���� : �����ͺ��̽� �����ڰ� ������ �ִ� �������� ����Ŭ ����, ���̺�, ��, �ε��� ���� ���� ����.
-- CREATE USER(����� ���� �����), DROP USER(����� ���� ����) ���
-- CREATE SESSION(�����ͺ��̽��� ����), CREATE TABLE(���̺� ����), CREATE VIEW(�� ����) ���

-- <�ý��� �������� ����>
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;

-- ������ SAMPLE �������� ���� �õ� �� ���� ����(CREATE SESSION)�� ��� ���� �Ұ�
-- <�ý��� �������� ����>
GRANT CREATE SESSION TO C##SAMPLE;

--<���� �������� ����>
CREATE TABLE TEST_TABLE(
 COL1 VARCHAR2(20),
 COL2 NUMBER
);

-- ���̺� ���� ������ ���� ���� �Ұ��ϹǷ� ������ �ο��Ѵ�
-- <�ý��� �������� ����>
GRANT CREATE TABLE TO C##SAMPLE;

-- WITH ADMIN OPTION
-- : ����ڿ��� �ý��� ������ �ο��� �� ����Ѵ�.
--   ������ �ο����� ����ڴ� �ٸ� ����ڿ��� ������ ������ �� �ִ�.

-- <�ý��� �������� ����> �ý��۰����� C##SAMPLE�������� ���ӱ����� �ο��� ��
GRANT CREATE SESSION TO C##SAMPLE
WITH ADMIN OPTION;

-- C##SAMPLE2 ���� ���� (�ý��� ��������)
CREATE USER C##SAMPLE2 IDENTIFIED BY SAMPLE2;

-- <���� �������� ����>
-- WITH ADMIN OPTION���� �ο� ���� CREATE SESSION�� �ٸ� ����ڿ��� �ο� �����ϳ�
-- �� ���� ������ �ο��� �� �ִ� ������ ����.
GRANT CREATE SESSION TO C##SAMPLE2;
GRANT CREATE TABLE TO C##SAMPLE2;

-- 2. ��ü ���� : ����ڰ� Ư�� ��ü(���̺�, ��, ������, ...)�� �����ϰų� ������ �� �ִ� ����
/*
    DML(SELECT/INSERT/DELETE)
    GRANT ���� ���� [(�÷���)] | ALL
    ON ��ü�� | ROLE �̸� 
    TO ����ڸ� | PUBLIC
*/

-- WITH GRANT OPTION
-- : ����ڰ� Ư�� ��ü�� �����ϰų� ������ �� �ִ� ������ �ο� �����鼭
--   �� ������ �ٸ� ����ڿ��� �ٽ� �ο��� �� �ִ� ���� �ɼ�

GRANT SELECT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE
WITH GRANT OPTION;

-- <���� �������� ����>
-- ��ȸ ������ �ο� �޾ұ� ������ SAMPLE ���������� EMPLOYEE ���̺� ��ȸ�� �����ϴ�.
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;

-- WITH GRANT OPTION���� �ο� ���� SELECT ������ �ٸ� �������� �ο� �����ϳ�
-- �� ���� ������ �ο��� �� ����.
GRANT SELECT ON C##EMPLOYEE.EMPLOYEE  TO C##SAMPLE2;
GRANT INSERT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE2;

-- REVOKE : ���� öȸ
REVOKE SELECT ON C##EMPLOYEE.EMPLOYEE FROM C##SAMPLE;

-- <���� �������� ����>
-- ������ ȸ�� �߱� ������ ���̺� ��ȸ�� �Ұ����ϴ�.
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;

-- ����
-- WITH GRANT OPTION�� REVOKE�� �ٸ� ����ڿ��Ե� �ο��� ������ ���� ȸ���Ѵ�.
-- WITH ADMIN OPTION�� Ư�� ������� ���Ѹ� ȸ���ǰ� ������ �ٸ� ����ڿ��� �ο���
-- ������ ȸ�� ���� �ʴ´�.

-- ������ ���̽� ROLE
-- : ����ڸ��� ������ ������ �ο��ϴ� ���� ���ŷӱ� ������ �����ϰ� ������ �ο��� �� �ִ� ������� ROLE ����
-- ROLE
-- : ���� ���� ������ ���� ���� ��
--   ����ڿ��� �ο��� ������ �����ϰ��� �� ���� �� �Ѹ� �����ϸ� �ش� ���� ������ �ο� ����
--   ����ڵ��� ������ �ڵ����� �����ȴ�.

SELECT
        GRANTEE
      , PRIVILEGE
  FROM DBA_SYS_PRIVS
-- WHERE GRANTEE = 'RESOURCE';
 WHERE GRANTEE = 'CONNECT';

-- ���� ����
-- 1. ���� ���� �� �� : ����Ŭ ��ġ �� �ý��ۿ��� �⺻������ ���� ��
-- EX) CONNECT, RESOURCE

-- 2. ����ڰ� �����ϴ� ��
-- : CREATE ROLE ������� ���� �����Ѵ�.
--   �� ������ �ݵ�� DBA ������ �ִ� ����ڸ� �� �� �ִ�.
-- CREATE ROLE ���̸�; -- 1. �ѻ���
-- GRANT �������� TO ���̸�; --2. ���� �� �ѿ� ���� �߰�
-- RANT ���̸� TO ����ڸ�; --3. ����ڿ��� �� �ο�

CREATE ROLE C##MYROLE;
GRANT CREATE VIEW, CREATE SEQUENCE TO C##MYROLE;
GRANT C##MYROLE TO C##SAMPLE;

-- C##MYROLE�� ���� Ȯ��
SELECT
        GRANTEE
      , PRIVILEGE
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE = 'C##MYROLE';
 
-- C##SAMPLE �������� �� ���� Ȯ��
SELECT
        DRP.*
  FROM DBA_ROLE_PRIVS DRP
 WHERE GRANTEE = 'C##SAMPLE';
 
-- <���� �������� ����> : ���� ���� �� �������Ͽ� �׽�Ʈ�ϸ� ��ü ���� ������
CREATE SEQUENCE SEQ_TEST;
