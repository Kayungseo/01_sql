--day12 : DDL(Data Definition Language)
--        ������ ���Ǿ� 
--1.���̺��� �����ϴ� ��ɾ� =>���̺��� DBMS�� OBJECT �� �ϳ� 
--2.DBMS�� OBJECT(��ü)�� ����/�ν��ϴ� �����
--  ����, ����, �����ϴ� ��ɾ� 

--���� : CREATE
--���� : ALTER
--���� : DROP

--vs. DML (Data Manipulation Language) ������ ���۾� 
--���� : INSERT 
--���� : UPDATE
--���� : DELETE

----------------------------------------------------------------------
/* DDL ������ ���� 

   CREATE | ALTER | DROP {������ ��ü�� Ÿ�Ը�}

    DBMS�� OBJECT(��ü)�� ���� 
    SHEMA, DOMAIN, TABLE, VIEW, INDEX, SEQUENCE, USER, DATABASE
*/
--meta : � ���� �������(�����鿡 ���� ����), ex.emp ���̺� ���� ����, ��Ÿ����-���� ���� ���ؼ� �˰� �ֳ� 

--CREATE TABLE ������ ���� 
CREATE TABLE ���̺��̸�
(�÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]
[�÷�2�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
.....
[�÷�n�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
);

/*-------------------------
�÷��� �������
---------------------------
1. PRIMARY KEY : �� �÷��� �ԷµǴ� ���� �ߺ����� �ʰ� 
                  �� ���� �ĺ��� �� �ִ� ������ �����ؾ� �ϸ�
                  NULL ������ �Է��� �Ұ����� ���̾�� �Ѵ�. 
                  
2. FOREIGN KEY : �ַ� JOIN�� ���Ǵ� ������������ 
                 �ٸ� ���̺��� PRIMARY KEY�� ���Ǿ��� ���� 
                 �����ؾ߸� �Ѵ�. 
                 
3. UNIQUE      : �� �÷��� �ԷµǴ� ���� �ߺ����� ������ �����ؾ� �Ѵ�. 
                 NULL������ �Է��� �����ϴ�.
                 ==>�����Ͱ� NULL(����) �̰ų� 
                    NULL�� �ƴϸ� �ݵ�� ������ ���̾�� ��.
                    
4. NOT NULL    : �� �÷��� �ԷµǴ� ���� �ߺ��� ���������
                 NULL ���´� ���� �ʵ��� �����Ѵ�. 
                 
==>PK = UNIQUE + NOT NULL ���յ� ���¶�� ���� �� �� �ִ�. 
*/

--��)û���� ���� �����ο� ������ ������ ���̺��� ���� 
/*
  ���̺� �̸� : member
  1. ������̵�      : member_id        :����   :VARCHAR2  :PK
  2. ����̸�        : member_name      :����   :VARCHAR2  :NOT NULL
  3. ��ȭ��ȣ ���ڸ�  : phone           :����    :VARCHAR2
  4. �ý��۵����     : reg_date        :��¥    :DATE
  5. ��� ��         : address         :����    :VARCHAR2
  6. �����ϴ� ����    : like_number     :����    :NUMBER
  7. ����            : major           :����    :VARCHAR2
*/

--1.���̺� ���� ���� : member
CREATE TABLE member 
( member_id     VARCHAR2(4)   PRIMARY KEY 
 ,member_name   VARCHAR2(15)  NOT NULL
 ,phone         VARCHAR2(4)   --NULL ����Ϸ��� �������� �Ⱦ��� �ȴ�
 ,reg_date      DATE          DEFAULT sysdate
 ,address       VARCHAR2(30)  
 ,like_number   NUMBER
 ,major         VARCHAR2(50)  
);

--2.���̺� ���� ���� 
DROP TABLE ���̺� �̸�;

DROP TABLE member;

