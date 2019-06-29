--HR ���� Ȱ��ȭ
--sys ���� �۾� 
ALTER SESSION 
 SET "_ORACLE_SCRIPT"=true
;

@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main.sql;
@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_drop.sql;

--HR�� �۾� 
--2. DISTICT 
--1)EMPLOYEE�� JOB�� ������ ���Ͻÿ�
SELECT DISTINCT job_id
  FROM employees e
;
--2)manageer�� ����ΰ�? 
SELECT COUNT(DISTINCT manager_id)
  FROM employees e
 ORDER BY manager_id
;
--3)�μ���ȣ�� ���� ū �μ��� ����ΰ�?
SELECT DISTINCT e.department_id
     , d.department_name
  FROM employees e JOIN departments d ON(e.department_id = d.department_id)
;

SELECT MAX(new.department_id)   �μ���ȣ 
  FROM (SELECT DISTINCT e.department_id
                      , d.department_name
         FROM employees e JOIN departments d ON(e.department_id = d.department_id)) new
;

SELECT department_name 
  FROM departments 
 WHERE department_id = (SELECT MAX(new.department_id)   �μ���ȣ 
                            FROM (SELECT DISTINCT e.department_id
                                                , d.department_name
                                    FROM employees e JOIN departments d ON(e.department_id = d.department_id)) new)
;
--3. ORDER BY 
--1) ������ �޿� ������ ���� �μ� ������� �����Ͻÿ�.
SELECT d.department_name
     , SUM(e.salary)
  FROM departments d JOIN employees e ON(e.department_id = d.department_id)
 GROUP BY d.department_name
 ORDER BY SUM(e.salary) DESC
;

--2) ���� �μ��� �ִ� ���� ������� �����Ͻÿ�(��� ���ø� ���)
---�����̸�, ���� �μ��� ���� 
SELECT l.city                "����" 
     , COUNT(d.location_id)  "�μ� ��"
  FROM locations l LEFT OUTER JOIN departments d ON (l.location_id = d.location_id)
 GROUP BY l.city
 ORDER BY "�μ� ��" DESC
;

--3)�������� �Ի� �⵵�� ���� ������ �����Ͻÿ�.
---����, �Ի� ��¥ 
SELECT e.first_name                 �̸�
     , TO_CHAR(e.hire_date, 'YY')  �Ի�⵵
  FROM employees e
 ORDER BY �Ի�⵵
;

--4. WHERE�� 
--1) �Ŵ����� Kevin(������ȣ124)�� ������ ����
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
--2) �޿��� 2000���� 3000������ ���� ���� 
--�����̸�, �޿�
SELECT e.first_name
     , e.salary
  FROM employees e
 WHERE e.salary BETWEEN 2000 AND 3000
;

--3)�ҼӺμ���ȣ�� 100�� �������� ���Ͻÿ� 
--�ҼӺμ���ȣ, �����̸� 
SELECT e.department_id
     , e.first_name
  FROM employees e
 WHERE e.department_id = 100
;

--5. ������
--1)commission�� �޴� ������ �����ÿ�
SELECT e.first_name
  FROM employees e 
 WHERE commission_pct IS NOT NULL 
;
--2)�ּ� 5000 �̻��� �޿��� �޴� �μ� id ����� �����ÿ�
--job id, min salary
SELECT j.job_id
     , j.min_salary
  FROM jobs j
 WHERE min_salary > 5000
;
--3)�Ի����� 2007�� �����̰ų� �޿��� 3000 ������ ������ ���� �����ÿ� 
--employee_id, first_name, last_name, �Ի���, �޿�
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

--6. ������ �Լ�

--7.������ �Լ�


