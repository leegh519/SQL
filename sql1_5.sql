--GROUP 함수의 기본 사용
-- null값은 빼고 계산함
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees;
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees
WHERE  department_id = 60;
SELECT MIN(last_name), MAX(last_name)
FROM employees;
SELECT MIN(hire_date), MAX(hire_date)
FROM employees;
-- count만 *, distinct 쓸수있음
SELECT COUNT(*), COUNT(department_id), COUNT(DISTINCT department_id)
FROM employees;
SELECT AVG(commission_pct), AVG(NVL(commission_pct, 0))
FROM employees;

--GROUP BY 절의 사용
SELECT department_id, SUM(salary), COUNT(*)
FROM employees;
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id;
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 1;
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id >= 50
GROUP BY department_id, job_id
ORDER BY 1,2;

-----순서 (FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY)

--HAVING 절의 사용
-- 그룹을 선택하는 기능??
-- group by있어야 사용가능
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE COUNT(*) <> 1
GROUP BY department_id, job_id
ORDER BY 1,2;
SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1
ORDER BY 1,2;
SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id <> 90
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1
ORDER BY 1,2;

--GROUP 함수의 중첩
SELECT MAX(SUM(salary))
FROM employees
GROUP BY department_id;
SELECT department_id, MAX(SUM(salary))
FROM employees
GROUP BY department_id;