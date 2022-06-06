SELECT COUNT(salary)
FROM employees
WHERE salary<(SELECT AVG(salary)
                FROM employees);
                
SELECT department_id, salary, employee_id
FROM employees
WHERE department_id <> 90;

SELECT hire_date, last_name
FROM employees
WHERE hire_date > '00/01/01';

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500;

SELECT  last_name, salary, department_id
FROM employees
WHERE department_id IN(50, 60, 70, 10);

SELECT last_name, salary
FROM employees
WHERE last_name LIKE'A%';

SELECT last_name, salary
FROM employees
WHERE salary LIKE '2___';

SELECT last_name
FROM employees
WHERE manager_id IS NOT NULL;

SELECT last_name, salary, manager_id
FROM employees
WHERE manager_id IS NOT NULL
AND last_name LIKE '_____';

SELECT last_name, salary, hire_date
FROM employees
ORDER BY hire_date;

SELECT last_name, salary, hire_date
FROM employees
ORDER BY hire_date DESC;

SELECT last_name, manager_id 
FROM employees
ORDER BY 1, 2 DESC;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE department_id = &department_num;


--q1
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE last_name LIKE '%s';

--q2
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 50
AND job_id = 'ST_CLERK';

--q3
--집합연산자 사용x
SELECT employee_id , last_name, job_id, salary, department_id
FROM employees
WHERE salary>2000
AND department_id IN(20, 50);

--집합연산자 사용은 모르겠음
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE salary > 2000
UNION
SELECT employee_id, last_name,job_id, salary, department_id FROM employees
WHERE department_id IN (20, 50);


--q1
--사원번호, 사원이름 *처리
SELECT employee_id, rpad(substr(employee_id, 1,1),3,'*') AS masking_employee_id,
last_name, rpad(substr(last_name,1,1),5,'*')
FROM employees
WHERE last_name LIKE '_____';

--q2 / 반올림, 버림
SELECT employee_id, last_name, salary, trunc((salary/21.5),2) AS day_pay, round((salary/21.5/8),1) AS time_pay
FROM employees;

SELECT employee_id, last_name, hire_date, next_day( add_months(hire_date, 3),2) AS r_job, 
nvl(to_char(commission_pct),  'N/A') AS comm
FROM employees;


--q3
-- chat로 변환하고 null이면 'N/A', null아니면 형변환하면서 0없어진거 붙임
SELECT employee_id, last_name, hire_date, next_day( add_months(hire_date, 3),2) AS r_job, 
nvl2(to_char(commission_pct),  concat(0,commission_pct),'N/A') AS comm
FROM employees;


--q4
--manager_id 끝자리에 따라 출력
--null이면 000, 1~5안에 없으면 그대로 출력
SELECT employee_id, last_name, manager_id, 
CASE  
            WHEN substr(manager_id, 3, 3)='1' THEN '111'
            WHEN substr(manager_id, 3, 3)='2' THEN '222'
            WHEN substr(manager_id, 3, 3)='3' THEN'333'
            WHEN substr(manager_id, 3, 3)= '4' THEN'444'
            WHEN substr(manager_id, 3, 3)='5' THEN '555'
            WHEN manager_id IS NULL THEN '000'
            ELSE to_char(manager_id) END chf_mgr
FROM employees
ORDER BY 4;

--q1
SELECT department_id, trunc(AVG(salary),0) AS avg_sal, MAX(salary) AS max_sal,
          MIN(salary) AS min_sal, COUNT(*) AS cnt
FROM employees
GROUP BY department_id
ORDER BY department_id;

--q2
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 3;

-- q3
SELECT to_char(hire_date, 'yyyy') AS hire_year, department_id, COUNT(*) AS cnt
FROM employees
GROUP BY department_id, to_char(hire_date, 'yyyy')
ORDER BY 1;

-- q4
SELECT nvl2(commission_pct, 'O', 'X') AS exist_comm, COUNT(*)
FROM employees
GROUP BY nvl2(commission_pct, 'O', 'X');

-- q5
SELECT department_id, to_char(hire_date, 'yyyy') AS hire_year, COUNT(*), 
          MAX(salary) AS max_sal, SUM(salary) AS sum_sal, AVG(salary) AS avg_sal
FROM employees
GROUP BY department_id, to_char(hire_date, 'yyyy')
ORDER BY 1,2;

