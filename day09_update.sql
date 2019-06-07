--day09 : 
--2. ������ �Լ�(�׷��Լ�)

--1)COUNT(*) : FROM���� ������ 
--             Ư�� ���̺��� ���� ����(������ ����)�� �����ִ� �Լ�
--             NULL���� ó���ϴ� "����"�� �׷��Լ�
--COUNT(expr) : expr���� ������ ���� NULL �����ϰ� �����ִ� �Լ� 
--����)dept, salgrade ���̺��� ��ü ������ ���� ��ȸ 
--1.dept ���̺� ��ȸ
SELECT d.*
  FROM dept d
;
/*
*/
--2.dept table�� ������ ���� ��ȸ : COUNT(*) ���
SELECT COUNT(*) "�μ� ����"
  FROM dept d 
;
/*
�μ� ���� 
--------
       4
       ��ü ǥ�� input�� ����
       =>�츮�� ������ ���� ���� �����Ͱ� ����!!(�����͸� ���Ӱ� ������)->NEW WORLD!
<�׷��Լ��� �������>
====>
<������ �Լ��� ���� ����>
====>SUBSTRING(dname, 1, 5)====>ACCOU
====>SUBSTRING(dname, 1, 5)====>RESEA
====>SUBSTRING(dname, 1, 5)====>SALES
====>SUBSTRING(dname, 1, 5)====>OPERA
*/

--salgrade(�޿����) ���̺��� �޿� ��� ������ ��ȸ
SELECT COUNT(*) "�޿���ް���"
  FROM salgrade
;
/*
�޿���ް���
-----------
         5
*/

/*
1  700   1200 ====>
2  1201  1400 ====>
3  1401  2000 ====> COUNT(*) ====>5
4  2001  3000 ====>
5  3001  9999 ====>
*/

--COUNT(expr)�� NULL�����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰� 
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

--emp ���̺��� job�÷��� ������ ������ ī��Ʈ 
SELECT COUNT(e.job) "������ ������ ������ ��"
  FROM emp e
;
/*
������ ������ ������ ��
--------------------
                  12
7369	SMITH	CLERK       ====>
7499	ALLEN	SALESMAN    ====>
7521	WARD	SALESMAN    ====> ������ ���� ���� �÷��� job��
7566	JONES	MANAGER     ====> null�� �� ���� ó���� ���� �ʴ´�. 
7654	MARTIN	SALESMAN    ====> 
7698	BLAKE	MANAGER     ====> COUNT(e.job) ====> 12
7782	CLARK	MANAGER     ====>
7839	KING	PRESIDENT   ====>
7844	TURNER	SALESMAN    ====>
7900	JAMES	CLERK       ====>
7902	FORD	ANALYST     ====>
7934	MILLER	CLERK       ====>
7777	JJ	
*/

--����) ȸ�翡 �Ŵ����� ������ ������ ����ΰ� 
--      ��Ī : "��簡 �ִ� ������ ��"

SELECT COUNT(mgr) "��簡 �ִ� ������ ��"
  FROM emp e
;
--�� ����� ���� ����� managing �ϴϱ� �����Ͱ� �ߺ��ؼ� ��Ÿ�� 
--ȸ���� ������ ���� ��
--����) �Ŵ������� �°� �ִ� ����� ����ΰ�?
--1. emp ���̺��� mgr �÷��� ������ ���� �ľ�(��) 
--2. mgr �÷��� �ߺ� �����͸� ���� (��)
SELECT DISTINCT e.mgr "�Ŵ��� ��"
  FROM emp e
;
/*
7782
7698
7902
7566
(null)
7839
*/
--3. �ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ 
SELECT COUNT(DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e
;
/*
�Ŵ��� ��
--------
       5
*/
--����)�μ��� ������ ������ ����ΰ� 
SELECT COUNT(e.deptno) "�μ� ���� ����"
  FROM emp e
;
/*
�μ� ���� �ο� 
------------
          12
*/

--COUNT(*)�� �ƴ� COUNT(expr) ����� ���(�ٷ� ���� ���)���� 
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
--�� ������ ����� ī��Ʈ �� ������ ������ �� ����. 

--����) ��ü�ο�, �μ� ���� �ο�, �μ� �̹��� �ο��� ���Ͻÿ�.
SELECT COUNT(e.empno) "��ü�ο�"
    ,COUNT(e.deptno) "�μ� ���� �ο�"
    ,COUNT(*)-COUNT(e.deptno) "�μ� �̹��� �ο�"
  FROM emp e