--3. ���̺� ���� ���� 
/*-----------------------
  ������ ����
  -----------------------
  1. �÷��� �߰� : ADD 
  2. �÷��� ���� : MODIFY
  3. �÷��� ���� : DROP COLUMN
  ------------------------
*/
ALTER TABLE ���̺��̸� {ADD | MODIFY | DROP COLUMN}.... ;
--��) ������ member ���̺� �÷� 2���� �߰� 
-- ��� �� : birth_month : NUMBER
-- ����    : gender      : VARCHAR2(1) : F,M �� ���� �� �ϳ��� �Է°����ϵ��� 

--1)ADD 
--member table ���� �� �Ʒ� ���� ���� 
ALTER TABLE member ADD
( birth_month NUMBER
, gender      VARCHAR2(1) CHECK (gender IN ('F', 'M')) --where �������� �� �� �ִ� ����
);
--TABLE MEMBER�� ����Ǿ����ϴ�.

--2.MODIFY 
--��) ��� �� �÷��� ����2 �ڸ������� �����ϵ��� ���� 
ALTER TABLE ���̺��̸� MODIFY �÷��̸� ������Ÿ��(ũ��);
ALTER TABLE member MODIFY birth_month NUMBER(2);

--3)DROP COLUMN
--��) ������ ���̺� member ���� like_number �÷� ���� 
ALTER TABLE ���̺��̸� DROP COULMN �÷��̸�;
ALTER TABLE member DROP COLUMN like_number;
--Table MEMBER��(��) ����Ǿ����ϴ�.
--���� ����� member ���̺��� ��������
CREATE TABLE member 
( member_id     VARCHAR2(4)   PRIMARY KEY 
 ,member_name   VARCHAR2(15)  NOT NULL
 ,phone         VARCHAR2(4)   --NULL ����Ϸ��� �������� �Ⱦ��� �ȴ�
 ,reg_date      DATE          DEFAULT sysdate
 ,address       VARCHAR2(30)  
 ,like_number   NUMBER
 ,major         VARCHAR2(50)  
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1)   CHECK (gender IN ('F', 'M'))
);

-- ���� �ܼ�ȭ�� ���̺� ���� ���� 
-- ���������� �� �÷� �ڿ� �ٷ� �������� �̸����� ���� 

-- �������ǿ� �̸��� �ο��ؼ� ���� : 
-- �÷��� ���ǰ� ���� �� �������� ���Ǹ� ���Ƽ� �ۼ� 


-- ���̺� ����
 DROP TABLE member;
 --Table MEMBER��(��) �����Ǿ����ϴ�.
 
-- �������� �̸��� �־� member ���̺� ���� 
-- , CONSTRAINT  ���������̸� ��������Ÿ�� (�������� ������ �÷�)
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
 , CONSTRAINT ck_member_gender  CHECK       (gender IN ('M', 'F'))
);

--���̺� ������ DDL�� ������ ������ �ý��� īŻ�α׿� ����� 
--user_tables, user_constraints 
--�� ���� �ý��� īŻ�α� ���̺��� ��ȸ 

--1)�� ���̺��� ����(�÷� �̸�) ��ȸ 
DESC user_tables;
DESC user_constraints
/*
�̸�                        ��?       ����             
------------------------- -------- -------------- 
*/

 SELECT t.table_name
   FROM user_tables t --�ý��� īŻ�α� 
;
/*
TABLE_NAME
------------
DEPT
EMP
BONUS
SALGRADE
MEMBER
*/
DESC user_constraints;

DROP TABLE member;

SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
;
/*
FK_DEPTNO	        R	EMP
PK_DEPT	            P	DEPT
PK_EMP	            P	EMP
CK_MEMBER_GENDER	C	MEMBER
PK_MEMBER	        P	MEMBER
SYS_C007911	        C	MEMBER
*/

--member table�� �������Ǹ� Ȯ�� 
SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
 WHERE c.table_name = 'MEMBER'
;
/*
SYS_C007911	        C	MEMBER
CK_MEMBER_GENDER	C	MEMBER
PK_MEMBER	        P	MEMBER
*/

