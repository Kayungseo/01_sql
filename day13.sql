--day 13

---------------------------------------------------
--����Ŭ�� Ư���� �÷� 2���� 
-- : ����ڰ� ���� �� ��� �ڵ����� �����Ǵ� �÷� 

--1. ROWID : ���������� ��ũ�� ����� ��ġ�� ����Ű�� �� 
--           ������ ��ġ�̹Ƿ� �� ��� �ݵ�� ������ ���� �� �ۿ� ���� 
--           ORDER BY ���� ���� ������� �ʴ� �� *

--2. ROWNUM : ��ȸ�� ����� ù��° ����� 1�� �����ϴ� �� 
----------------------------------------------------

--��)emp ���̺��� 'SMITH' ��ȸ
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
--ROWID ���� ��ȸ/���������� ����Ŭ�� �ؼ��� �� �ִ� ��ġ�� ���̽��� �����Ͱ� ����ִ�
SELECT ROWID 
     , e.empno
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
/*
AAASHsAAHAAAACWAAA	7369	SMITH
*/

SELECT ROWNUM 
     , e.ename
  FROM emp e
 WHERE e.ename = 'SMITH'
;
/*
1	7369	SMITH
*/

--ORDER BY ���� ���� ROWNUM�� ����Ǵ� ��� Ȯ�� 
--(1) ORDER BY �� ���� ���� ROWNUM 
SELECT ROWNUM 
     , e.empno
     , e.ename
  FROM emp e
;
/*
1	7369	SMITH
2	7499	ALLEN
3	7521	WARD
4	7566	JONES
5	7654	MARTIN
6	7698	BLAKE
7	7782	CLARK
8	7839	KING
9	7844	TURNER
10	7900	JAMES
11	7902	FORD
12	7934	MILLER
13	7777	JJ
14	8888	J_JAMES
*/

--(2) ename ������ �������� ���� �� ROWNUM �� Ȯ�� 
SELECT ROWNUM 
     , e.empno
     , e.ename
  FROM emp e
 ORDER BY e.ename
;
/*
2	7499	ALLEN
6	7698	BLAKE
7	7782	CLARK
11	7902	FORD
10	7900	JAMES
13	7777	JJ
4	7566	JONES
14	8888	J_JAMES
8	7839	KING
5	7654	MARTIN
12	7934	MILLER
1	7369	SMITH
9	7844	TURNER
3	7521	WARD
*/
-- ==> ROWNUM�� ORDER BY�����  ������ ���� �ʴ� ��ó�� ���� �� ����
--     SUB-QUERY �� ���� �� ROWNUM �� �� Ȯ�� 
SELECT rownum
     , a.empno
     , a.ename
     , a.numrow 
  FROM (SELECT ROWNUM as numrow
             , e.empno
             , e.ename
          FROM emp e
         ORDER BY e.ename) a
;
--�̸��� A �� ���� ����� ��ȸ
SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
;
/*
1	ALLEN
2	WARD
3	MARTIN
4	BLAKE
5	CLARK
6	JAMES
7	J_JAMES
*/

SELECT ROWNUM
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;
/*
1	ALLEN
4	BLAKE
5	CLARK
6	JAMES
7	J_JAMES
3	MARTIN
2	WARD*/

SELECT ROWNUM
     , e.rowid
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;
/*
1	AAASHsAAHAAAACWAAB	ALLEN
4	AAASHsAAHAAAACWAAF	BLAKE
5	AAASHsAAHAAAACWAAG	CLARK
6	AAASHsAAHAAAACWAAJ	JAMES
7	AAASHsAAHAAAACWAAQ	J_JAMES
3	AAASHsAAHAAAACWAAE	MARTIN
2	AAASHsAAHAAAACWAAC	WARD
*/

SELECT ROWNUM
     , e.rowid
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '%A%'
 ORDER BY e.ename
;
--�̸��� S�� ���� ������� ��ȸ ����� 
--SUB-QUERY �� ������ ���� ROWNUM, ROWID Ȯ�� 
SELECT ROWNUM
     , a.rowid
     , a.ename
  FROM (SELECT e.rowid
             , e.ename
          FROM emp e
         WHERE e.ename LIKE '%S%'
         ORDER BY e.ename) a
;

--ROWNUM ���� �� �� �ִ� ����
--emp ���� �޿��� ���� �޴� ���� 5���� ��ȸ�Ͻÿ� 

