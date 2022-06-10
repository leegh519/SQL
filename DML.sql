/*
접속  ------- 세션시작
SELECT...
DML(INSERT/UPDATE/DELETE) ---------- Transaction 시작
DML
DML
SELECT...
DDL ------------------- 자동으로 commit 시켜줌
DML
COMMIT/ROLLBACK ----------- Transaction 종료

DML(INSERT/UPDATE/DELETE) ---------- Transaction 시작
DML
DML
DML
COMMIT/ROLLBACK ----------- Transaction 종료

접속해제 ------- 세션종료
*/



--INSERT 문장 작성과 Transaction(행단위)
--1번 HR
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);
SELECT * FROM departments;
ROLLBACK;

--1번 HR
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);
SELECT * FROM departments;
COMMIT;
--특별한 값 입력
--SYSDATE 입력
INSERT INTO employees 
VALUES		   (113,  'Louis', 'Popp', 'LPOPP', '515.124.4567', 
                        SYSDATE, 'AC_ACCOUNT', 6900,  NULL, 205, 110);
--TO_DATE 함수 사용
INSERT INTO employees
VALUES      (114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561',
                      TO_DATE('02 03, 99', 'MM DD, YY'), 'SA_REP', 11000, 0.2, 100, 60);
INSERT INTO employees
VALUES      (115, 'Mark', 'Kim', 'MKIM', '515.127.4562',
                      TO_DATE('02 03, 99', 'MM DD, RR'),
                      'SA_REP', 13000, 0.25, 100, 60);             
SELECT * FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy/mm/dd') AS hire_date
FROM employees;


--다른 테이블로 행 복사
CREATE TABLE sales_reps
AS
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees
--빈테이블 복사하려고 아무것도 안나오게 조건넣음
WHERE 1=2;

desc sales_reps;

--치환변수 사용(40, Human Resource, 2500 입력)
INSERT INTO departments(department_id, department_name, location_id)
VALUES     (&department_id, '&department_name',&location);
COMMIT;

select * from departments;


--UPDATE(필드단위)
--1번 HR
UPDATE employees
SET salary= 7000;
SELECT * FROM employees;
ROLLBACK;
UPDATE employees
SET salary= 7000
WHERE employee_id = 104;
ROLLBACK;

--서브쿼리를 사용한 UPDATE
UPDATE   employees
SET      job_id  = (SELECT  job_id 
                              FROM    employees 
                              WHERE   employee_id = 205), 
             salary  = (SELECT  salary 
                             FROM    employees 
                              WHERE   employee_id = 205) 
WHERE    employee_id    =  113;
UPDATE employees
SET  department_id =
                                      (SELECT department_id
                                       FROM   departments
                                       WHERE  department_name LIKE '%Public%')
WHERE employee_id = 115;
COMMIT;

--DELETE
DELETE FROM departments
WHERE  department_name = 'Finance';

DELETE FROM employees
WHERE  department_id =
                                  (SELECT department_id
                                   FROM   departments
                                   WHERE  department_name LIKE '%Public%');
COMMIT;

delete from departments;


--DELETE 와 TRUNCATE
SELECT * FROM sales_reps;
DELETE FROM sales_reps;
SELECT * FROM sales_reps;
ROLLBACK;
SELECT * FROM sales_reps;

-- TRUNCATE는
-- DDL이라서 자동으로 커밋되버림..
TRUNCATE TABLE sales_reps;
SELECT * FROM sales_reps;
ROLLBACK;
SELECT * FROM sales_reps;
INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';
SELECT * FROM sales_reps;
COMMIT;
