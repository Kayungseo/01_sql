-- day 08 : 단일행 함수 계속

--{3} 단일행 함수
---6) CASE
---job별로 경조사비를 급여대비 일정 비율로 지금 
/*
  CLERK       : 5%
  SALESMAN    : 4%
  MANAGER     : 3.7%
  ANALYSIS    : 3%
  PRESIDENT   : 1%
*/

--1.Simple CASE구문으로 구현 
-- :DECODE와 거의 유사, 동일비교만 가능 
--  DECODE와 다른 점 : 괄호가 없음,
--                콤마대신 WHEN, THEN, ELSE 등을 사용

SELECT e.empno
      ,e.ename
      ,e.job
      , CASE e.job WHEN 'CLERK'    THEN e.sal * 0.05
                   WHEN 'SALESMAN' THEN e.sal * 0.04
                   WHEN 'MANAGER'  THEN e.sal * 0.37
                   WHEN 'ANALYSIS' THEN e.sal * 0.03
                   WHEN 'PRESIDENT'THEN e.sal *0.015
        END AS "경조사 지원금"
 FROM emp e
 
 --2.Searched CASE 구문으로 구현 
 SELECT e.empno
      , e.ename
      , e.job
      ,to_char(CASE WHEN e.job = 'CLERK'     THEN e.sal * 0.05
                    WHEN e.job = 'SALESMAN'  THEN e.sal * 0.04
                    WHEN e.job = 'MANAGER'   THEN e.sal * 0.037
                    WHEN e.job = 'ANALYSIS'  THEN e.sal * 0.03
                    WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
                    ELSE 10
               END, '$9,999.99') AS "경조사 지원금"
 FROM emp e
;

--CASE 결과에 숫자 통화 패턴 씌우기 

*/

*/ SALGRADE (급여 등급) 테이블 내용
GRADE, LOSAL,  HISAL
---------------------
1	   700	   1200
2	   1201	   1400
3	   1401	   2000
4	   2001	   3000
5	   3001    9999

--문제: 제공되는 급여 등급을 바탕으로 
--     각 직원의 급여 등급을 CASE 문으로 구해보자.
--     사번, 이름, 급여, 급여등급을 조회하시오.
*/
1)관계연산자(And) 사용하는 방법 
SELECT e.empno
      , e.ename
      , e.sal
      , CASE WHEN e.sal >= 700 and e.sal <= 1200    THEN 1
             WHEN e.sal > 1200 and e.sal <= 1400    THEN 2
             WHEN e.sal > 1400 and e.sal <= 2000    THEN 3
             WHEN e.sal > 2000 and e.sal <= 3000    THEN 4
             WHEN e.sal > 3000 and e.sal <= 9999    THEN 5
        END "급여등급"
 FROM emp e
 ORDER BY "급여등급" DESC
;

--2) BETWEEN ~ AND ~를 사용하는 방법            
SELECT e.empno
     ,e.ename
     ,e.sal
     ,CASE WHEN e.sal BETWEEN 700  AND 1200 THEN 1
           WHEN e.sal BETWEEN 1201 AND 1400 THEN 2
           WHEN e.sal BETWEEN 1401 AND 2000 THEN 3
           WHEN e.sal BETWEEN 1201 AND 3000 THEN 4
           WHEN e.sal BETWEEN 3001 AND 9999 THEN 5
      END 급여등급
  FROM emp e
  ORDER BY 급여등급 DESC
;

--급여가 NULL일때 급여등급이 0이 나오도록 추가 
SELECT e.empno
     ,e.ename
     ,e.sal
     ,CASE WHEN e.sal IS NULL               THEN 0
           WHEN e.sal BETWEEN 700  AND 1200 THEN 1
           WHEN e.sal BETWEEN 1201 AND 1400 THEN 2
           WHEN e.sal BETWEEN 1401 AND 2000 THEN 3
           WHEN e.sal BETWEEN 1201 AND 3000 THEN 4
           WHEN e.sal BETWEEN 3001 AND 9999 THEN 5
      END 급여등급
  FROM emp e
  ORDER BY 급여등급 DESC
;

