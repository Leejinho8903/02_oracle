-- ���� ���� ���� ����
-- ���� ����(CREATE USER)
CREATE USER C##EMPLOYEE IDENTIFIED BY EMPLOYEE;
-- ���� �ο�(GRANT)
GRANT CONNECT, RESOURCE TO C##EMPLOYEE;
-- ���̺� �����̽� �ο�
ALTER USER C##EMPLOYEE QUOTA 100M ON USERS;

-- ���� ���� �� ���� �־��� ��� 
-- ���� ���� �� �ٽ� ��ɾ� ó������ ����
DROP USER C##EMPLOYEE CASCADE;

-------------------------------------------------------------------------------
-- ���� ���� ����
-- ���� ����(CREATE USER)
CREATE USER C##HOMEWORK IDENTIFIED BY HOMEWORK;
-- ���� �ο�(GRANT)
GRANT CONNECT, RESOURCE TO C##HOMEWORK;
-- ���̺� �����̽� �ο�
ALTER USER C##HOMEWORK QUOTA 100M ON USERS;
-------------------------------------------------------------------------------
-- GREDDY ���� ����
-- ���� ����(CREATE USER)
CREATE USER C##GREEDY1 IDENTIFIED BY GREEDY1;
-- ���� �ο�(GRANT)
GRANT CONNECT, RESOURCE TO C##GREEDY1;
-- ���̺� �����̽� �ο�
ALTER USER C##GREEDY1 QUOTA 100M ON USERS;

