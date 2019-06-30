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
--1)CASE / �μ� �ο� ���� ���� ȸ�ĺ� �ٸ��ٰ� �Ѵ�. 
--3�� �̳�: 100, 6�� �̳�: 200, 10�� �̻�: 300
--�� �μ��� �ο����� ���� ȸ�ĺ� ���Ͻÿ� 
SELECT e.department_id �μ���ȣ
     , d.department_name �μ��� 
     , to_CHAR(CASE WHEN COUNT(e.department_id) <=3 THEN 100 
                    WHEN COUNT(e.department_id) <=6 THEN 150 
                    WHEN COUNT(e.department_id) >10 THEN 300  END, '$999')
                AS ȸ�ĺ�
  FROM employees e JOIN departments d ON e.dapartment_id = d.department_id 
 GROUP BY e.department_id, d.department_name
;
--����

--�μ��� �ο��� ���ϱ� -> ȸ�ĺ� �߰� 
SELECT e.department_id
     , COUNT(e.department_id)
     , to_CHAR(CASE WHEN COUNT(e.department_id) <=3 THEN 100 
                    WHEN COUNT(e.department_id) <=6 THEN 150 
                    WHEN COUNT(e.department_id) >10 THEN 300  END, '$999')
                AS ȸ�ĺ�
  FROM employees e
 GROUP BY e.department_id
 ORDER BY ȸ�ĺ�
;

--7.������ �Լ�
--1)�μ��� �������� �� �޿��� ���Ͻÿ� 
--�μ�, �޿��� �� 
SELECT d.department_name
     , SUM(e.salary)
  FROM employees e JOIN departments d ON (e.department_id = d.department_id)
 GROUP BY d.department_name
;
--2)���������� ���� ���� �����? 
SELECT e1.first_name       ���
     , COUNT(e.manager_id) ����������
  FROM employees e JOIN employees e1 ON (e.manager_id = e1.employee_id)
 GROUP BY e1.first_name
 HAVING COUNT(e.manager_id) = (SELECT MAX(COUNT(e.manager_id)) 
                                FROM employees e JOIN employees e1 ON (e.manager_id = e1.employee_id)
                               GROUP BY e1.first_name)
;
--3)������ �ּұ޿��� ���� ���� �μ���?
--����, �ּұ޿�
SELECT j.job_title
     , j.min_salary
  FROM jobs j
 GROUP BY j.job_title, j.min_salary
 HAVING j.min_salary = (SELECT MIN(j.min_salary)
                        FROM jobs j)
;

--8. ���� 
--1)EQUI-JOIN(or NON-EQUI JOIN) / ������ �ּұ޿��� �ִ�޿��� ���Ͻÿ�
--���� id, �ּ� �޿�, �ִ� �޿�
SELECT e.employee_id
     , j.min_salary
     , j.max_salary
  FROM employees e JOIN JOBS j ON (e.job_id = j.job_id)
  ORDER BY j.min_salary DESC
;
--2)OUTER-JOIN / ��� �μ��� �Ŵ��� �̸��� ����Ͻÿ�(�Ŵ����� ������ '-'���� ��Ÿ���ÿ�) 
SELECT d.department_name                        "�μ�"
     , NVL(TO_CHAR(e.manager_id), '-')       "�Ŵ��� ��ȣ"
     , NVL(e1.first_name, '-')               "�Ŵ��� �̸�"
  FROM departments d LEFT OUTER JOIN employees e ON (d.manager_id = e.manager_id) 
                     LEFT OUTER JOIN employees e1 ON(e.manager_id = e1.employee_id)
 GROUP BY d.department_name
        , NVL(TO_CHAR(e.manager_id), '-')      
        , NVL(e1.first_name, '-')
 ORDER BY NVL(TO_CHAR(e.manager_id), '-') DESC        
;

--3)SELF-JOIN / �Ŵ��� ��ȣ�� �Ŵ��� �̸��� �Ŵ����� ������ ���Ͻÿ� 
SELECT e1.employee_id       "�Ŵ��� ��ȣ"
     , e1.first_name        "�Ŵ��� �̸�"
     , j.job_title          "�Ŵ��� ����"
  FROM employees e JOIN employees e1 ON e.manager_id = e1.employee_id
                   JOIN jobs j ON e.job_id = j.job_id
 GROUP BY e1.employee_id
        , e1.first_name
        , j.job_title
 ORDER BY e1.employee_id
;

--9. �������� 
--1) �Ŵ��� �� ���� ���� �޿��� �޴� �Ŵ����� ��ȣ�� �̸��� �޿��� ����Ͻÿ� 

SELECT w.manager_id
     , w.first_name
     , w.salary
  FROM (SELECT e.manager_id
             , e1.first_name
             , e1.salary
          FROM employees e JOIN employees e1 ON e.manager_id = e1.employee_id 
         GROUP BY e.manager_id
                , e1.first_name
                , e1.salary) w
 WHERE w.salary = (SELECT MAX(e1.salary)
                     FROM employees e JOIN employees e1 ON e.manager_id = e1.employee_id)
;

--2)

--3)