--1. �޿��� ���� ���� ���� 
SELECT e.empno
     , e.ename
     , e.sal
  FROM  emp e
 ORDER BY e.sal DESC
;
--2. 1�� ����� SUB-QUERY�� FROM �� ����Ͽ� 
--   ROWNUM �� ���� ��ȸ 
SELECT ROWNUM
     , a.*
  FROM (SELECT e.empno
             , e.ename
             , e.sal
          FROM  emp e
         ORDER BY e.sal DESC) a
 WHERE ROWNUM <= 5
;
/*
1	7839	KING	5000
2	7902	FORD	3000
3	7566	JONES	2975
4	7698	BLAKE	2850
5	7782	CLARK	2450
*/
--3. �׶� ROWNUM <= 5 ������ �߰� 
---------------------------------------------------------------
--DML : ������ ���۾� 
---------------------------------------------------------------
--1) INSERT : ���̺� ������ ��(row)�� �߰��ϴ� ��� 

--MEMBER ���̺� ������ �߰� ���� 
DROP TABLE member;
CREATE TABLE member
(  member_id    VARCHAR2(4)  
 , member_name  VARCHAR2(15)    NOT NULL
 , phone        VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 , reg_date     DATE            DEFAULT sysdate
 , address      VARCHAR2(30) 
 , major        VARCHAR2(50)
 , birth_month  NUMBER(2)
 , gender       VARCHAR2(1)     
-- , CONSTRAINT  ���������̸� ��������Ÿ�� (�������� ������ �÷�)
 , CONSTRAINT pk_member         PRIMARY KEY (member_id)
 , CONSTRAINT ck_member_gender  CHECK       (gender    IN ('M', 'F'))
 , CONSTRAINT CK_BIRTH          CHECK (birth_month     BETWEEN 1 AND 12)
);

--- 1. INTO ������ �÷��̸� ������ ������ �߰� 
--     : VALUES ���� �ݵ�� ��ü �÷��� �����͸� ������� ��� ���� 
INSERT INTO MEMBER VALUES ('M001', '�ڼ���', '9155', sysdate, '������', '����', 3, 'M');
INSERT INTO MEMBER VALUES ('M002', '������', '1418', sysdate, '������', NULL, NULL, 'M');
/*
INSERT INTO MEMBER VALUES ('M002', '������', '1418', sysdate, '������', 'M');
--��ó�� VALUES���� ������ ���� ������ ��ü �÷� ���� ��ġ���� ������ 
--�Ʒ��� ���� ������ �߻��ϹǷ�, NULL �Է��� �ؼ��� 
--���� ������ ���߾�� �Ѵ�. 
SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ�
00947. 00000 -  "not enough values"
*/
INSERT INTO MEMBER VALUES ('M003', '�̺���', '0186', sysdate, NULL, NULL, 3, 'M');
INSERT INTO MEMBER VALUES ('M004', '�蹮��', NULL, sysdate, 'û�ֽ�', '�Ͼ�', 3, 'F');
INSERT INTO MEMBER VALUES ('M005', '����ȯ', '0322', sysdate, '�Ⱦ��', '����', 3, NULL);
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
1 �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/
--PK ���� ���ǿ� ����Ǵ� ������ �߰� �õ� 
INSERT INTO MEMBER 
VALUES ('M005', 'ȫ�浿', '0001', sysdate, '������', '����', 3, 'M');
--ORA-00001: ���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�

--GENDER �÷��� CHECK ���������� �����ϴ� ������ �߰� �õ� 
--GENDER �÷���, 'F', 'M', NULL ���� ���� �߰��ϸ� 
INSERT INTO MEMBER
VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', 3, 'G');
--ORA-02290: üũ ��������(SCOTT.CK_MEMBER_GENDER)�� ����Ǿ����ϴ�

--BIRTH_MONTH �÷��� 1~12 ���� ���ڰ� �Է� �õ�
INSERT INTO MEMBER
VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', 13, 'M');
--ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�
INSERT INTO MEMBER
VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', 0, 'M');
--ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�
INSERT INTO MEMBER
VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', -1, 'M');
--ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�

--MEMBER_NAME�� NULL�Է� �õ� 
INSERT INTO MEMBER
VALUES ('M006', NULL, '0001', sysdate, '������', '����', -1, 'M');
--ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME") �ȿ� ������ �� �����ϴ�
--NULL�� ���� constraint �� �Է����� �ʾƵ� �� 

