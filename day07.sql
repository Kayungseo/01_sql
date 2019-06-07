
--day07
-----(4)데이터 타입 변환
/*가장 기본적인 타입 
1. 문자 : 반드시 ''로 감싸서 사용 
2. 숫자 : 산술 연산이 되는 값 
3. 날짜 : 세기, 연도, 달, 시, 분, 초

------------------------------------
TO_CHAR(): 다른 타입에서 문자 타입으로 변환 해주는 함수
숫자, 날짜==>문자
TO_DATE() : 다른 타입에서 날짜타입으로 변환해주는 함수 
날짜형식의 문자(날짜 패턴에 맞는 문자)==> 날짜
TO_NUMBER() : 다른 타입에서 숫자 타입으로 변환해주는 함수
숫자로만 구성된 문자데이터 ==>숫자
*/
----1. to_char : 숫자패턴 적용
SELECT to_char(12345, '9999')--12345
 FROM dual
;
SELECT to_char(12345, '99999') as "12345" --12345
 FROM dual
;
--숫자가 문자화되어 출력되면 왼쪽 정렬로 바뀐다. 
SELECT to_char(e.sal) "급여(문자화)"
    ,e.sal "급여(숫자화)"
FROM emp e    
--문자화된 급여는 왼쪽으로 정렬되어 있고 
--숫자 자체인 급여는 오른쪽으로 정렬되어 있음을 확인한다. 

--숫자를 문자화 하되 총 8칸을 채우도록 만든다. 
SELECT to_char(12345, '99999999') as 데이터 --12345
 FROM dual
;
--앞에 빈 공간을 0으로 채우기 
SELECT to_char(12345, '09999999') as 데이터 --12345
 FROM dual
;
--소수점 이하 표현
SELECT to_char(12345, '09999999.99') as 데이터 --12345
 FROM dual
;
--숫자 패턴에서 3자리씩 끊어 읽기, 소수점 표현 
SELECT to_char(12345, '9,999,999.99') as 데이터 --12345
 FROM dual
;

----2. to_date(): 날짜 패턴에 맞는 문자 값을 날짜 연산이 가능한 날짜 타입으로 변경 
--
SELECT to_date('2019-5월-28', 'YYYY-MON-DD') "today(날짜)"
    , '2019-5월-28' "today(문자)"
    FROM dual;
;
--10일후의 날짜 연산 
SELECT to_date('2019-5월-28', 'YYYY-MON-DD') + 10 "today + 10일"
    FROM dual    
;
--today + 10일 
--19/06/07

--날짜처럼 생긴 문자와는 날짜 연산이 안됨을 확인 
SELECT '2019-5월-28' + 10 "today + 10일"
    FROM dual    
;
/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/
----3. to_number():오라클이 자동 형변환을 해주므로 자주 사용되지 않음.
--자동 형변환 
SELECT '1000' + 10 계산결과
 FROM dual
;
select to_number('1000') + 10 계산결과
 FROM dual
;
-----(5)DECODE(expr, search, result [, search, result] ... [, default])
/*
만약 dafault가 설정되어 있지 않고 
expr과 일치하는 search 도 없는 경우 
DECODE문의 결관 NULL이 된다. 
*/
--            expr   search1 result1
SELECT DECODE('YES', 'YES', '입력값이 YES입니다. '
                   , 'NO', '입력값이 NO입니다. ') AS 입력결과 
--                   search result2

/*
입력결과 
------------------------------------------------------------
입력값이 YES입니다.
*/
SELECT DECODE('예', 'YES', '입력값이 YES입니다. '
                   , 'NO', '입력값이 NO입니다. ')
                   , '입력값이 YES/NO중 어느 것도 아닙니다.')  AS 입력결과 
FROM dual
 ;
 
----------
입력값이 YES/NO 중 어느 것도 아닙니다. 
*/

--emp 테이블에서 job(직무) 별로 
--경조사비를 급여대비 일정 비율로 지급하기로 했다. 
--지급비율이 다음과 같다고 할 때,
--각 직원들의 경조사비 지원금을 구해보자.
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
                 , 'PRESIDENT', e.sal * 0.015) "경조사 지원금"
  FROM emp e 
; 
--경조사 자원비 결과에 숫자 패턴 입히기 
SELECT e.empno
    ,e.empno
    ,e.job
    , DECODE(e.job, 'CLERCK'   , e.sal * 0.5
                          , 'SALESMAN' , e.sal * 0.04
                          , 'MANAGER'  , e.sal * 0.037
                          , 'ANALYSIT' , e.sal * 0.03                     
                          , 'PRESIDENT', e.sal * 0.015) "경조사 지원금"
  FROM emp e 
; 

SELECT e.empno
    ,e.empno
    ,e.job
    , DECODE(e.job, 'CLERK'   ,to_char(300,'$9999')
                  , 'SALESMAN' ,to_char(450,'$9999')
                  , 'MANAGER'  , to_char(600,'$9999')
                  , 'ANALYST' ,to_char(800,'$9999')                    
                  , 'PRESIDENT', to_char(1000,'$9999')) "경조사 지원금"
  FROM emp e 
;