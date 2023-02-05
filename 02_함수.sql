-- �Լ�(FUNCTION) : Į�� ���� �о ����� ����� �����Ѵ�.
-- ������(SINGLE ROW)�Լ� : �÷��� ��� �� N���� ���� �о N���� ����� ����
-- �׷� (GROUP)�Լ� : �÷��� ��� �� N���� ���� �о �� ���� ����� ����

-- ���� SELECT���� ������ �Լ��� �׷� �Լ��� �Բ� ����� �� ����.
-- ��� ���� ������ �ٸ���.

-- �׷� �Լ� : SUM, AVG, MAX, MIN, COUNT
-- SUM(���ڰ� ��ϵ� �÷���) : �հ踦 ���Ͽ� ����
SELECT 
       SUM(SALARY)
  FROM EMPLOYEE;
  
-- AVG(���ڰ� ��ϵ� �÷���) : ����� ���Ͽ� ����
SELECT 
       AVG(SALARY)
  FROM EMPLOYEE;
  
-- MAX(�÷���) : �÷����� ���� ū �� ����, ����ϴ� �ڷ����� ANY TYPE
SELECT 
       MAX(EMAIL)
     , MAX(HIRE_DATE)
     , MAX(SALARY)
  FROM EMPLOYEE;
  
-- MIN(�÷���) : �÷����� ���� ���� ���� ����, ����ϴ� �ڷ����� ANY TYPE
SELECT 
       MIN(EMAIL)
     , MIN(HIRE_DATE)
     , MIN(SALARY)
  FROM EMPLOYEE;
  
-- COUNT(* | �÷���) : ���� ������ ��Ʒ��� �����Ѵ�
-- COUNT([DISTINCT] �÷���) : �ߺ��� ������ �� ���� ����
-- COUNT(*) : NULL�� ������ ��ü �� ���� ����
-- COUNT(�÷���) : NULL�� ������ ���� ���� ��� �� �� ���� ����
SELECT 
       COUNT(*)
     , COUNT(DEPT_CODE)
     , COUNT(DISTINCT DEPT_CODE)
  FROM EMPLOYEE;

-- ������ �Լ�
-- ���� ���� �Լ�
-- : LENGTH, LENGTHB, SUBSTR, UPPER, LOWER, INSTR...
SELECT
       LENGTH('����Ŭ')
     , LENGTHB('����Ŭ')
  FROM DUAL;

SELECT
       LENGTH(EMAIL)
     , LENGTHB(EMAIL)
  FROM EMPLOYEE;
  
-- INSTR('���ڿ�' | �÷���, '����', ã�� ��ġ�� ���۰�, [��])
SELECT
       EMAIL
     , INSTR(EMAIL, '@', -1) ��ġ
  FROM EMPLOYEE; 
  
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;  
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL;
  
-- LPAD / RPAD : �־��� �÷� ���ڿ��� ������ ���ڿ��� ���ٿ�
--               ���� N�� ���ڿ��� ��ȯ�ϴ� �Լ�
SELECT
       LPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;
  
SELECT
       RPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;  

SELECT
       LPAD(EMAIL, 10)
  FROM EMPLOYEE;

SELECT
       RPAD(EMAIL, 10)
  FROM EMPLOYEE;