;
--SUM(expr) : NULL �׸� �����ϰ� 
--            �ջ� ������ ���� ��� ���� ��� ��� 
--SALESMAN���� ���� ������ ���غ���.
SELECT SUM(e.comm) "���� ����"
  FROM emp e
;
/*
null
0   ====>
null
500 ====>
1400====> SUM(e.comm) ====> 2200: �ڵ����� NULL �÷� ����
300 ====>
null
null
null
null
null
null
null
null
null
*/
--null�� ������ �Լ����� �ڵ����� ���ܵȴ�. 
--sql�� ��������� �ִ�. FROM->WHERE->SELECT
--=>���ʿ� �Լ��� ���� ���� 4�� ���̴�. (���ܵǰ� ���� ����)
SELECT SUM(e.comm) "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
0   ====>
500 ====>
1400====> SUM(e.comm) ====> 2200: �ڵ����� NULL �÷� ����
300 ====>
*/

--���� �Ѷ� ����� ���� ��� ������ ���� $, ���ڸ� ���� �б� ���� 
SELECT TO_CHAR(SUM(e.comm), '$9,999') "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
 ���� ����
 --------
  $2,200
*/
--3) AVG(expr) : NULL�� �����ϰ� ���� ������ �׸��� ��� ����� ���� 

--SALESMAN�� ���� ����� ���غ���.

--���� ��� ����� ���� ��� ���� $, ���ڸ� ���� �б� ����
*/
SELECT AVG(e.comm)
  FROM emp e
;
SELECT AVG(e.comm)
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
SELECT TO_CHAR(AVG(e.comm), '$9,999') "���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
SELECT TO_CHAR(AVG(e.comm), '$9,999') "���� ���"
  FROM emp e
;
/*
 ���� ���
 --------
     $550
*/

-- 4) MAX(expr) : expr�� ������ �� �� �ִ��� ���� 
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--                �ִ����� ���

--�̸��� ���� ������ ���� 
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ����
 --------
 WARD
*/
-- 4) MIN(expr) : expr�� ������ �� �� �ּڰ��� ���� 
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ�
--                �ּڰ����� ���
SELECT MIN(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ����
 --------
 ALLEN
*/

----3.GROUP BY ���� ���
--����)�� �μ����� �޿��� ����, ���, �ִ�, �ּҸ� ��ȸ

--1. �� �μ����� �޿��� ������ ��ȸ�Ϸ��� 
--   ���� : SUM()�� ���
--   �׷�ȭ ������ �μ���ȣ(deptno)�� ���
--   GROUP BY ���� �����ؾ� �� 

--a) ���� emp ���̺��� �޿� ������ ���ϴ� ���� �ۼ� 
SELECT  SUM(e.sal) 
  FROM emp e
;

--b) �μ� ��ȣ�� �������� �׷�ȭ ���� 
-- SUM()�� �׷��Լ���.
-- GROUP BY ���� �����ϸ� �׷�ȭ �����ϴ�. 
-- �׷�ȭ�� �Ϸ��� �����÷��� GROUP BY���� �����ؾ���.

SELECT e.deptno �μ���ȣ --�׷�ȭ ���� �÷����� SELECT ���� ����  
      , SUM(e.sal) "�μ� �޿� ����" --�׷��Լ��� ���� Į�� (�׷��Լ��� ���ȵǸ� GROUP BY����� �ʿ� ����)
  FROM emp e
 GROUP BY e.deptno --�׷�ȭ ���� �÷����� GROUP BY ���� ����  
 ORDER BY e.deptno --�μ���ȣ ����
;

--GROUP BY���� �׷�ȭ ���� �÷����� ������ �÷��� �ƴ� ����
--SELECT ���� �����ϸ� ����, ����Ұ�
SELECT e.deptno �μ���ȣ --�׷�ȭ ���� �÷����� SELECT ���� ����
     , e.job --�׷�ȭ �����÷��� �ƴѵ� SELECT ���� ���� ->������ ����
     , SUM(e.sal) "�μ� �޿� ����" --�׷��Լ��� ���� Į�� (�׷��Լ��� ���ȵǸ� GROUP BY����� �ʿ� ����)
  FROM emp e
 GROUP BY e.deptno --�׷�ȭ ���� �÷����� GROUP BY ���� ����  
 ORDER BY e.deptno --�μ���ȣ ����
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
260��, 29������ ���� �߻�
*/

