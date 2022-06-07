
select salary
from employees
where last_name = 'Grant';

select *
from employees
where salary >(select salary
                        from employees
                        where last_name = 'Grant')
and hire_date >(select hire_date
                        from employees
                        where last_name ='Grant');

--Subquery의 기본 사용
--group by절에는 못씀
SELECT salary 
FROM employees
WHERE last_name = 'Abel';
SELECT *
FROM employees
WHERE salary > 11000;
SELECT *
FROM employees
WHERE salary > (SELECT salary 
                             FROM employees
                            WHERE last_name = 'Abel');
--단일행 서브쿼리(Single Row Subquery)
--반환데이터가 1개
SELECT last_name, job_id, salary
FROM   employees
WHERE  job_id =  
                             (SELECT job_id
                              FROM   employees
                              WHERE  last_name = 'Matos')
AND    salary >
                             (SELECT salary
                              FROM   employees
                              WHERE  last_name = 'Matos');
SELECT MAX(salary) 
FROM employees;
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees);
SELECT   department_id, COUNT(*)
FROM     employees
GROUP BY department_id
HAVING  COUNT(*) > (SELECT COUNT(*)
                                         FROM   employees
                                         WHERE  department_id = 20);                
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                             WHERE department_id = 60);              
--다중 행 서브쿼리(Multiple Row Subquery)     
SELECT MAX(salary) 
FROM employees
GROUP BY department_id;
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                              GROUP BY department_id);    
SELECT last_name, job_id, salary
FROM   employees
WHERE salary IN (SELECT MAX(salary) 
                               FROM employees
                              GROUP BY department_id);  
/* = -> IN
 * <> -> NOT IN
 * >,>=,<,<=  -> ALL/ANY
 */                                                          
                              
SELECT salary 
FROM employees
WHERE department_id = 60;              
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary 
                              FROM employees
                             WHERE department_id = 60)
AND department_id <> 60;            -- 60번 부서 빼고 검색
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ANY (SELECT salary 
                                      FROM employees
                                      WHERE department_id = 60)
AND department_id <> 60; 
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ALL (SELECT salary 
                                    FROM employees
                                    WHERE department_id = 60)
AND department_id <> 60;

SELECT salary 
FROM employees
WHERE department_id = 60;

--Subquery 사용 시 주의사항
-- 1.서브쿼리 결과가 없는 경우
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary
                              FROM employees
                              WHERE last_name = 'Mark');
                              
-- 2.서브쿼리 결과에 null이 포함된 경우
SELECT employee_id, last_name
FROM employees 
WHERE employee_id IN (SELECT manager_id
                                           FROM employees);
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees);    


SELECT manager_id
 FROM employees;
 
-- not in을 하면 
SELECT employee_id, last_name
FROM employees 
WHERE manager_id IN (100, 101, NULL);

SELECT employee_id, last_name
FROM employees 
WHERE manager_id = 100
or manager_id = 101
or manager_id = NULL;

SELECT employee_id, last_name
FROM employees 
WHERE manager_id = NULL;


SELECT employee_id, last_name
FROM employees 
WHERE manager_id NOT IN (100, 101, NULL);

SELECT employee_id, last_name
FROM employees 
WHERE manager_id <> 100
and manager_id <> 101
and manager_id <> NULL;

SELECT employee_id, last_name, manager_id
FROM employees
where manager_id <> 100;

SELECT employee_id, last_name, manager_id
FROM employees
where manager_id <> NULL;

SELECT employee_id, last_name, manager_id
FROM employees;

SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees
                                                     WHERE manager_id IS NOT NULL);    

desc employees;