--user_objects : ���� ����ڰ� ������ �ִ� object���� ������ ����Ǵ� 
--               �ý��� īŻ�α� ���̺� 
DESC user_objects;
SELECT o.object_name
     , o.object_id
     , o.object_type
  FROM user_objects o 
;
/*
PK_MEMBER	75097	INDEX --����(������ ������ ã�ư� �� �ֵ���)
MEMBER	    75096	TABLE
PK_DEPT	    74219	INDEX
DEPT	    74218	TABLE
EMP	        74220	TABLE
PK_EMP	    74221	INDEX
BONUS	    74222	TABLE
SALGRADE	74223	TABLE
*/

--���̺� ���� ��� �� �̹� �����ϴ� ���̺�κ��� ���� ���� 
--���̺� ���� ���� ����
CREATE TABLE ���̺��̸� 
AS 
SELECT �÷��̸�...
  FROM ������ ���̺� 
 WHERE �׻� ������ �Ǵ� ���� 
;

--��)�ռ� ������ member table���� ���� : new_member 
CREATE TABLE new_member
AS 
SELECT m.*
  FROM member m
 WHERE 1=2 --�׻� ������ �Ǵ� ����
;
-- pk������ ������� �ʰ� ���̺� ����(��ȸ�� �÷���) ����� 
-- new_member ���̺��� ���� ��ȸ
DESC new_member;
/*
��          ��?       ����           
----------- -------- ------------ 
MEMBER_ID            VARCHAR2(4)  
MEMBER_NAME NOT NULL VARCHAR2(15) 
PHONE                VARCHAR2(4)  
REG_DATE             DATE         
ADDRESS              VARCHAR2(30) 
LIKE_NUMBER          NUMBER       
MAJOR                VARCHAR2(50) 
BIRTH_MONTH          NUMBER(2)    
GENDER               VARCHAR2(1)  
*/
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M001', '�ڼ���', '9155', '������', '����', '3', 'M');
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M002', '������', '1418', '������', '�Ͼ�', '1', 'M');
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M003', '�̺���', '0186', 'õ�Ƚ�', '�İ�', '3', 'M');
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M004', '�蹮��', '1392', 'û�ֽ�', '�Ͼ�', '3', 'F');
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M005', '����ȯ', '0322', '�Ⱦ��', '����', '3', 'F');
COMMIT;


--3������ ������ �����ؼ� �� ���̺� ���� 
CREATE TABLE march_member
AS
SELECT m.* 
  FROM member m
 WHERE m.birth_month = 3
;

--�����Ͽ� ���̺� ������ ���� �� �� �ִ� ������ �ָ� 
--�ش� ������ �����ϴ� ���� �����ͱ��� ����Ǹ鼭 ���̺� ���� 

--�׻� ���� �Ǵ� ������ �ָ� ��� �����͸� �����ϸ鼭 ���̺� ���� 
CREATE TABLE full_member
AS
SELECT m.* 
  FROM member m
 WHERE 1=1
;
--full_member ���� 
DROP TABLE full_member;
CREATE TABLE full_member
AS SELECT m.*
  FROM member m
  --WHERE �������� �����ϸ� 
  --�׻� ���� ����� �����ϹǷ� ��� �����Ͱ� ����Ǹ� �� ���̺� ���� 
;��
DROP TABLE march_member;
DROP TABLE full_member;
DROP TABLE new_member;

--------------------------------------------------------------
--���̺� ����(ALTER)

--1)�÷��� �����Ͱ� ���� ��
-- : ��� ���濡 �����ο� 
--   ������ Ÿ�Ժ���, ������ ũ�⺯�濡 ��� �����ο� 

--2) �÷��� �����Ͱ� ���� ��
-- : �����Ͱ� �ҽǵǸ� �ȵǹǷ� ���濡 ������ ���� 
--   Ÿ�� ������ ���� Ÿ�Գ������� ���� 
--   ���� Ÿ�԰��� CHAR ->VARCHAR2 ���氡��  

--   ũ�� ������ ���� Ȥ�� Ŀ���� �������θ� ���� 
--   ���� Ÿ�� ������ ���е��� Ŀ���� �������θ� ���� 