-- LTRIM / RTRIM : �־��� �÷��̳� ���ڿ� ����/�����ʿ���
--                 ������ ���� Ȥ�� ���ڿ��� ������ �������� ��ȯ�ϴ� �Լ��̴�.
SELECT LTRIM('   GREEDY') FROM DUAL;
SELECT LTRIM('   GREEDY', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123GREEDY', '123') FROM DUAL;
SELECT LTRIM('132123GREEDY123', '123') FROM DUAL;
SELECT LTRIM('ACABACGREEDY', 'ABC') FROM DUAL;
SELECT LTRIM('5782GREEDY', '0123456789') FROM DUAL;

SELECT RTRIM('GREEDY   ') FROM DUAL;
SELECT RTRIM('GREEDY   ', ' ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('GREEDY123123', '123') FROM DUAL;
SELECT RTRIM('123123GREEDY123', '123') FROM DUAL;
SELECT RTRIM('GREEDYACABAC', 'ABC') FROM DUAL;
SELECT RTRIM('GREEDY5782', '0123456789') FROM DUAL;

-- TRIM : �־��� �÷��̳� ���ڿ��� ��/�ڿ� ������ ���ڸ� ����
SELECT TRIM('   GREEDY   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;

-- SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ�κ��� ������ ������ ���ڿ���
--          �߶� �����ϴ� �Լ��̴�.
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('��� �� �� �Ӵ�', 2, 5) FROM DUAL;

-- �������� �ֹι�ȣ�� ��ȸ�Ͽ� �����, ����, ����, ������ ���� �и��Ͽ� ��ȸ
-- ��, �÷��� ��Ī�� �����, ����, ����, ���Ϸ� �Ѵ�
SELECT
       EMP_NAME AS �����
     , SUBSTR(EMP_NO,1, 2) AS ����
     , SUBSTR(EMP_NO,3, 2) "����"
     , SUBSTR(EMP_NO,5, 2) "����"
  FROM EMPLOYEE;
  
-- ��¥ �����Ϳ����� ����� �� �ִ�.
-- �������� �Ի��Ͽ����� �Ի�⵵, �Ի��, �Ի� ��¥�� �и��Ͽ� ��ȸ
SELECT
       EMP_NAME �̸�
     , HIRE_DATE 
     , SUBSTR(HIRE_DATE,1, 2) �Ի�⵵
     , SUBSTR(HIRE_DATE,4, 2) �Ի��
     , SUBSTR(HIRE_DATE,7, 2) "�Ի� ��¥"
  FROM EMPLOYEE;

-- WHERE�������� �Լ��� ����� �� �ִ�.
-- EMP_NO�� ���� ������ �Ǵ��Ͽ� ���� �������� ��� Į�� ������ ��ȸ�Ѵ�.
SELECT
       *
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO,8, 1 ) = '2';
 
-- WHERE������ ������ �Լ��� ��� �����ϴ�.
SELECT 
       *
  FROM EMPLOYEE
 WHERE AVG(SALARY) > 100;
 
-- �Լ� ��ø ��� ���� : �Լ� �ȿ��� �Լ��� ����� �� �ִ�.
-- �����, �ֹι�ȣ ��ȸ, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ� '-' ������ ���� '*'�� �ٲ� ���.
SELECT
       EMP_NAME
     , RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*')
  FROM EMPLOYEE;
-- �����, �̸���, �̸����� @ ���ĸ� ������ ���̵� ��ȸ
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1)
  FROM EMPLOYEE;
  
-- SUBSTRB : ����Ʈ ������ �����ϴ� �Լ�
SELECT 
       SUBSTR('ORACLE', 3, 2)
     , SUBSTRB('ORACLE', 3, 2)
  FROM DUAL;
  
SELECT 
       SUBSTR('����Ŭ', 2, 2)
     , SUBSTRB('����Ŭ', 4, 6)
  FROM DUAL;  

-- LOWER / UPPER / INITCAP : ��ҹ��� �������ִ� �Լ�
-- LOWER(���ڿ� | �÷�) : �ҹ��ڷ� �������ִ� �Լ�
SELECT
       LOWER('Welcome To My World')
  FROM DUAL;

-- UPPER(���ڿ� | �÷�) : �빮�ڷ� �������ִ� �Լ�
SELECT
       UPPER('Welcome To My World')
  FROM DUAL;

-- INITCAP(���ڿ� | �÷�) : �� ���ڸ� �빮�ڷ� �������ִ� �Լ�
SELECT
       INITCAP('welcome to my world')
  FROM DUAL;

-- CONCAT : ���ڿ� Ȥ�� �÷� �� ���� �Է� �޾� 
--          �ϳ��� ��ģ �� ����
SELECT
       CONCAT('�����ٶ�', 'ABCD')
  FROM DUAL;

SELECT
       '�����ٶ�' || 'ABCD'
  FROM DUAL;

-- REPLACE : �÷� Ȥ�� ���ڿ��� �Է� �޾� �����ϰ��� �ϴ� ���ڿ���
--           �����Ϸ��� �ϴ� ���ڿ��� �ٲ� �� ����
SELECT
       REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��')
  FROM DUAL;

-- ���� ó�� �Լ� : ABS, MOD, ROUND, FLOOR, TRUNC, CEIL
-- ABS(���� | ���ڷ� �� �÷���) : ���밪 ���ϴ� �Լ�
SELECT
       ABS(-10)
     , ABS(10)
  FROM DUAL;

-- MOD(���� | ���ڷ� �� �÷���, ���� | ���ڷ� �� �÷���)
-- : �� ���� ����� �������� ���ϴ� �Լ�
--   ó�� ���ڴ� ���������� ��, �� ��° ���ڴ� ���� ��
SELECT 
       MOD(10, 5)
     , MOD(10, 3)
  FROM DUAL;
  
-- ROUND(���� | ���ڷ� �� �÷���, [��ġ]) 
-- : �ݿø��ؼ� �����ϴ� �Լ�
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-- FLOOR(���� | ���ڷ� �� �÷���) : ����ó���ϴ� �Լ�
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(���� | ���ڷ� �� �÷���, [��ġ]) : ����ó��(����) �Լ�
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL(���� | ���ڷ� �� �÷���) : �ø� ó�� �Լ�
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

SELECT
       ROUND(123.456)
     , FLOOR(123.456)
     , TRUNC(123.456)
     , CEIL(123.456)
  FROM DUAL;
  
-- ��¥ ó�� �Լ�
-- SYSDATE : �ý����� ���� �Ǿ� �ִ� ��¥�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE  FROM DUAL;

-- MONTHS_BETWEEN(��¥, ��¥) : �� ��¥�� ���� �� ���̸� ���ڷ� ����
SELECT
       EMP_NAME
     , HIRE_DATE
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) 
  FROM EMPLOYEE;
  
