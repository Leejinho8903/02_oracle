-- INDEX(�ε���)
-- : SQL ��ɹ��� �˻� ó�� �ӵ��� ����Ű�� ���� �÷��� ���� �����ϴ� ����Ŭ ��ü
--   �ϵ� ��ũ�� � ��ġ�� ���� ������ ���� �ּҷ����� �ε����� DATA�� ROWID�� �����Ǿ� �ִ�.

-- ROWID�� ���� : ������Ʈ ��ȣ, ������� ��ȣ, ��� ��ȣ, ������ ��ȣ
SELECT
        ROWID
      , EMP_ID
      , EMP_NAME
    FROM EMPLOYEE;

-- �ε����� ���� ������ ���� Ʈ�� �������� �����Ǿ� �ִ�. (����)
-- �ε����� �����ϱ� ���ؼ��� �ð��� �ʿ��ϸ� �ε����� ���� �߰� ���� ������ �ʿ��ϱ� ������
-- �׻� ������ �ִ� ���� �ƴϴ�. �ε����� ���� �� �÷����� DML �۾��� ����� ��� ó�� �ӵ��� ��������.


-- �ε����� �����ϴ� ������ ��ųʸ�
-- PK, UNIQUE ���������� �ɸ� �÷��� �ڵ����� INDEX ��ü�� ������ �ȴ�.
SELECT
        UIC.*
    FROM USER_IND_COLUMNS UIC;
    
-- �ε����� ����
-- 1. ���� �ε���(UNIQUE INDEX)
-- 2. ����� �ε���(NOUNIQUE INDEX)
-- 3. ���� �ε���(SINGLE INDEX)
-- 4. ���� �ε���(COMPSITE INDEX)
-- 5. �Լ� ��� �ε���(FUNCTION BASED INDEX)

-- UNIQUE INDEX
-- ���� �ε����� ���� �� �÷����� �ߺ� ���� ���� �� �� ������
-- PK, UNIQUE ���� ������ �����ϸ� �ڵ����� �ش� �÷��� UNIQUE INDEX�� ���� �ȴ�.
-- �ش� �÷����� ACCESS �ϴ� ��� ���� ����� ȿ���� �ִ�.

-- �ε��� ��Ʈ
-- �Ϲ������δ� ��Ƽ�������� ������ �ε����� Ÿ�ų� Ǯ ��ĳ�� �ؼ� ����� ���� ���
-- ȿ������ ����� �����Ѵ�. ������ �츮�� ���ϴ� ���̺� �ִ� �ε����� ����� �� �ֵ���
-- �ϴ� ����(��Ʈ)�� ���ؼ� �����Ҽ��� �ִ�. SELECT�� ù �ٿ� ��Ʈ �ּ�(/*+ ���� */)DMF
-- �ۼ��Ͽ� ������ �ε����� �ο��� �� �ִ�.
SELECT /*+ INDEX(E ����Ƽ1_PK)*/
        E.*
  FROM EMPLOYEE E;
  
-- �ε��� �������� ���������� ��ĵ�϶�� �ǹ�(INDEX_DESC)
SELECT /*+ INDEX_DESC(E ����Ƽ1_PK)*/
        E.*
  FROM EMPLOYEE E;

-- �ߺ� ���� ���� �÷��� UNIQUE �ε����� ������ �� �ִ�.
CREATE UNIQUE INDEX IDX_EMPNO
ON EMPLOYEE(EMP_NO);

-- �ߺ� ���� �ִ� �÷��� UNIQUE �ε����� �������� ���Ѵ�.
CREATE UNIQUE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- NONUNIQUE INDEX(����� �ε���)
-- WHERE������ ����ϰ� ���Ǵ� �Ϲ� �÷��� ������� �����Ѵ�.
CREATE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- COMPOSITE INDEX(���� �ε���)
-- ���� �ε����� �ߺ� ���� ���� ���� ���� ���� ���� �˻� �ӵ��� ��� ��Ų��.
CREATE INDEX IDX_DEPT
ON DEPARTMENT(DEPT_ID, DEPT_TITLE);

SELECT /*+ INDEX_DESC(D IDX_DEPT)*/
       D.DEPT_ID
  FROM DEPARTMENT D 
 WHERE D.DEPT_TITLE > '0'
   AND D.DEPT_ID > '0';

-- �Լ� ��� �ε���
-- SELECT���̳� WHERE������ ��� �����̳� �Լ��� ��� �� ��� ��꿡 ���Ե� �÷���
-- �ε����� ������ ���� �ʴ´�. �������� �˻��ϴ� ��찡 ���ٸ�, �����̳� �Լ�������
-- �̷���� �÷��� �ε����� ������� �ִ�.
CREATE INDEX IDX_EMP_SALCALC
ON EMPLOYEE((SALARY + (SALARY * NVL(BONUS,0))) * 12);

SELECT /*+ INDEX_DESC(E IDX_EMP_SALCALC)*/
        E.EMP_ID
      , E.EMP_NAME
      , (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 ����
  FROM EMPLOYEE E
 WHERE (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 > 1000000;
 
-- �ε����� ����
-- �˻� �ӵ� ���, �ý��� ���ϸ� �ٿ�(FULL SCAN�� ���� �����Ƿ�) �ý��� ���� ���

-- �ε����� ����
-- �߰� ���� ����, ���� �ð� �ʿ�
-- DML�� ����ϸ� REBUILD �۾��� �ֱ������� �ؾ� �ϸ� REBUILD ���� ������ ������ ���� ����

-- �Ϲ������� ������ ��ü �ο��� 15% ������ �����͸� ��ȸ�� �� �ε����� �����ؼ� ����Ѵ�.