--��)MARCH_MEMBER ���̺��� 
--  ������ Ÿ���� ũ�⸦ NUMBER(1)�� ���̸� 
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1));
/*
ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�
01440. 00000 -  "column to be modified must be empty to decrease precision or scale"
*/
--  ���ڵ������� ���е��� �����ϴ� ������ �����ϸ� 
--  2  ->  10�ڸ�, ���� �Ҽ��� 2�ڸ� 
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(10, 2));
-- Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

--���� �������� birth_month �÷��� ���� �����ͷ� ���� 
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(1) );
/*
ORA-01439: ������ ������ ������ ���� ��� �־�� �մϴ�
01439. 00000 -  "column to be modified must be empty to change datatype"
*/

--MARCH_MEMBER ���̺��� ��� �࿡ ���ؼ� 
--BIRTH_MONTH �÷��� ���� NULL �����ͷ� �����ϴ� ��� 
UPDATE "SCOTT"."MARCH_MEMBER" 
  SET BIRTH_MONTH = ''
;
COMMIT;
------------------------------------------------------------------
--3) �⺻ ��(DEFAULT) ������ ���� ���� ������ �����.

--��) 3������ ����� ������ MARCH_MEMBER���̺��� �����غ��� 
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) 
VALUES ('M006', '�Կ���', '0432', '������', '�İ�', '3', 'F');
COMMIT;

--b) a�� ��� ���� �߰� �� DEFAULT ���� �߰� 
ALTER TABLE march_member MODIFY (birth_month DEFAULT 3);
--table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

--c) MARCH_MEMBER ���̺� DEFAULT
--�� ��� �߰� 
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, ADDRESS, MAJOR, GENDER) 
VALUES ('M007', 'ȫ�浿 ', '������', '����', 'M');
COMMIT;
/*
6�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

Ŀ�� �Ϸ�.
*/
--�����Ͱ� ���� �÷����� ���� �� 
--VARCHAR2(2) �����÷����� ���� 
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(2) );
--Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1) );
------------------------------------------------------------------------------------
--���̺� ���Ἲ ���� ���� ó����� 4���� 

/*
    MAIN_TABLE 
    ID        VARCHAR2(10)   PK
    NICKNAME  VARCHAR2(30)   UNIQUE
    REG_DATE  DATE           DEFAULT SYSDATE
    GENDER    VARCHAR2(1)    CHECK (GENDER IN ( 'M', 'F'))
    MESSAGE   VARCHAR2(300)
    ----------------------------------------------------------------------------------
    
    SUB_TABLE
    ----------------------------------------------------------------------------------
    ID         VARCHAR2(10)  REFERRENCES MAIN_TABLE(ID)
                             (FK FROM MAIN_TABLE.ID )
    HOBBY      VARCHAR2(200) 
    BIRTH_YEAR NUMBER(4)
    ----------------------------------------------------------------------------------
*/
----1.�÷� ������ ��, ���� ���� �̸� ���� �ٷ� ���� 

DROP TABLE MAIN_TABLE1;
CREATE TABLE MAIN_TABLE1
(
    ID        VARCHAR2(10)   PRIMARY KEY
  , NICKNAME  VARCHAR2(30)   UNIQUE
  , REG_DATE  DATE           DEFAULT SYSDATE
  , GENDER    VARCHAR2(1)    CHECK (GENDER IN ( 'M', 'F'))
  , MESSAGE   VARCHAR2(300)
);

 DROP TABLE SUB_TABLE1;
 CREATE TABLE SUB_TABLE1
( ID         VARCHAR2(10)    REFERENCES MAIN_TABLE1(ID)
, HOBBY      VARCHAR2(200)    
, BIRTH_YEAR NUMBER(4)  
);