INSERT INTO MEMBER
VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', 5, 'M');
COMMIT;

---2. INTO ���� �÷� �̸��� ����� ����� ������ �߰� 
--    : VALUES ���� INTO�� ������� 
--      ���� Ÿ��, ���� ���߾ �ۼ� 
INSERT INTO MEMBER(member_id, member_name) VALUES ('M007', '������');
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/
INSERT INTO MEMBER(member_id, member_name, gender) VALUES ('M008', '������', 'M');
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
--����� member_id, member_name, reg_date, gender
  �÷��鿡 ���� �� �� Ȯ�� 
*/
--���̺� ���� ������ ������� INTO���� �÷��� ������ �� �ִ�.
INSERT INTO MEMBER(birth_month, member_name, member_id) VALUES (NULL, '������', 'M009');
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/

 --INTO ���� �÷� ������ VALUES ���� ���� ���� ����ġ 
 INSERT INTO MEMBER(member_id, member_name) 
 VALUES ('M010', '���', 'M');
 /*
 \SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�
00913. 00000 -  "too many values"
*/
 INSERT INTO MEMBER(member_id, member_name, gender) 
 VALUES ('M010', '���');
 /*
 SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ�
00947. 00000 -  "not enough values"
*/

 -- INTO ���� VALUES ���� ������ ������ 
 -- ���� Ÿ���� ��ġ���� ���� �� 
 -- ���� ������ �÷��� birth_month�� '�Ѿ�'�̶�� ���ڸ� 
 -- �߰��Ϸ��� �õ� 
  INSERT INTO MEMBER(member_id, member_name, birth_month) 
  VALUES ('M010', '���', '�Ѿ�');
 --ORA-01722: ��ġ�� �������մϴ�
 
 -- �ʼ� �Է� �÷��� �������� ���� �� 
 -- member_id : PK, member_name : NOT NULL
 INSERT INTO MEMBER (birth_month, address, gender) VALUES (12, '��������', 'F');
 --ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_ID") �ȿ� ������ �� �����ϴ�
 
 ---------------------------------------------------------------------------------
 -- ���� �� �Է� : SUB-QUERY �� ����Ͽ� ���� 
 
 -- ��������
 INSERT INTO ���̺��̸� 
 SELECT ����; -- �������� 


/*
CREATE TABLE ���̺��̸� 
AS
SELECT ....

 : ���������� �����͸� �����ϸ鼭 �� ���̺��� ���� 
 
 VS.
 
 INSERT INTO ���̺��̸� 
 SELECT ���� 
  : �̹� ������� ���̺� �����͸� �����ؼ� �߰� 
  
*/

-- new_member ����
DROP TABLE new_member;
-- Table NEW_MEMBER��(��) �����Ǿ����ϴ�.

-- member �����ؼ� ���̺� ���� 
CREATE TABLE new_member
AS 
SELECT m.*
  FROM member m
 WHERE 1 = 2
;
--Table NEW_MEMBER��(��) �����Ǿ����ϴ�.

 -- ���� �� �Է� ���������� new_member ���̺� ������ �߰� 
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.member_name LIKE '_��_'
;
COMMIT;
/*
3�� �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/

 -- �÷��� ����� ������ �Է� 
INSERT INTO new_member (member_id, member_name, phone)
SELECT m.member_id
     , member_name 
     , m.phone
  FROM member m
 WHERE m.member_id < 'M004'
;

 -- new_member �� �߰��� �� ��� ���� 
 DELETE new_member;
 COMMIT;
 
 --������� ��� �� ������ ���� 
UPDATE "SCOTT"."MEMBER" 
    SET BIRTH_MONTH = '1' 
 WHERE MEMBER_ID = 'M002'
 ;
UPDATE "SCOTT"."MEMBER" 
    SET BIRTH_MONTH = '2' 
 WHERE MEMBER_ID = 'M007'
;
UPDATE "SCOTT"."MEMBER" 
    SET BIRTH_MONTH = '7' 
 WHERE MEMBER_ID = 'M008'
;
COMMIT;
------------------------------------------------------

--����) new_member ���̺� 
--     member ���̺�κ��� �����͸� �����Ͽ� ������ �Է��� �Ͻÿ� 
--     ��, member ���̺��� �����Ϳ��� birth_month �� 
--     Ȧ������ ����鸸 ��ȸ�Ͽ� �Է��Ͻÿ� 
INSERT INTO new_member (member_id, member_name, phone, birth_month)
SELECT m.member_id
     , member_name 
     , m.phone
     , m.birth_month
  FROM member m
 WHERE MOD (m.birth_month, 2) = 1
;
COMMIT;
/*
8�� �� ��(��) ���ԵǾ����ϴ�.
Ŀ�� �Ϸ�.
*/

