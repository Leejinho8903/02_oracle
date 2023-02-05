-- SEQUENCE (������)
-- �ڵ� ��ȣ �߻��� ������ �ϴ� ��ü
-- ���������� ���� ���� �ڵ����� �������ش�.
/*
CREATE SEQUENCE ��������
[INCREMENT BY ����] -- ���� ���� ���� ����ġ, �����ϸ� �ڵ� 1�� �⺻
[START WITH ����] -- ó�� �߻���ų �� ����, �����ϸ� �ڵ� 1�� �⺻
[MAXVALUE ���� | NOMAXVALUE] -- �߻���ų �ִ� �� ����(10�� 27��)
[MINVALUE ���� | NOMINVALUE] -- �߻���ų �ּ� �� ����(-10�� 26��)
[CYCLE | NOCYCLE] -- �� ��ȯ ����
[CACHE ����Ʈũ�� | NOCACHE] -- ĳ�� �޸� �⺻ ���� 20����Ʈ, �ֽ��� 2����Ʈ
*/
CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- ��������.CURRVAL : �ش� �������� ������ �ִ� CURRENT VALUE(���� ��)
-- ��������.NEXTVAL : �ش� �������� ���� NEXTVALUE(���� ��) ����
-- NEXTVAL�� 1ȸ �����ؾ� CURRVAL�� �� �� �ִ�.
SELECT SEQ_EMPID.CURRVAL FROM DUAL;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --310
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- MAXVALUE�� �Ѿ�� ���� �߻�

-- ������ ��ųʸ��� ���� ������� SEQUENCE ��ȸ
SELECT * FROM USER_SEQUENCES;

-- ������ ����
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

-- START WITH ���� ���� �Ұ����̹Ƿ� �ش� ���� �����Ϸ��� DROP���� ���� �� �ٽ� �����Ѵ�.
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --320
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --320
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --330
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --330

-- ������ ��ü�� ���� ���� ����ϴ� �뵵�� ���̺��� �ĺ���(PK)�� ����ϴ� ���̴�.
CREATE SEQUENCE SEQ_EID
 START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

INSERT
  INTO EMPLOYEE
VALUES
(
  SEQ_EID.NEXTVAL, 'ȫ�浿', '660101-1111111', 'hong_gd@greedy.com', '01012345678',
  'D2', 'J7', 'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT
);

SELECT
    E.*
  FROM EMPLOYEE E;
  
ROLLBACK;

-- ������ ����
DROP SEQUENCE SEQ_EMPID;