-- ADD_MONTHS(��¥, ����) : ��¥�� ���ڸ�ŭ ���� �� ���ؼ� ��¥�� ����
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;
  
-- �ٹ������ 20�� �̻��� ������ ��� �÷� ��ȸ
SELECT
       *
  FROM EMPLOYEE
-- WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
 WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;
 
-- NEWT_DAY(���س�¥, ����(���� | ����)) : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥ ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- ���ڴ� 1~7�̸� �Ͽ��Ϻ��� �����Ѵ�.
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;

-- �ý��� ȯ�濡 ���� ��� �����Ǿ� �����Ƿ� ������ ���ϸ� ������ �����ؼ� ����Ѵ�.
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY(��¥) : �ش� ���� ������ ��¥�� ���Ͽ� ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- �����, �Ի���, �Ի��� ���� �ٹ��ϼ�(�ָ� ����)
SELECT 
       EMP_NAME
     , HIRE_DATE
     , LAST_DAY(HIRE_DATE) - HIRE_DATE +1 "�Ի���� �ٹ��ϼ�"
  FROM EMPLOYEE;
  
-- EXTRACT : ��, ��, �� ������ �����Ͽ� �����ϴ� �Լ�
-- EXTRACT(YEAR FROM ��¥) : �⵵�� ����
-- EXTRACT(MONTH FROM ��¥) : ���� ����
-- EXTRACT(DAY FROM ��¥) : �ϸ� ����
SELECT 
       EXTRACT(YEAR FROM SYSDATE) �⵵
     , EXTRACT(MONTH FROM SYSDATE) ��
     , EXTRACT(DAY FROM SYSDATE) ��
  FROM DUAL;
  
-- ������ �̸�, �Ի���, �ٹ���� ��ȸ
-- �ٹ������ ����⵵ - �Ի�⵵�� ��ȸ�Ѵ�.
SELECT
       EMP_NAME
     , HIRE_DATE
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
  FROM EMPLOYEE;

-- �ٹ������ ������ ����ϴ� ��쿡�� ���� ���̸� ����ؾ� �Ѵ�
SELECT
       EMP_NAME
     , HIRE_DATE
     , FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) "�� �ٹ����"
  FROM EMPLOYEE;