-------------------------------------------------------------------------------
 -- 2) UPDATE : ���̺��� ��(���ڵ�)�� ���� 
 --             WHERE �������� ���տ� ���� 

 --             1�ุ �����ϰų� ���� �� ������ ���� 
 --             ���� ���� �����Ǵ� ���� �ſ� ���ǰ� �ʿ�!!
 
 -- UPDATE ���� ���� 
 UPDATE ���̺��̸� 
    SET �÷�1 = ��1
      [,�÷�2 = ��2]
      ....
      [,�÷�n = ��n]
 [WHERE ����]
 ;
 
 -- ��) ȫ�浿�� �̸��� ���� �õ� 
     UPDATE member m  -- ���̺� ��Ī 
    SET m.member_name = '�浿��'
  WHERE m.member_id = 'M006'  
  --PK�� ã�ƾ� ��Ȯ�� ȫ�浿 ���� ã�ư� �� ���� 
 ;
 COMMIT;
/*
1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
Ŀ�� �Ϸ�
*/

-- ��) �蹮�� ����� ��ȭ��ȣ ���ڸ� ������Ʈ 
--     �ʱ⿡ INSERT �� NULL �� �����͸� ���� ���� ��� 
--     �Ŀ� ������ ������ �߻��� �� �ִ�. 
--     �̷� ��� UPDATE �������� ó��.

 UPDATE member m
    SET m.phone = '1392'
  WHERE m.member_id = 'M004'
;
COMMIT;
/*
1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
Ŀ�� �Ϸ�
*/


 -- ��) ������(M009) ����� ������ ����
 -- ������
 UPDATE member m
    SET m.major = '������'
--  WHERE member_id = 'M009' -- �Ǽ��� WHERE ���� ���� 
;
/*
9�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
: WHERE ������ ���􋚹��� ��� �࿡ ���ؼ� 
  major �÷��� ��� ������ �Ͼ ��� 
  
  ==> DML �۾� �Ǽ�, 
      ���� �� : �׷��� UPDATE ���� ������ �ƴ϶�� ��.
*/
--����(������) COMMIT �۾� ���� �ǵ����� ROLLBACK ������� 
--�߸��� ������Ʈ �ǵ����� 
ROLLBACK;
-- �ѹ� �Ϸ�.
-- M004 ����� ��ȭ��ȣ�� ������Ʈ �� ���� ������ Ŀ���̹Ƿ� 
-- �� ������ �����ͷ� ���� 

-- ��Ȯ�� M009����� major ������Ʈ ���� 
 UPDATE member m
    SET m.major = '������'
  WHERE m.member_id = 'M009' 
;
--1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT;
--Ŀ�� �Ϸ�.

-- ���� �÷� ������Ʈ(2�� �̻��� �÷� �ѹ��� ������Ʈ)
-- ��) ������(M008) ����� ��ȭ��ȣ, �ּ�, ������ �ѹ��� ������Ʈ 
 UPDATE member m 
    SET m.phone = '4119'
      , m.address = '�ƻ��'
      , m.major= '�Ͼ�'
  WHERE m.member_id = 'M008'
;
--1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
COMMIT;
--Ŀ�� �Ϸ�.


-- ��) '�Ⱦ��'�� ��� '����ȯ' ����� 'GENDER' �� ���� 
--     WHERE ���ǿ� �ּҸ� ���ϴ� ������ ���� ��� 
UPDATE member m
   SET m.gender = 'M'
 WHERE m.address = '�Ⱦ��'
-- WHERE ������ ����(X), WHERE ������ ���� ����(X)
;
--1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
ROLLBACK;
-- �ѹ� �Ϸ�.
-- ���� ���� ����� ���� �����۵��� ��ó�� �������� 
-- �����Ͱ� �پ������� ���۵��� ������ �ִ� �����̴�. 
-- ���� UPDATE �ۼ��ÿ��� WHERE ������ �ۼ��� 