--����) �μ��� �޿��� ����, ���, �ִ�, �ּ�

SELECT e.deptno �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
SELECT --���� �μ��� �������� �˱��� ����. ������ ������ ����� �˾ƺ��Ⱑ �����
       TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�" --SELECT���� ������ �Լ��� ��� �׷��Լ��� ������ �ȴ�. 
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
���� Ŀ���� ��������� ��Ȯ�ϰ� ��� �μ��� ������� �� �� ���ٴ� ������ ���� 
�׷���, GROUP BY ���� �����ϴ� �����÷��� SELECT ���� �Ȱ��� �����ϴ� ���� 
��� �ؼ��� ���ϴ�. 

SELECT ���� ������ �÷� �߿��� �׷��Լ��� ������ ���� �÷��� ���� ������ 
���� Ŀ���� ����Ǵ� ���̴�. 
*/

--����) �μ���, ������ �޿��� ����, ���, �ִ�, �ּҸ� ���غ��� 
SELECT e.deptno "�μ���ȣ"
     , e.job "����"
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�" 
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;

--������Ȳ
--a) GROUP BY ���� �׷�ȭ ������ ������ ���
SELECT e.deptno "�μ���ȣ"
     , e.job "����"                                   --SELECT ���� ���� 
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�" 
  FROM emp e
 GROUP BY e.deptno                                   --GROUP BY ���� ������ ��Ȳ
 ORDER BY e.deptno
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
317��, 16������ ���� �߻�
*/

--b)SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ���� 
--  GROUP BY�� ��ü�� ������ ��� 
SELECT e.deptno "�μ���ȣ"
     , e.job "����"                                  
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�" 
  FROM emp e
-- GROUP BY e.deptno, e.job                                  
 ORDER BY e.deptno
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
336��, 8������ ���� �߻�
*/


--����)����(job) �� �޿��� ����, ���, �ִ�, �ּҸ� ���غ���
--    ��Ī : ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
SELECT e.job ����
     , TO_char(SUM(e.sal), '$9,999') �޿�����
     , TO_CHAR(AVG(e.sal), '$9,999') �޿����
     , TO_CHAR(MAX(e.sal), '$9,999') �ִ�޿�
     , TO_CHAR(MIN(e.sal), '$9,999') �ּұ޿�
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job 
;
--������ null�� ������� ������ ��� '���� �̹���' ���� ���
SELECT NVL(e.job, '�����̹���') ����
     , TO_char(SUM(e.sal), '$9,999') �޿�����
     , TO_CHAR(AVG(e.sal), '$9,999') �޿����
     , TO_CHAR(MAX(e.sal), '$9,999') �ִ�޿�
     , TO_CHAR(MIN(e.sal), '$9,999') �ּұ޿�
  FROM emp e
 GROUP BY e.job
 ORDER BY e.job 
;
--�μ��� ����, ���, �ִ�, �ּ�
--�μ���ȣ�� null�ΰ�� '�μ� �̹���'���� �з��ǵ��� ��ȸ
SELECT NVL(e.deptno, '�μ� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/* deptno�� ����, '�μ��̹���'�� ���� �������̹Ƿ� Ÿ�Ժ���ġ�� 
   NVL()�� �۵����� ���մϴ�.
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

--�ذ���
SELECT NVL(TO_CHAR(e.deptno), '�μ� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
--���ڸ� ���ڷ� ���� : ���տ�����(||)�� ��� 
SELECT NVL(e.deptno || '' , '�μ� �̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
--NVL, DECODE, TO_CHAR �������� �ذ� 
SELECT DECODE(NVL(e.deptno, 0), e.deptno, TO_CHAR(e.deptno)
                              , 0       , '�μ��̹���') �μ���ȣ
     , TO_CHAR(SUM(e.sal), '$9,999') "�μ� �޿� ����"
     , TO_CHAR(AVG(e.sal), '$9,999') "�μ� �޿� ���"
     , TO_CHAR(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , TO_CHAR(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;

----4.HAVING ���� ��� 

--GROUP BY ����� ������ �ɾ 
-- �� ����� ������ �������� ���Ǵ� ��.

--HAVING ���� WHERE ���� ��������� 
--SELECT ������ ������� ������ 
--GROUP BY �� ���� ���� ����Ǵ� WHERE ���δ� 
--GROUP BY�� ����� ������ �� ����. 

--���� GROUP BY ���� ��������� ������ 
--HAVING���� �����Ѵ�. 
--����) �μ��� �޿� ����� 2000�̻��� �μ��� ��ȸ�Ͽ���.

--a)�켱 �μ��� �޿� ����� ���Ѵ�. 
SELECT e.deptno �μ���ȣ
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
;

--b) a�� ������� �޿������ 2000�̻��� ���� �����. 
--   HAVING���� ��� ���� 
SELECT e.deptno �μ���ȣ
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal)>=2000
;
--����� ���� ���� 
SELECT e.deptno �μ���ȣ
     , TO_CHAR(AVG(e.sal), '$9,999.99') �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal)>=2000
