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

