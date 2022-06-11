

---------------------------------------------------------------
--JOIN 문제
---------------------------------------------------------------

-- Q1
SELECT deptno, d.dname, e.empno, e.ename, e.sal
FROM dept d JOIN emp e
USING (deptno)
WHERE e.sal>2000
ORDER BY 1, 3;

--Q2
SELECT deptno, dname, trunc(AVG(sal)) avg_sal, MAX(sal) max_sal, MIN(sal) min_sal, COUNT(*) cnt
FROM dept  JOIN emp
USING (deptno)
GROUP BY deptno, dname;

--Q3
SELECT deptno, dname, empno, ename, job, sal
FROM dept LEFT OUTER JOIN emp
USING (deptno)
ORDER BY 1, 3;

--Q4
SELECT d.deptno, d.dname, e.empno, e.ename, e.mgr, e.sal, d.deptno deptno_1,
s.losal, s.hisal, s.grade, m.empno mgr_empno, m.ename mgr_ename
FROM dept d FULL OUTER JOIN emp e
ON (d.deptno = e.deptno)
FULL OUTER JOIN salgrade s
ON (e.sal BETWEEN s.losal AND s.hisal)
LEFT OUTER JOIN emp m
ON (e.mgr = m.empno)
ORDER BY 1,3;

---------------------------------------------------------------
--JOIN + 서브쿼리
---------------------------------------------------------------
--Q1
SELECT job, empno, ename, sal, deptno, dname
FROM emp JOIN dept
USING (deptno)
WHERE job = (
            SELECT job
            FROM emp
            WHERE ename = 'ALLEN');

--Q2
select e.empno, e.ename, d.dname, 
to_char(e.hiredate, 'yyyy-mm-dd') hiredate, d.loc, e.sal, s.grade
from emp e join dept d
on (e.deptno = d.deptno)
join salgrade s
on (e.sal between s.losal and s.hisal)
where sal > 
            (select avg(sal)
            from emp)
order by 6 desc, 1;

--Q3
select e.empno, e.ename, e.job, d.deptno, d.dname, d.loc
from emp e join dept d
on (e.deptno = d.deptno)
where d.deptno = 10
and e.job not in 
            (select job
            from emp
            where deptno = 30);

--Q4            
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on (e.sal between s.losal and s.hisal)
where sal >
            (select max(sal)
            from emp
            where job = 'SALESMAN');
---------------------------------------------------------------
--DML
---------------------------------------------------------------
--Q1
create table chap10hw_emp
as
select * from emp;

create table chap10hw_dept
as
select * from dept;

create table chap10hw_salgrade
as
select * from salgrade;

insert into chap10hw_dept
values (50, 'ORACLE', 'BUSAN');
insert into chap10hw_dept
values (60, 'SQL', 'ILSAN');
insert into chap10hw_dept
values (70, 'SELECT', 'INCHEON');
insert into chap10hw_dept
values (80, 'DML', 'BUNDANG');
select * from chap10hw_dept;
commit;

--Q2
insert into chap10hw_emp
values (7201, 'TEST_USER1', 'MANAGER', 7788, to_date('2016-01-02','yyyy-mm-dd'),  4500, null, 50);
insert into chap10hw_emp
values (7202, 'TEST_USER2', 'CLERK', 7201, to_date('2016-02-21','yyyy-mm-dd'),  1800, null, 50);
insert into chap10hw_emp
values (7203, 'TEST_USER3', 'ANALYST', 7201,to_date('2016-04-11','yyyy-mm-dd'),  3400, null, 60);
insert into chap10hw_emp
values (7204, 'TEST_USER4', 'SALESMAN', 7201, to_date('2016-05-31','yyyy-mm-dd'),  2700, 300, 60);
insert into chap10hw_emp
values (7205, 'TEST_USER5', 'CLERK', 7201,to_date('2016-07-20','yyyy-mm-dd'),  2600, null, 70);
insert into chap10hw_emp
values (7206, 'TEST_USER6', 'CLERK', 7201, to_date('2016-09-08','yyyy-mm-dd'),  2600, null, 70);
insert into chap10hw_emp
values (7207, 'TEST_USER7', 'LECTURER', 7201, to_date('2016-10-28','yyyy-mm-dd'),  2300, null, 80);
insert into chap10hw_emp
values (7208, 'TEST_USER8', 'STUDENT', 7201, to_date('2018-03-09','yyyy-mm-dd'),  1200, null, 80);

select * from chap10hw_emp;
commit;

--Q3
update chap10hw_emp
set deptno = 70
where sal >
            (select avg(sal)
            from chap10hw_emp
            where deptno = 50);
select * from chap10hw_emp
order by deptno;
commit;

--Q4
update chap10hw_emp
set sal = sal*1.1,
            deptno = 80
where hiredate >
            (select min(hiredate)
            from chap10hw_emp
            where deptno = 60); 
 commit;
 
 --Q5
 delete from chap10hw_emp
 where sal between 
            (select losal
            from chap10hw_salgrade
            where grade =5)
and
            (select hisal
            from chap10hw_salgrade
            where grade =5);
select * from chap10hw_emp;

---------------------------------------------------------------
--DDL
---------------------------------------------------------------
--Q1
create table emp_hw
            (empno number(4),
            ename varchar2(10),
            job varchar(9),
            mgr number(4),
            hiredate date,
            sal number(7,2),
            comm number(7,2),
            deptno number(2));
            

