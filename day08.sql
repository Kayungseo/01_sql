-- day 08 : ������ �Լ� ���

--{3} ������ �Լ�
---6) CASE
---job���� ������� �޿���� ���� ������ ���� 
/*
  CLERK       : 5%
  SALESMAN    : 4%
  MANAGER     : 3.7%
  ANALYSIS    : 3%
  PRESIDENT   : 1%
*/

--1.Simple CASE�������� ���� 
-- :DECODE�� ���� ����, ���Ϻ񱳸� ���� 
--  DECODE�� �ٸ� �� : ��ȣ�� ����,
--                �޸���� WHEN, THEN, ELSE ���� ���

SELECT e.empno
      ,e.ename
      ,e.job
      , CASE e.job WHEN 'CLERK'    THEN e.sal * 0.05
                   WHEN 'SALESMAN' THEN e.sal * 0.04
                   WHEN 'MANAGER'  THEN e.sal * 0.37
                   WHEN 'ANALYSIS' THEN e.sal * 0.03
                   WHEN 'PRESIDENT'THEN e.sal *0.015
        END AS "������ ������"
 FROM emp e
 
 --2.Searched CASE �������� ���� 
 SELECT e.empno
      , e.ename
      , e.job
      ,to_char(CASE WHEN e.job = 'CLERK'     THEN e.sal * 0.05
                    WHEN e.job = 'SALESMAN'  THEN e.sal * 0.04
                    WHEN e.job = 'MANAGER'   THEN e.sal * 0.037
                    WHEN e.job = 'ANALYSIS'  THEN e.sal * 0.03
                    WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
                    ELSE 10
               END, '$9,999.99') AS "������ ������"
 FROM emp e
;

--CASE ����� ���� ��ȭ ���� ����� 

*/

*/ SALGRADE (�޿� ���) ���̺� ����
GRADE, LOSAL,  HISAL
---------------------
1	   700	   1200
2	   1201	   1400
3	   1401	   2000
4	   2001	   3000
5	   3001    9999

--����: �����Ǵ� �޿� ����� �������� 
--     �� ������ �޿� ����� CASE ������ ���غ���.
--     ���, �̸�, �޿�, �޿������ ��ȸ�Ͻÿ�.
*/
1)���迬����(And) ����ϴ� ��� 
SELECT e.empno
      , e.ename
      , e.sal
      , CASE WHEN e.sal >= 700 and e.sal <= 1200    THEN 1
             WHEN e.sal > 1200 and e.sal <= 1400    THEN 2
             WHEN e.sal > 1400 and e.sal <= 2000    THEN 3
             WHEN e.sal > 2000 and e.sal <= 3000    THEN 4
             WHEN e.sal > 3000 and e.sal <= 9999    THEN 5
        END "�޿����"
 FROM emp e
 ORDER BY "�޿����" DESC
;

--2) BETWEEN ~ AND ~�� ����ϴ� ���            
SELECT e.empno
     ,e.ename
     ,e.sal
     ,CASE WHEN e.sal BETWEEN 700  AND 1200 THEN 1
           WHEN e.sal BETWEEN 1201 AND 1400 THEN 2
           WHEN e.sal BETWEEN 1401 AND 2000 THEN 3
           WHEN e.sal BETWEEN 1201 AND 3000 THEN 4
           WHEN e.sal BETWEEN 3001 AND 9999 THEN 5
      END �޿����
  FROM emp e
  ORDER BY �޿���� DESC
;

--�޿��� NULL�϶� �޿������ 0�� �������� �߰� 
SELECT e.empno
     ,e.ename
     ,e.sal
     ,CASE WHEN e.sal IS NULL               THEN 0
           WHEN e.sal BETWEEN 700  AND 1200 THEN 1
           WHEN e.sal BETWEEN 1201 AND 1400 THEN 2
           WHEN e.sal BETWEEN 1401 AND 2000 THEN 3
           WHEN e.sal BETWEEN 1201 AND 3000 THEN 4
           WHEN e.sal BETWEEN 3001 AND 9999 THEN 5
      END �޿����
  FROM emp e
  ORDER BY �޿���� DESC
;