DROP TABLE MAIN_TABLE2;
CREATE TABLE MAIN_TABLE2
(
    ID        VARCHAR2(10)   CONSTRAINT PK_MAIN2 PRIMARY KEY
  , NICKNAME  VARCHAR2(30)   CONSTRAINT UQ_NICKNAME UNIQUE
  , REG_DATE  DATE           DEFAULT SYSDATE
  , GENDER    VARCHAR2(1)    CONSTRAINT CK_GENDER CHECK (GENDER IN ( 'M', 'F'))
  , MESSAGE   VARCHAR2(300)
);

 DROP TABLE SUB_TABLE2;
 CREATE TABLE SUB_TABLE2
( ID         VARCHAR2(10)    CONSTRAINT PK_SUB2 REFERENCES MAIN_TABLE2(ID)
, HOBBY      VARCHAR2(200)    
, BIRTH_YEAR NUMBER(4)  
);

DROP TABLE SUB_TABLE3;
CREATE TABLE MAIN_TABLE3
(   ID        VARCHAR2(10)
  , NICKNAME  VARCHAR2(30)   
  , REG_DATE  DATE           DEFAULT SYSDATE
  , GENDER    VARCHAR2(1)    
  , MESSAGE   VARCHAR2(300)
  , CONSTRAINT PK_MAIN3 PRIMARY KEY (ID)
  , CONSTRAINT UQ_NICKNAME3 UNIQUE (NICKNAME)
  , CONSTRAINT CK_GENDER3 CHECK (GENDER IN ( 'M', 'F'))
);

 DROP TABLE SUB_TABLE3;
 CREATE TABLE SUB_TABLE3
( ID         VARCHAR2(10)    
, HOBBY      VARCHAR2(200)    
, BIRTH_YEAR NUMBER(4)  
, CONSTRAINT PK_SUB3 PRIMARY KEY (ID, BIRTH_YEAR)
);

--�߰� ���� 
--�ǽ� 10)
/* �� ���� ���̺� �����ϴ� ���� �ۼ�
 3�� ������� �ۼ� 
 GAME 
 
 GAME_CODE  NUMBER(2) PRIMARY KEY  --10,20,30
 GAME_NAME  VARCHAR2(200) NOT NULL
 
 ----------------------------------------------------
  GMEMBER 
  
  ID        VARCHAR2(4)   PRIMARY KEY --ȸ���� ���̵� M001, M002 
  NAME      VARCHAR2(15)  NOT NULL    --ȸ���� �̸� 
  
 ----------------------------------------------------
 MEMBER_GAME_HISTORY
 
 ID         VARCHAR2(4)   FK����, FK�̸� : FK_ID
                          GMEMBER ���̺��� ID �÷��� �����ϵ��� ���� 
 YEAR       NUMBER(2)     --������ �� �⵵ 
 GAME_CODE  NUMBER(2)     FK ����, FK �̸� : FK_GAME_CODE
                          GAME ���̺��� GAME_CODE �÷��� �����ϵ��� ���� 
                          
 ----------------------------------------------------
 -->JOIN QUERY �ۼ� 
 
*/

CREATE TABLE GAME 
(
    GAME_CODE    NUMBER(2)        
  , GAME_NAME    VARCHAR2(200)  NOT NULL
  , CONSTRAINT PK_CODE PRIMARY KEY(GAME_CODE)
);
 
CREATE TABLE GMEMBER 
(
    ID  VARCHAR2(4) 
  , NAME VARCHAR2(15)   NOT NULL
  , CONSTRAINT PK_ID_GMEMBER PRIMARY KEY(ID)
);

CREATE TABLE MEMBER_GAME_HISTORY
(
    ID  VARCHAR2(4)
  , YEAR NUMBER(4) 
  , GAME_CODE NUMBER(2)
  , CONSTRAINT FK_ID FOREIGN KEY(ID) REFERENCES GMEMBER(ID)
  , CONSTRAINT FK_GAME_CODE FOREIGN KEY(GAME_CODE) REFERENCES GAME(GAME_CODE)
);
 
SELECT h.id
     , m.name
     , h.year
     , h.game_code
  FROM game g JOIN member_game_history h ON (g.game_code = h.game_code)
              JOIN gmember m             ON (m.id = h.id)
;
 