;

--���� : HAVING���� ��Ī ����� �� ����. 
SELECT e.deptno �μ���ȣ
     , TO_CHAR(AVG(e.sal), '$9,999.99') �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING �޿���� >=2000 --HAVING�� ��Ī�� ����� �� ���� 
;
/*
ORA-00904: "�޿����": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
465��, 117������ ���� �߻�
*/

--HAVING ���� �����ϴ� ��� SELECT ������ ���� ���� ���� 
/*
  1. FROM     ���� ���̺� �� �� ��θ� ������� 
  2. WHERE    ���� ���ǿ� �´� �ุ �����ϰ� 
  3. GROUP BY ���� ���� �÷�, ��(�Լ� ��)���� �׷�ȭ ���� 
  4. HAVING   ���� ������ ������Ű�� �׷��ุ ���� 
  5.          4���� ���õ� �׷� ������ ���� �࿡ ���ؼ� 
  5. SELECT   ���� ��õ� �÷�, ��(�Լ� ��)�� ��� 
  7.ORDER BY�� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
*/

----------------------------------------------------------------------
-- ������ �ǽ�

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.mgr �Ŵ���
     , COUNT(e.mgr) "�������� ��"
  FROM emp e
 GROUP BY e.mgr
 ORDER BY COUNT(e.mgr) DESC
;
/*
�Ŵ��� �������� ��
7698 	 5
7839 	 3
7566 	 1
7782	 1
7902	 1
null     0
*/

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�
SELECT e.deptno �μ� 
     , COUNT(e.deptno) "�μ��� �ο�"
  FROM emp e 
 GROUP BY e.deptno  
 ORDER BY COUNT(e.deptno) DESC
;
/*
�μ�  �μ��� �ο�
30	     6
20	     3
10	     3
null     0
*/

-- 2.2 �μ� ��ġ �̹��� �ο� ó��
SELECT NVL(e.deptno || '', '���� �̹���') �μ� 
     , COUNT(e.deptno) "�μ��� �ο�"
  FROM emp e 
 GROUP BY e.deptno  
 ORDER BY COUNT(e.deptno) DESC
;
/*
�μ�          �μ��� �ο� 
30	            6
20	            3
10	            3
���� �̹���	    0
*/

-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job ���� 
     , AVG(e.sal) ��ձ޿�
  FROM emp e
  GROUP BY e.job
  ORDER BY AVG(e.sal) DESC
;

-- 3.2 job �� null �� �����ʹ� '���� �̹���'���� ��µǵ��� ó��
SELECT NVL(e.job, '���� �̹���') ���� 
     , AVG(e.sal) ��ձ޿�
  FROM emp e
  GROUP BY e.job
  ORDER BY ��ձ޿� DESC
;
-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job ���� 
     , SUM(e.sal)
  FROM emp e
 GROUP BY e.job
 ORDER BY SUM(e.sal) DESC
;

-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����

SELECT CASE WHEN e.sal < 1000                      THEN 0
            WHEN e.sal >= 1000 and e.sal < 2000    THEN 1
            WHEN e.sal >= 2000 and e.sal < 3000    THEN 2
            WHEN e.sal >= 3000 and e.sal < 4000    THEN 3
            WHEN e.sal >= 4000 and e.sal < 5000    THEN 4
            WHEN e.sal >= 5000                     THEN 5
        END "�޿�����" 
  FROM emp e
;

-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����



-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
SELECT e.job 
     , AVG(e.sal)
  FROM emp e
 GROUP BY e.job
 HAVING AVG(e.sal)<=2000
 ORDER BY AVG(e.sal) DESC
;
-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�
