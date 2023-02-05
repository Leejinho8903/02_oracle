-- 1. 4�� ���̺� ���Ե� ������ �� ���� ���ϴ� SQL ������ ����� SQL ������ �ۼ��Ͻÿ�.
SELECT 'SELECT COUNT(*) FROM '||TABLE_NAME||';' AS " "
FROM   USER_TABLES U
WHERE  TABLE_NAME IN ('TB_BOOK', 'TB_BOOK_AUTHOR', 'TB_PUBLISHER', 'TB_WRITER');

-- 2. 4�� ���̺��� ������ �ľ��Ϸ��� �Ѵ�. ���õ� ���ó�� TABLE_NAME, COLUMN_NAME, DATA_TYPE,
-- DATA_DEFAULT, NULLABLE, CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME ���� ��ȸ�ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_DEFAULT, NULLABLE, CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME
FROM USER_TAB_COLS
LEFT JOIN USER_CONS_COLUMNS USING (TABLE_NAME, COLUMN_NAME) 
LEFT JOIN USER_CONSTRAINTS USING  (TABLE_NAME, CONSTRAINT_NAME)
WHERE  TABLE_NAME IN ('TB_BOOK', 'TB_BOOK_AUTHOR', 'TB_PUBLISHER', 'TB_WRITER');

SELECT *
FROM USER_TAB_COLS; -- *** TABLE_NAME, COLUMN_NAME, DATA_TYPE,*** DATA_TYPE_MOD, DATA_TYPE_OWNER, DATA_LENGTH, DATA_PRECISION,
                    -- DATA_SCALE. ***NULLABLE,*** COLUMN_ID, DEFAULT_LENGTH, ***DATA_DEFAULT,*** NUM_DITINCT, LOW_VALUE, HIGH_VALUE,
                    -- DENSITY, NUM_NULLS, NUM_BUCKETS, LAST_ANALYZED, SAMPLE_SIZE, CHARACTER_SET_NAME, CHAR_COL_DEL_LENGTH,
                    -- GLOBAL_STATS, USER_STATS, AVG_COL_LEN, CHAR_LENGTH, CHAR_USED, V80_FMT_IMAGE, DATA_UPGRADED, HIDDEN_COLUMN,
                    -- VARTUAL_COLUMN, SEGMENT_COLUMN_ID, HISTROGRAM, QUALIFIED_COL_NAME

SELECT * 
FROM USER_CONS_COLUMNS; -- OWNER, ***CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME,*** POSITION

SELECT *
FROM USER_CONSTRAINTS; -- OWNER, ***CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, *** SEARCH_CONDITION, R_OWNER, 
                       -- *** R_CONSTRAINT_NAME, *** DELETE_RULE, STATUS, DEFERRABLE, DEFERRED, VALIDATED, GENERATED,
                       -- BAD, RELY, LAST_CHANCE, INDEX_OWNER, INDEX_NAME, INVALID, VIEW_RELATED


--3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT BOOK_NO, BOOK_NM
FROM   TB_BOOK
WHERE  LENGTH(BOOK_NM) >= 25; 

--4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
--�̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT *
FROM   ( SELECT WRITER_NM, 
                 OFFICE_TELNO, 
                 HOME_TELNO, 
                 MOBILE_NO
         FROM   TB_WRITER
         WHERE  WRITER_NM LIKE '��%'
         AND MOBILE_NO LIKE '019-%'
         ORDER BY 1 )
WHERE  ROWNUM = 1;
--�Ǵ�
SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM   ( SELECT WRITER_NM, 
                 OFFICE_TELNO, 
                 HOME_TELNO, 
                 MOBILE_NO,
                 RANK() OVER (ORDER BY WRITER_NM) AS RANK
         FROM   TB_WRITER
				 WHERE  WRITER_NM LIKE '��%'
				 AND    MOBILE_NO LIKE '019-%' )
WHERE   RANK = 1;				 

--5. ���� ���°� ���ű衱 �� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. ( ��� �����
--���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT COUNT(DISTINCT WRITER_NM)"�۰�(��)"
FROM   TB_WRITER
JOIN   TB_BOOK_AUTHOR USING  (WRITER_NO)
WHERE  COMPOSE_TYPE = '�ű�'; 

--6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ����
--���°� ��� ���� ���� ���� ������ ��)
SELECT  COMPOSE_TYPE, COUNT(*)
FROM   TB_BOOK_AUTHOR
WHERE  COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300
ORDER BY 2 DESC, 1; 

--7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM,
        ISSUE_DATE,
        PUBLISHER_NM
