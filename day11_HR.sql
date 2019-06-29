--HR 계정 활성화
--sys 에서 작업 
ALTER SESSION 
 SET "_ORACLE_SCRIPT"=true
;

@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main.sql;
@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_drop.sql;

--HR로 작업 
--2. DISTICT 
--1)EMPLOYEE의 JOB의 종류를 구하시오
SELECT DISTINCT job_id
  FROM employees e
;
--2)manageer는 몇명인가? 
SELECT COUNT(DISTINCT manager_id)
  FROM employees e
 ORDER BY manager_id
;
--3)부서번호가 가장 큰 부서는 어디인가?
SELECT DISTINCT e.department_id
     , d.department_name
  FROM employees e JOIN departments d ON(e.department_id = d.department_id)
;

SELECT MAX(new.department_id)   부서번호 
  FROM (SELECT DISTINCT e.department_id
                      , d.department_name
         FROM employees e JOIN departments d ON(e.department_id = d.department_id)) new
;

SELECT department_name 
  FROM departments 
 WHERE department_id = (SELECT MAX(new.department_id)   부서번호 
                            FROM (SELECT DISTINCT e.department_id
                                                , d.department_name
                                    FROM employees e JOIN departments d ON(e.department_id = d.department_id)) new)
;
--3. ORDER BY 
--1) 직원의 급여 지출이 많은 부서 순서대로 정렬하시오.
SELECT d.department_name
     , SUM(e.salary)
  FROM departments d JOIN employees e ON(e.department_id = d.department_id)
 GROUP BY d.department_name
 ORDER BY SUM(e.salary) DESC
;

--2) 많은 부서가 있는 도시 순서대로 정렬하시오(모든 도시를 출력)
---도시이름, 속한 부서의 개수 
SELECT l.city                "도시" 
     , COUNT(d.location_id)  "부서 수"
  FROM locations l LEFT OUTER JOIN departments d ON (l.location_id = d.location_id)
 GROUP BY l.city
 ORDER BY "부서 수" DESC
;

--3)직원들을 입사 년도가 빠른 순으로 정렬하시오.
---직원, 입사 날짜 
SELECT e.first_name                 이름
     , TO_CHAR(e.hire_date, 'YY')  입사년도
  FROM employees e
 ORDER BY 입사년도
;

--4. WHERE절 
--1) 매니저가 Kevin(직원번호124)인 직원을 추출
--name, id
SELECT e.employee_id
  FROM employees e
 WHERE e.first_name = 'Kevin' 
   AND e.last_name = 'Mourgos'
;

SELECT e.first_name
     , e.employee_id
  FROM employees e JOIN employees e1 ON (e.manager_id = e1.employee_id)
 WHERE e.manager_id = (SELECT e2.employee_id
                        FROM employees e2
                      WHERE e2.first_name = 'Kevin' 
                      AND e2.last_name = 'Mourgos')
;
--2) 급여가 2000에서 3000사이인 직원 추출 
--직원이름, 급여
SELECT e.first_name
     , e.salary
  FROM employees e
 WHERE e.salary BETWEEN 2000 AND 3000
;

--3)소속부서번호가 100인 직원들을 구하시오 
--소속부서번호, 직원이름 
SELECT e.department_id
     , e.first_name
  FROM employees e
 WHERE e.department_id = 100
;

--5. 연산자
--1)commission을 받는 직원을 뽑으시오
SELECT e.first_name
  FROM employees e 
 WHERE commission_pct IS NOT NULL 
;
--2)최소 5000 이상의 급여를 받는 부서 id 목록을 뽑으시오
--job id, min salary
SELECT j.job_id
     , j.min_salary
  FROM jobs j
 WHERE min_salary > 5000
;
--3)입사일이 2007년 이후이거나 급여가 3000 이하인 직원의 목룍을 뽑으시오 
--employee_id, first_name, last_name, 입사일, 급여
SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.hire_date
     , e.salary
  FROM employees e 
 WHERE TO_CHAR(e.hire_date, 'YY') >= '07'
UNION
SELECT e.employee_Id
     , e.first_name
     , e.last_name
     , e.hire_date
     , e.salary
  FROM employees e 
 WHERE e.salary <= 3000 
; 

SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.hire_date
     , e.salary
  FROM employees e 
 WHERE TO_CHAR(e.hire_date, 'YY') >= '07'
INTERSECT
SELECT e.employee_Id
     , e.first_name
     , e.last_name
     , e.hire_date
     , e.salary
  FROM employees e 
 WHERE e.salary <= 3000 
;

--6. 단일행 함수

--7.복수행 함수



