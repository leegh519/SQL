
--1.
DESC employees;

--2.
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary BETWEEN 5000 AND 9000
AND department_id =60;

--3.
SELECT employee_id, last_name, hire_date,
SUBSTR(email, 1,3),
INSTR(email, 'E'),
LENGTH(email)
FROM employees
WHERE hire_date>'99/01/01';

--4.
SELECT last_name, hire_date,
ADD_MONTHS(hire_date, 6), 
NEXT_DAY(hire_date, 6), 
TRUNC(MONTHS_BETWEEN(sysdate, hire_date)),
LAST_DAY(hire_date)
FROM employees;

--5.
SELECT employee_id, last_name,
TO_CHAR(salary, '$999,999') AS 급여
FROM employees
ORDER BY 3 DESC;

--6.
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE commission_pct IS NOT NULL
AND job_id LIKE '%REP%';

--7.
SELECT COUNT(*) 인원수, SUM(salary) 총급여, AVG(salary)평균급여, 
MIN(salary) 최소급여, MAX(salary)최대급여, department_id 부서번호
FROM employees
GROUP BY department_id
HAVING COUNT(*)<>1;

--8.
SELECT employee_id, last_name, department_id,
CASE department_id
            WHEN 20 THEN 'Canada'
            WHEN 80 THEN 'UK'
            ELSE 'USA' END 근무지역
FROM employees;

--9.
SELECT e.employee_id, e.last_name, department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
USING (department_id);
   
--10.
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE salary = (SELECT MAX(salary)
                        FROM employees
                        WHERE department_id =50);