-- ����ȯ �Լ� ------------------------------------------------------------------
-- TO_CHAR(��¥, [����]) : ��¥�� �����͸� ������ �����ͷ� ���� ---------------------
-- TO_CHAR(����, [����]) : ������ �����͸� ������ �����ͷ� ����
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, '00000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, '00,000') FROM DUAL;
SELECT TO_CHAR(1234, '999') FROM DUAL;

-- ���� ���̺��� �����, �޿� ��ȸ
-- �޿��� '\9,000,000' �������� ǥ���ϼ���
SELECT
      EMP_NAME
     ,TO_CHAR(SALARY, 'L99,999,999')
     FROM EMPLOYEE;

-- ��¥ ������ ���� ���� �ÿ��� TO_CHAR �Լ� ���
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') �Ի���
  FROM EMPLOYEE;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') �Ի���
  FROM EMPLOYEE;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') ���Ի���
  FROM EMPLOYEE;

-- ���� ��¥�� ���� �⵵ 4�ڸ�, �⵵ 2�ڸ�,
-- �⵵ �̸����� ���
SELECT
       TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'RRRR')
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RR')
     , TO_CHAR(SYSDATE, 'YEAR')
  FROM DUAL;

-- RR�� YY�� ����
-- RR�� ���ڸ� �⵵�� ���ڸ��� �ٲ� �� �ٲ� �⵵�� 50�� �̸��̸� 2000���� �����ϰ�
-- 50�� �̻��̸� 1900���� �����Ѵ�.
-- YY�� �⵵�� �ٲ� �� ���� ����(2000��)�� �����Ѵ�.

SELECT
       TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYRR-MM-DD')
  FROM DUAL; 

SELECT
       TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD')
  FROM DUAL; 
  
-- ���� ��¥���� ���� ���
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
  FROM DUAL;
  
-- ���� ��¥���� �ϸ� ���
SELECT
       TO_CHAR(SYSDATE, '"1�� ���� " DDD"�� °"')
     , TO_CHAR(SYSDATE, '"�� ���� " DD"�� °"')
     , TO_CHAR(SYSDATE, '"�� ���� " D"�� °"')
  FROM DUAL;
  
-- ���� ��¥���� �б�� ���� ��� ó��
SELECT
       TO_CHAR(SYSDATE, 'Q"�б�"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;
  
-- EMPLOYEE ���̺��� �̸�, �Ի��� ��ȸ
-- �Ի��� ������ '2018�� 6�� 15�� (��)' �������� ��� ó�� �ϼ���
SELECT
      EMP_NAME
     ,TO_CHAR(HIRE_DATE, 'YYYY"��" FMMM"��" DD"��" (DY)')
     FROM EMPLOYEE;
     
-- TO_DATE : ���� Ȥ�� ������ �����͸� ��¥�� �����ͷ� ��ȯ�Ͽ� ���� ------------------
-- TO_DATE(������������, [����]) 
-- TO_DATE(������������, [����])
SELECT
       TO_DATE('20100101', 'RRRRMMDD')
  FROM DUAL;

SELECT
       TO_CHAR(TO_DATE('20100101', 'RRRRMMDD'), 'RRRR, MON')
  FROM DUAL;
  
SELECT
       TO_DATE('041030 143000', 'RRMMDD HH24MISS')
  FROM DUAL;

SELECT
       TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
  FROM DUAL;

-- EMPLOYEE ���̺��� 2000�⵵ ���Ŀ� �Ի��� �����
-- ���, �̸�, �Ի����� ��ȸ�ϼ���
SELECT
       EMP_ID
      ,EMP_NAME
      ,HIRE_DATE
      FROM EMPLOYEE
-- WHERE HIRE_DATE >= TO_DATE('20000101', 'RRRRMMDD');
  WHERE HIRE_DATE >= '20000101'; -- ���ڿ��� ��¥�� �ڵ� ����ȯ �ȴ�
--WHERE HIRE_DATE >= TO_DATE(20000101, 'RRRRMMDD');
-- WHERE HIRE_DATE >= 20000101; -- ���ڴ� ��¥�� �ڵ� ����ȯ ���� �ʴ´�
-- TO_NUMBER(���ڵ�����, [����]) : ���� �����͸� ���ڷ� ���� ------------------------
SELECT TO_NUMBER('123456789') FROM DUAL;

-- �ڵ�����ȯ
SELECT '123' + '456' FROM DUAL;
-- ���ڷ� �� ���ڿ��� �����ϴ�
SELECT '123' + '456A' FROM DUAL;

SELECT
       EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE HIRE_DATE = '90/02/06';   -- �ڵ� ����ȯ

-- EMPLOYEE ���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT
       *
  FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2) = 1; -- �ڵ� ����ȯ