FROM   TB_BOOK
WHERE  ISSUE_DATE = (SELECT MAX(ISSUE_DATE)
                      FROM   TB_BOOK); 

--8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��, ��������( ��٣���) �۰��� ���ٰ� �����Ѵ�. ( ��� ����� ���۰� �̸���, �� �� ������ ǥ�� �ǵ��� �� ��)
SELECT *
FROM   (SELECT WRITER_NM AS "�۰� �̸�", 
                COUNT(*) AS "�� ��"
        FROM   TB_BOOK_AUTHOR
        JOIN   TB_WRITER USING (WRITER_NO)
        GROUP  BY WRITER_NM
        ORDER  BY 2 DESC)
WHERE  ROWNUM <= 3 ; 

--9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
-- ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
UPDATE TB_WRITER A
SET    REGIST_DATE = (SELECT MIN(ISSUE_DATE)
                       FROM   TB_BOOK_AUTHOR 
                       JOIN   TB_BOOK USING (BOOK_NO)
                       WHERE  A.WRITER_NO = WRITER_NO); 
COMMIT;								 
--10. ����  ��������  ����  ���̺���  ������  ��������  ����  ����  ���� �ϰ�  �ִ�.  �����δ�  ��������  ����  �����Ϸ�
--��  �Ѵ�.  ���õ�  ���뿡  �°� ��TB_BOOK_ TRANSLATOR��  ���̺���  �����ϴ� SQL  ������  �ۼ��Ͻÿ�.
-- (Primary Key  ����  ����  �̸��� ��PK_BOOK_TRANSLATOR�� ��  �ϰ�, Reference  ����  ����  �̸���
-- ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02�� ��  �� ��) 
CREATE TABLE TB_BOOK_TRANSLATOR
(
  WRITER_NO  VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER,
  BOOK_NO    VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK,
  TRANS_LANG VARCHAR2(60),
  CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);
--�Ǵ�
CREATE TABLE TB_BOOK_TRANSLATOR
(
  WRITER_NO  VARCHAR2(10) NOT NULL,
  BOOK_NO    VARCHAR2(10) NOT NULL,
  TRANS_LANG VARCHAR2(60)
);
ALTER TABLE TB_BOOK_TRANSLATOR
  ADD CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY (BOOK_NO, WRITER_NO);
ALTER TABLE TB_BOOK_TRANSLATOR
  ADD CONSTRAINT FK_BOOK_TRANSLATOR_01 FOREIGN KEY (BOOK_NO)
  REFERENCES TB_BOOK (BOOK_NO);
ALTER TABLE TB_BOOK_TRANSLATOR
  ADD CONSTRAINT FK_BOOK_TRANSLATOR_02 FOREIGN KEY (WRITER_NO)
  REFERENCES TB_WRITER (WRITER_NO);
	
-- �ּ��� Optional..
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO  IS '�۰� ��ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO  IS '���� ��ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG  IS '���� ���';

--11. ���� ���� ����(compose_type) �� ' �ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
-- ���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL
-- ������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. ( �̵��� �����ʹ� ��
-- �̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
INSERT INTO TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)
  SELECT BOOK_NO, WRITER_NO
  FROM   TB_BOOK_AUTHOR
  WHERE  COMPOSE_TYPE IN ('�ű�', '����', '��', '����'); 
DELETE FROM TB_BOOK_AUTHOR 
  WHERE  COMPOSE_TYPE IN ('�ű�', '����', '��', '����');
COMMIT; 

--12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����) �� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM, 
        WRITER_NM,
        ISSUE_DATE 
FROM   TB_WRITER
JOIN   TB_BOOK_TRANSLATOR USING  (WRITER_NO)
JOIN   TB_BOOK USING  (BOOK_NO)
WHERE  TO_CHAR(ISSUE_DATE, 'RRRR') = '2007'
ORDER BY 1; 

--13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
-- ������ �ۼ��Ͻÿ�. ( �� �̸��� ��VW_BOOK_TRANSLATOR�� �� �ϰ� ������, ������, ��������
-- ǥ�õǵ��� �� ��)

--GRANT CREATE VIEW TO fw;

CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR AS
SELECT BOOK_NM, 
       WRITER_NM 
FROM   TB_WRITER
JOIN   TB_BOOK_TRANSLATOR USING  (WRITER_NO)
JOIN   TB_BOOK USING  (BOOK_NO)
WHERE  TO_CHAR(ISSUE_DATE, 'RRRR') = '2007'
WITH CHECK OPTION; 

--14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
--������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)  
INSERT INTO TB_PUBLISHER(PUBLISHER_NM, PUBLISHER_TELNO) 
VALUES  ('�� ���ǻ�', '02-6710-3737'); 
COMMIT;

