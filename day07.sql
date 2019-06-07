
--day07
-----(4)������ Ÿ�� ��ȯ
/*���� �⺻���� Ÿ�� 
1. ���� : �ݵ�� ''�� ���μ� ��� 
2. ���� : ��� ������ �Ǵ� �� 
3. ��¥ : ����, ����, ��, ��, ��, ��

------------------------------------
TO_CHAR(): �ٸ� Ÿ�Կ��� ���� Ÿ������ ��ȯ ���ִ� �Լ�
����, ��¥==>����
TO_DATE() : �ٸ� Ÿ�Կ��� ��¥Ÿ������ ��ȯ���ִ� �Լ� 
��¥������ ����(��¥ ���Ͽ� �´� ����)==> ��¥
TO_NUMBER() : �ٸ� Ÿ�Կ��� ���� Ÿ������ ��ȯ���ִ� �Լ�
���ڷθ� ������ ���ڵ����� ==>����
*/
----1. to_char : �������� ����
SELECT to_char(12345, '9999')--12345
 FROM dual
;
SELECT to_char(12345, '99999') as "12345" --12345
 FROM dual
;
--���ڰ� ����ȭ�Ǿ� ��µǸ� ���� ���ķ� �ٲ��. 
SELECT to_char(e.sal) "�޿�(����ȭ)"
    ,e.sal "�޿�(����ȭ)"
FROM emp e    
--����ȭ�� �޿��� �������� ���ĵǾ� �ְ� 
--���� ��ü�� �޿��� ���������� ���ĵǾ� ������ Ȯ���Ѵ�. 

--���ڸ� ����ȭ �ϵ� �� 8ĭ�� ä�쵵�� �����. 
SELECT to_char(12345, '99999999') as ������ --12345
 FROM dual
;
--�տ� �� ������ 0���� ä��� 
SELECT to_char(12345, '09999999') as ������ --12345
 FROM dual
;
--�Ҽ��� ���� ǥ��
SELECT to_char(12345, '09999999.99') as ������ --12345
 FROM dual
;
--���� ���Ͽ��� 3�ڸ��� ���� �б�, �Ҽ��� ǥ�� 
SELECT to_char(12345, '9,999,999.99') as ������ --12345
 FROM dual
;

----2. to_date(): ��¥ ���Ͽ� �´� ���� ���� ��¥ ������ ������ ��¥ Ÿ������ ���� 
--
SELECT to_date('2019-5��-28', 'YYYY-MON-DD') "today(��¥)"
    , '2019-5��-28' "today(����)"
    FROM dual;
;
--10������ ��¥ ���� 
SELECT to_date('2019-5��-28', 'YYYY-MON-DD') + 10 "today + 10��"
    FROM dual    
;
--today + 10�� 
--19/06/07

--��¥ó�� ���� ���ڿʹ� ��¥ ������ �ȵ��� Ȯ�� 
SELECT '2019-5��-28' + 10 "today + 10��"
    FROM dual    
;
/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/
----3. to_number():����Ŭ�� �ڵ� ����ȯ�� ���ֹǷ� ���� ������ ����.
--�ڵ� ����ȯ 
SELECT '1000' + 10 �����
 FROM dual
;
select to_number('1000') + 10 �����
 FROM dual
;
-----(5)DECODE(expr, search, result [, search, result] ... [, default])
/*
���� dafault�� �����Ǿ� ���� �ʰ� 
expr�� ��ġ�ϴ� search �� ���� ��� 
DECODE���� ��� NULL�� �ȴ�. 
*/
--            expr   search1 result1
SELECT DECODE('YES', 'YES', '�Է°��� YES�Դϴ�. '
                   , 'NO', '�Է°��� NO�Դϴ�. ') AS �Է°�� 
--                   search result2

/*
�Է°�� 
------------------------------------------------------------
�Է°��� YES�Դϴ�.
*/
SELECT DECODE('��', 'YES', '�Է°��� YES�Դϴ�. '
                   , 'NO', '�Է°��� NO�Դϴ�. ')
                   , '�Է°��� YES/NO�� ��� �͵� �ƴմϴ�.')  AS �Է°�� 
FROM dual
 ;
 
----------
�Է°��� YES/NO �� ��� �͵� �ƴմϴ�. 
*/

--emp ���̺��� job(����) ���� 
--������� �޿���� ���� ������ �����ϱ�� �ߴ�. 
--���޺����� ������ ���ٰ� �� ��,
--�� �������� ������� �������� ���غ���.
/*CLERK     : 5%
  salesman  : 4%
  manager   : 3.7%
  analyst   : 3%
  president : 1.5%
*/

SELECT e.empno
    ,e.empno
    ,e.job
    ,DECODE(e.job, 'CLERCK'   , e.sal * 0.5
                 , 'SALESMAN' , e.sal * 0.04
                 , 'MANAGER'  , e.sal * 0.037
                 , 'ANALYSIT' , e.sal * 0.03
                 , 'PRESIDENT', e.sal * 0.015) "������ ������"
  FROM emp e 
; 
--������ �ڿ��� ����� ���� ���� ������ 
SELECT e.empno
    ,e.empno
    ,e.job
    , DECODE(e.job, 'CLERCK'   , e.sal * 0.5
                          , 'SALESMAN' , e.sal * 0.04
                          , 'MANAGER'  , e.sal * 0.037
                          , 'ANALYSIT' , e.sal * 0.03                     
                          , 'PRESIDENT', e.sal * 0.015) "������ ������"
  FROM emp e 
; 

SELECT e.empno
    ,e.empno
    ,e.job
    , DECODE(e.job, 'CLERK'   ,to_char(300,'$9999')
                  , 'SALESMAN' ,to_char(450,'$9999')
                  , 'MANAGER'  , to_char(600,'$9999')
                  , 'ANALYST' ,to_char(800,'$9999')                    
                  , 'PRESIDENT', to_char(1000,'$9999')) "������ ������"
  FROM emp e 
;