SELECT '1,000,000' + '500,000' FROM DUAL;

SELECT 
       TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999')
  FROM DUAL;

-- ���� ���̺��� �����ȣ�� 201�� ����� �̸�, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�,
-- �ֹι�ȣ ���ڸ��� ���ڸ��� ���� ��ȸ�ϼ���. ��, �ڵ� ����ȯ ������� �ʰ� ��ȸ
SELECT
       EMP_NAME
     , EMP_NO
     , SUBSTR(EMP_NO, 1,6) ���ڸ�
     , SUBSTR(EMP_NO, 8) ���ڸ�
     , TO_NUMBER(SUBSTR(EMP_NO, 1,6)) + TO_NUMBER(SUBSTR(EMP_NO, 8)) ���
 FROM EMPLOYEE
 WHERE EMP_ID = TO_CHAR(201);
 
 
-- NULL ó�� �Լ� -------------------------------------------------
-- NVL(�÷���, �÷����� NULL�϶� �ٲ� ��)
SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
  FROM EMPLOYEE;
  
-- NVL2(�÷���, �ٲܰ�1, �ٲܰ�2)
-- �ش� �÷��� ���� ������ �ٲܰ�1�� ����, �ش� �÷��� NULL�̸� �ٲܰ�2�� ����

-- ���ʽ� ����Ʈ�� NULL�� ������ 0.5�� ���ʽ� ����Ʈ�� NULL�� �ƴ� ������ 0.7�� �����Ͽ� ��ȸ
SELECT
       EMP_NAME
     , BONUS
     , NVL2(BONUS, 0.7, 0.5)
  FROM EMPLOYEE;

-- �����Լ� : ���� ���� ��� ������ �� �ִ� ����� ����
-- DECODE(���� | �÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2 ...)

-- ������ �����Ͽ� '��' �Ǵ� '��'�� ��ȸ
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��')
  FROM EMPLOYEE;

-- ������ ���ڷ� ���� �� ���� ���� ���� �ۼ��ϸ� �ƹ��� ���ǿ� �ش����� ���� ��
-- �������� �ۼ��� ���� ���� ������ �����Ѵ�.
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '��') ����
  FROM EMPLOYEE;
  
-- ������ �޿��� �λ��ϰ��� �Ѵ�.
-- ���� �ڵ尡 J7�� ������ �޿��� 10%, J6�� ������ 15%, J5�� ������ 20%�� �λ��ϰ�
-- �� �� ������ ������ 5%�� �λ��Ѵ�. ������, �����ڵ�, �޿�, �λ�޿�(�� ����) ��ȸ
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                              SALARY * 1.05)
  FROM EMPLOYEE;

/*
       CASE
         WHEN ���ǽ� THEN �����
         WHEN ���ǽ� THEN �����
         ELSE �����
        END
*/        

-- �޿��� 500������ �ʰ��ϸ� '���'. 300~500 ���̸� '�߱�', �� ���ϴ� '�ʱ�'���� ���
-- ó���ϰ� ��Ī�� '����'���� �Ѵ�.
SELECT
       EMP_NAME
     , SALARY
     , CASE
        WHEN SALARY > 5000000 THEN '���'
        WHEN SALARY BETWEEN 3000000 AND 5000000 THEN '�߱�'
        ELSE '�ʱ�'
    END ����
  FROM EMPLOYEE;  