-- 1���� �����ϴ� �����̶�� �ݵ�� PK �÷��� ���ؾ��Ѵ�.
-- PK �÷��� ��ü �࿡�� �����ϰ� 
--    NOT NULL �� ����Ǵ� �÷��̹Ƿ�
--    �ݵ�� �� ���� ã�� �� �ִ� ���̱� ������, PK ����� �����.

-- UPDATE ������ SELECT ���������� ��� 
-- ��) ������(M008) ����� major ��
--     ������(M002) ����� major�� ���� 
-- 1) M008�� major�� ���ϴ� SELECT 
SELECT m.major 
  FROM member m
 WHERE m.member_id = 'M008'
;

-- 2) M002 ����� major �� �����ϴ� UPDATE ���� �ۼ� 
UPDATE member m
   SET m.major = ?
 WHERE m.member_id = 'M002'
 ;
-- 2) (1)�� ����� UPDATE ������ ���� 
UPDATE member m
   SET m.major = (SELECT m.major 
                    FROM member m
                   WHERE m.member_id = 'M008')
 WHERE m.member_id = 'M002'
 ;
 COMMIT;
 
 -- ���� SET ���� ����ϴ� ����Ŀ�� ����� 
 -- ��Ȯ�ϰ� 1�� 1���� 1���� ���� �ƴ� ��� ���� ���� 
 UPDATE member m
   SET m.major = (SELECT m.major 
                    FROM member m
                 )
 WHERE m.member_id = 'M002'
 ;
 --ORA-01427: ���� �� ���� ����(��������)�� 2�� �̻��� ���� ���ϵǾ����ϴ�.
  
  UPDATE member m
   SET m.major = (SELECT m.member_id
                       , m.major 
                    FROM member m
                   WHERE m.member_id = 'M008' )
 WHERE m.member_id = 'M002'
 ;
 /*
 SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�
00913. 00000 -  "too many values"
*/

--UPDATE �� �������� �����ϴ� ��� 
-- ��) M001 �� emeber_id ������ �õ��ϴ� ��� 
--    : PK �÷� ���� �ߺ� ������ ������ �õ��ϴ� ���
ROLLBACK;
UPDATE member m
   SET m.member_id = 'M002'
 WHERE m.member_id = 'M001'
 ;
 --ORA-00001: ���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�
 
 -- ��) NOT NULL �� member_name�� NULL �����ͷ� 
 --     ������Ʈ�� �õ��ϴ� ��� 
 ROLLBACK;
UPDATE member m
   SET m.member_name = NULL
 WHERE m.member_id = 'M001'
 ;
 --ORA-01407: NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME")�� ������Ʈ�� �� �����ϴ�
 
 -- ��) M001 �����Ϳ� ���ؼ� 
 --     birth_month �� -1�� �����õ� 
 UPDATE member m
   SET m.birth_month = -1
 WHERE m.member_id = 'M001'
 ;
 --ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ�
 
 --------------------------------------------------------------------------------
 --���� �� �ǽ� 
 -- 1) PHONE �÷��� NULL�� ������� 
 --    �ϰ������� '0000' ���� ������Ʈ �Ͻÿ�  
 UPDATE member m 
    SET m.phone = '0000'
  WHERE m.phone IS NULL
;
COMMIT;
--2) M001 ����� ������
--   NULL ������ ������Ʈ 
--   : PK �� �ɾ �����ؾ� �ϴ� ����
UPDATE member m
   SET m.major = NULL
 WHERE m.member_id = 'M001' 
;
COMMIT;
--3) ADDRESS �÷��� NULL �� ������� 
--   �ϰ������� '�ƻ��' �� ������Ʈ 
-- : PK �� �� �ʿ���� ���� 
UPDATE member m
   SET m.address = '�ƻ��'
 WHERE m.address IS NULL
;
COMMIT;
-- 4) M009 ����� NULL �����͸� 
--    ��� ������Ʈ 
--    PHONE : 3581
--    ADDRESS : õ�Ƚ� 
--    GENDER : M
ROLLBACK;
UPDATE member m
   SET m.phone = '3581'
     , m.address = 'õ�Ƚ�'
     , m.gender = 'M'
 WHERE m.member_id = 'M009'
 ;