--15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�.
SELECT WRITER_NM, 
        COUNT(*)
FROM   TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) > 1; 

--16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
--NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
UPDATE TB_BOOK_AUTHOR 
SET    COMPOSE_TYPE='����'
WHERE  COMPOSE_TYPE IS NULL; 
COMMIT;

--17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ����(����?)�� 3�ڸ��� �۰���
--�̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, 
        OFFICE_TELNO
FROM   TB_WRITER
WHERE  OFFICE_TELNO LIKE '02-___-%'
ORDER BY 1; 

--18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, REGIST_DATE
FROM   TB_WRITER
WHERE  MONTHS_BETWEEN(TO_DATE('20060101','YYYY/MM/DD'), REGIST_DATE) >= 372
ORDER BY 1;

--19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���'
--���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯 ��, �������� ���ҷ������� �� ǥ�� �ϰ�,
--��������  ���� ��, ������ ������ ǥ�� �ǵ��� �Ѵ�.
SELECT BOOK_NM AS "������",
        PRICE AS "����",
      CASE
         WHEN STOCK_QTY < 5 THEN
          '�߰��ֹ��ʿ�'
         ELSE
          '�ҷ�����' 
       END "������" 
FROM   TB_BOOK
WHERE  PUBLISHER_NM = 'Ȳ�ݰ���'
AND    STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, 1; 

--20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. ( ��� �����
--��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT A.BOOK_NM AS "������",
       D.WRITER_NM AS "����",
       E.WRITER_NM AS "����"
FROM   TB_BOOK A
JOIN   TB_BOOK_AUTHOR B ON  (A.BOOK_NO = B.BOOK_NO)
JOIN   TB_BOOK_TRANSLATOR C ON  (A.BOOK_NO = C.BOOK_NO)
JOIN   TB_WRITER D ON  (D.WRITER_NO = B.WRITER_NO )
JOIN   TB_WRITER E ON  (E.WRITER_NO = C.WRITER_NO )
WHERE  BOOK_NM = '��ŸƮ��'; 
-- �Ǵ�
SELECT BOOK_NM,  "����",  "����"
FROM   (SELECT BOOK_NM,
               WRITER_NM "����"
        FROM   TB_BOOK
        JOIN   TB_BOOK_AUTHOR USING  (BOOK_NO)
        JOIN   TB_WRITER USING  (WRITER_NO)
        WHERE  BOOK_NM = '��ŸƮ��')
JOIN   (SELECT BOOK_NM,
               WRITER_NM "����"
        FROM   TB_BOOK
        JOIN   TB_BOOK_TRANSLATOR USING  (BOOK_NO)
        JOIN   TB_WRITER USING  (WRITER_NO)
        WHERE  BOOK_NM = '��ŸƮ��')
USING  (BOOK_NM); 
-- �Ǵ� 
-- �� �� �� ��츸 ���� 
SELECT BOOK_NM,
       (SELECT WRITER_NM
        FROM   TB_BOOK
        JOIN   TB_BOOK_AUTHOR USING  (BOOK_NO)
        JOIN   TB_WRITER USING  (WRITER_NO)
        WHERE  BOOK_NM = '��ŸƮ��') "����",
       (SELECT WRITER_NM
        FROM   TB_BOOK
        JOIN   TB_BOOK_TRANSLATOR USING  (BOOK_NO)
        JOIN   TB_WRITER USING  (WRITER_NO)
        WHERE  BOOK_NM = '��ŸƮ��') "����"
FROM   TB_BOOK
WHERE  BOOK_NM = '��ŸƮ��'; 

--21. ���� �������� ���� �����Ϸκ��� �� 30 ���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
-- ����, ���� ����, 20% ���� ������ ǥ�� �ϴ� SQL ������ �ۼ��Ͻÿ�. ( ��� ����� ��������, �����
-- ������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������
-- ������ ǥ�õǵ��� �� ��  
SELECT BOOK_NM AS "������", 
        STOCK_QTY AS "��� ����", 
				TO_CHAR(PRICE, '99,999') AS "����(Org)",
				TO_CHAR(PRICE*0.8, '99,999') AS "����(New)"
FROM   TB_BOOK
WHERE  MONTHS_BETWEEN(SYSDATE, ISSUE_DATE) >= 360
AND    STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;

-- �̷� ���  �� 30���� �ƴ�
--WHERE  TO_CHAR(SYSDATE,'yyyy') - TO_CHAR(ISSUE_DATE,'yyyy') >= 30
