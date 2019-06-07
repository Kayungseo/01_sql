--day09 : 
--2. 복수행 함수(그룹함수)

--1)COUNT(*) : FROM절에 나열된 
--             특정 테이블의 행의 개수(데이터 개수)를 세어주는 함수
--             NULL값을 처리하는 "유일"한 그룹함수
--COUNT(expr) : expr으로 등장한 값을 NULL 제외하고 세어주는 함수 
--문제)dept, salgrade 테이블의 전체 데이터 개수 조회 
--1.dept 테이블 조회
SELECT d.*
  FROM dept d
;
/*
*/
--2.dept table의 데이터 개수 조회 : COUNT(*) 사용
SELECT COUNT(*) "부서 개수"
  FROM dept d 
;
/*
부서 개수 
--------
       4
       전체 표가 input에 들어갔다
       =>우리가 가지고 있지 않은 데이터가 나옴!!(데이터를 새롭게 가공함)->NEW WORLD!
<그룹함수의 실행과정>
====>
<단일행 함수의 실행 과정>
====>SUBSTRING(dname, 1, 5)====>ACCOU
====>SUBSTRING(dname, 1, 5)====>RESEA
====>SUBSTRING(dname, 1, 5)====>SALES
====>SUBSTRING(dname, 1, 5)====>OPERA
*/

--salgrade(급여등급) 테이블의 급여 등급 개수를 조회
SELECT COUNT(*) "급여등급개수"
  FROM salgrade
;
/*
급여등급개수
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

--COUNT(expr)이 NULL데이터를 처리하지 못하는 것 확인을 위한 데이터 추가 
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

--emp 테이블에서 job컬럼의 데이터 개수를 카운트 
SELECT COUNT(e.job) "직무가 배정된 직원의 수"
  FROM emp e
;
/*
직무가 배정된 직원의 수
--------------------
                  12
7369	SMITH	CLERK       ====>
7499	ALLEN	SALESMAN    ====>
7521	WARD	SALESMAN    ====> 개수를 세는 기준 컬럼인 job에
7566	JONES	MANAGER     ====> null인 한 행은 처리를 하지 않는다. 
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

--문제) 회사에 매니저가 배정된 직원이 몇명인가 
--      별칭 : "상사가 있는 직원의 수"

SELECT COUNT(mgr) "상사가 있는 직원의 수"
  FROM emp e
;
--한 사람이 여러 사람을 managing 하니까 데이터가 중복해서 나타남 
--회사의 구조를 말할 때
--문제) 매니저직을 맞고 있는 사람이 몇명인가?
--1. emp 테이블의 mgr 컬럼의 데이터 형태 파악(눈) 
--2. mgr 컬럼의 중복 데이터를 제거 (식)
SELECT DISTINCT e.mgr "매니저 수"
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
--3. 중복 데이터가 제거된 결과를 카운트 
SELECT COUNT(DISTINCT e.mgr) "매니저 수"
  FROM emp e
;
/*
매니저 수
--------
       5
*/
--문제)부서가 배정된 직원은 몇명인가 
SELECT COUNT(e.deptno) "부서 배정 직원"
  FROM emp e
;
/*
부서 배정 인원 
------------
          12
*/

--COUNT(*)가 아닌 COUNT(expr) 사용한 경우(바로 위의 경우)에는 
SELECT e.deptno
  FROM emp e
 WHERE e.deptno IS NOT NULL
;
--을 수행한 결과를 카운트 한 것으로 생각할 수 있음. 

--문제) 전체인원, 부서 배정 인원, 부서 미배정 인원을 구하시오.
SELECT COUNT(e.empno) "전체인원"
    ,COUNT(e.deptno) "부서 배정 인원"
    ,COUNT(*)-COUNT(e.deptno) "부서 미배정 인원"
  FROM emp e
;
--SUM(expr) : NULL 항목 제외하고 
--            합산 가능한 행을 모두 더한 결과 출력 
--SALESMAN들의 수당 총합을 구해보자.
SELECT SUM(e.comm) "수당 총합"
  FROM emp e
;
/*
null
0   ====>
null
500 ====>
1400====> SUM(e.comm) ====> 2200: 자동으로 NULL 컬럼 제외
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
--null도 들어가지만 함수에서 자동으로 제외된다. 
--sql은 수행순서가 있다. FROM->WHERE->SELECT
--=>애초에 함수에 들어가는 행이 4개 뿐이다. (제외되고 나서 들어옴)
SELECT SUM(e.comm) "수당 총합"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
0   ====>
500 ====>
1400====> SUM(e.comm) ====> 2200: 자동으로 NULL 컬럼 제외
300 ====>
*/

--수당 총랍 결과에 숫자 출력 패턴을 적용 $, 세자리 끊어 읽기 적용 
SELECT TO_CHAR(SUM(e.comm), '$9,999') "수당 총합"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
 수당 총합
 --------
  $2,200
*/
--3) AVG(expr) : NULL값 제외하고 연산 가능한 항목의 산술 평균을 구함 

--SALESMAN의 수당 평균을 구해보자.

--수당 평균 결과에 숫자 출력 패턴 $, 세자리 끊어 읽기 적용
*/
SELECT AVG(e.comm)
  FROM emp e
