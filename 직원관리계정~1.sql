-- �޿��� 200�����̻��� ����� ���ʽ��� �������ϴ� �����ڵ尡 J7����� ã�´�
SELECT
       EMP_NAME
      ,JOB_CODE
      ,SALARY 
      ,BONUS
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J7'
   AND BONUS IS NULL
   AND SALARY >= 2000000;

-------
SELECT 
        V2.RNUM
      , V2.EMP_NAME
      , V2.JOB_CODE
      , V2.DEPT_CODE
      , V2.SALARY
  FROM (SELECT
                ROWNUM RNUM
              , V.EMP_NAME
              , V.SALARY
              , V.DEPT_CODE
              , V.JOB_CODE
            FROM (SELECT E.*
                    FROM EMPLOYEE E 
                    ORDER BY E.SALARY DESC) V
                    
                    )V2
                    WHERE RNUM = 2;
---------------------------------------------------
SELECT
        EMP_NAME
      , JOB_NAME
      , DEPT_TITLE
      , LOCAL_NAME
      , NATIONAL_NAME
      , SALARY * 12
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING(NATIONAL_CODE)
 WHERE JOB_NAME = '���'
   AND LOCAL_NAME LIKE 'ASIA%'
   AND NATIONAL_NAME = '�ѱ�';
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
     , N.NATIONAL_NAME
     , E.SALARY *12
 FROM EMPLOYEE E 
     ,DEPARTMENT D 
     ,LOCATION L
     ,JOB J
     ,NATIONAL N
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND L.NATIONAL_CODE = N.NATIONAL_CODE
   AND J.JOB_NAME = '���'
   AND L.LOCAL_NAME LIKE 'ASIA%'
   AND N.NATIONAL_NAME = '�ѱ�';
----------------------------------------------
SELECT
        EMP_NAME
       ,JOB_NAME
       ,HIRE_DATE
       ,AVG(SALARY)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) > 20
 GROUP BY EMP_NAME,JOB_NAME,HIRE_DATE
 HAVING ROUND (AVG(SALARY)) >= 3000000
 ORDER BY 2;
-------------------------------------------------------------
-- 2. �Լ� Ȱ�� ����
-- 2023�� ���� ���� �ǰ����� ����� [�� 20�� �̻�, ����⵵ ���ڸ��� Ȧ���� ��] �Դϴ�.
-- ���� �� 65�� �̻��� ���� ��󿡼� ���� �˴ϴ�.
	-- 2023�� �ǰ����� ����� ������� ���, �̸�, ����, ���̸� ��ȸ�ϼ���.
-- ��, ���̴� ������������ ����մϴ�.
-- �������� "�����ȣ", "�̸�", "����", "����"�� �մϴ�.
-- "������", "������", "����"�� �����ʹ� ���ܽ�ŵ�ϴ�.
SELECT
       EMP_ID �����ȣ
      ,EMP_NAME �̸�
      ,SUBSTR(EMP_NO,1,2) ����
      ,FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(EMP_NO,1,6),'YYYYMMDD')) / 12) ����
    FROM EMPLOYEE
    WHERE MOD(SUBSTR(EMP_NO,1,2),2) != 0
     AND MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(EMP_NO,1,6),'YYYYMMDD')) / 12 >= 20
     AND MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(EMP_NO,1,6),'YYYYMMDD')) / 12 < 65
     AND EMP_NAME NOT IN ('������' , '������' , '����')
   ORDER BY ���� DESC;
   
-----------------------------------------------
SELECT 
      EMP_NAME
     ,PHONE
     ,SALARY
     ,DEPT_CODE
 FROM EMPLOYEE
 WHERE PHONE LIKE '%5'
   AND SALARY BETWEEN 2000000 AND 3000000
   AND DEPT_CODE IS NULL;
SELECT
      EMP_NAME
     ,EMP_NO
     ,HIRE_DATE
     ,FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE) / 12) ����
    FROM EMPLOYEE
    WHERE SUBSTR(EMP_NO,1,2) >= '80'
      AND SUBSTR(EMP_NO,1,2) <= '90'
ORDER BY ���� DESC;

   
   
 
 

 
 
