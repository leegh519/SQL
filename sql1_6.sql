SELECT employee_id, last_name, department_id
FROM employees;

SELECT *
FROM departments;
SELECT *
FROM locations;
SELECT employee_id, last_name, salary, department_id, department_name
FROM employees JOIN departments
USING (department_id);
/*
JOIN-문법으로 분류
-NATURAL JOIN
-JOIN~USING
-JOIN~ON
-[LEFT|RIGHT|FULL] OUTER JOIN
*/

--NATURAL JOIN
-- 알아서 겹치는 컬럼으로 join
-- join가능한 컬럼이 하나일때 사용
SELECT * 
FROM departments;
SELECT * 
FROM locations;
SELECT department_id, department_name, location_id, city, street_address
FROM departments NATURAL JOIN locations;
-- 겹치는 컬럼이 2개라서 둘다 join해서 출력함
SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;

--USING 절을 사용하는 JOIN
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);
SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
USING (manager_id);
SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON절을 사용하는 JOIN
-- 컬럼 이름이 다를때 사용
-- department_id가 어느테이블의 컬럼인지 알수없음
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);

--테이블 이름 별칭 사용
SELECT employees.employee_id, employees.last_name, 
               employees.department_id, departments.department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
SELECT e.employee_id, e.last_name, 
       e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

--WHERE 절 추가
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.salary > 9000;
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 9000;

--INNER JOIN과 OUTER JOIN
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

--USING절에 OUTER 조인하기
SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments
USING (department_id);
SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments
USING (department_id);

--SELF JOIN
SELECT employee_id, last_name, manager_id
FROM employees;
-- 별칭필수
SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e JOIN employees m
ON (e.manager_id = m.employee_id);
SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e left OUTER JOIN employees m
ON (e.manager_id = m.employee_id);

--NON-EQUI JOIN
SELECT * 
FROM job_grades;
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

--3Way JOIN
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

--Cartesian Products
--전체 경우의 수 출력
SELECT employee_id, city
FROM employees NATURAL JOIN locations;
SELECT employee_id, department_name
FROM employees CROSS JOIN departments;

--GROUP함수와 JOIN 응용
SELECT   d.department_name, MIN(e.salary), 
                MAX(e.salary),trunc(AVG(e.salary))
FROM     employees e JOIN departments d
ON       (e.department_id = d.department_id)
GROUP BY d.department_name;