;
SELECT AVG(e.comm)
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
SELECT TO_CHAR(AVG(e.comm), '$9,999') "수당 평균"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
SELECT TO_CHAR(AVG(e.comm), '$9,999') "수당 평균"
  FROM emp e
;
/*
 수당 평균
 --------
     $550
*/

-- 4) MAX(expr) : expr에 등장한 값 중 최댓값을 구함 
--                expr이 문자인 경우는 알파벳순 뒷쪽에 위치한 글자를
--                최댓값으로 계산

--이름이 가장 나중인 직원 
SELECT MAX(e.ename) "이름이 가장 나중인 직원"
  FROM emp e
;
/*
이름이 가장 나중인 직원
 --------
 WARD
*/
-- 4) MIN(expr) : expr에 등장한 값 중 최솟값을 구함 
--                expr이 문자인 경우는 알파벳순 앞쪽에 위치한 글자를
--                최솟값으로 계산
SELECT MIN(e.ename) "이름이 가장 나중인 직원"
  FROM emp e
;
/*
이름이 가장 나중인 직원
 --------
 ALLEN
*/

----3.GROUP BY 절의 사용
--문제)각 부서별로 급여의 총합, 평균, 최대, 최소를 조회

--1. 각 부서별로 급여의 총합을 조회하려면 
--   총합 : SUM()을 사용
--   그룹화 기준을 부서번호(deptno)를 사용
--   GROUP BY 절이 등장해야 함 

--a) 먼저 emp 테이블에서 급여 총합을 구하는 구문 작성 
SELECT  SUM(e.sal) 
  FROM emp e
;

--b) 부서 번호를 기준으로 그룹화 진행 
-- SUM()은 그룹함수다.
-- GROUP BY 절을 조합하면 그룹화 가능하다. 
-- 그룹화를 하려면 기준컬럼이 GROUP BY절에 등장해야함.

SELECT e.deptno 부서번호 --그룹화 기준 컬럼으로 SELECT 절에 등장  
      , SUM(e.sal) "부서 급여 총합" --그룹함수가 사용된 칼럼 (그룹함수가 사용안되면 GROUP BY사용할 필요 없음)
  FROM emp e
 GROUP BY e.deptno --그룹화 기준 컬럼으로 GROUP BY 절에 등장  
 ORDER BY e.deptno --부서번호 정렬
;

--GROUP BY절에 그룹화 기준 컬럼으로 등장한 컬럼이 아닌 것이
--SELECT 절에 등장하면 오류, 실행불가
SELECT e.deptno 부서번호 --그룹화 기준 컬럼으로 SELECT 절에 등장
     , e.job --그룹화 기준컬럼이 아닌데 SELECT 절에 등장 ->오류의 원인
     , SUM(e.sal) "부서 급여 총합" --그룹함수가 사용된 칼럼 (그룹함수가 사용안되면 GROUP BY사용할 필요 없음)
  FROM emp e
 GROUP BY e.deptno --그룹화 기준 컬럼으로 GROUP BY 절에 등장  
 ORDER BY e.deptno --부서번호 정렬
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
260행, 29열에서 오류 발생
*/

--문제) 부서별 급여의 총합, 평균, 최대, 최소

SELECT e.deptno 부서번호
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
SELECT --누구 부서의 정보인지 알길이 없다. 수행은 되지만 결과를 알아보기가 어려움
       TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소" --SELECT문에 쓰여진 함수가 모두 그룹함수라서 실행이 된다. 
  FROM emp e
 GROUP BY e.deptno
 ORDER BY e.deptno
;
/*
위의 커리는 수행되지만 정확하게 어느 부서의 결과인지 알 수 없다는 단점이 존재 
그래서, GROUP BY 절에 등장하는 기준컬럼은 SELECT 절에 똑같이 등장하는 편이 
결과 해석에 편리하다. 

SELECT 절에 나열된 컬럼 중에서 그룹함수가 사용되지 않은 컬럼이 없기 때문에 
위의 커리는 수행되는 것이다. 
*/

--문제) 부서별, 직무별 급여의 총합, 평균, 최대, 최소를 구해보자 
SELECT e.deptno "부서번호"
     , e.job "직무"
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소" 
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno
;

--오류상황
--a) GROUP BY 절에 그룹화 기준이 누락된 경우
SELECT e.deptno "부서번호"
     , e.job "직무"                                   --SELECT 에는 등장 
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소" 
  FROM emp e
 GROUP BY e.deptno                                   --GROUP BY 에는 누락된 상황
 ORDER BY e.deptno
;
/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
317행, 16열에서 오류 발생
*/

--b)SELECT 절에 그룹함수와 일반 컬럼이 섞여 등장 
--  GROUP BY절 전체가 누락된 경우 
SELECT e.deptno "부서번호"
     , e.job "직무"                                  
     , TO_CHAR(SUM(e.sal), '$9,999') "부서 급여 총합"
     , TO_CHAR(AVG(e.sal), '$9,999') "부서 급여 평균"
     , TO_CHAR(MAX(e.sal), '$9,999') "부서 급여 최대"
     , TO_CHAR(MIN(e.sal), '$9,999') "부서 급여 최소" 
  FROM emp e
-- GROUP BY e.deptno, e.job                                  
 ORDER BY e.deptno
;
/*
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
00937. 00000 -  "not a single-group group function"
*Cause:    
*Action:
336행, 8열에서 오류 발생
*/

