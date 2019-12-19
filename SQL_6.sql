--1
/*Find positions which occure in dept 10 and dept 20*/
select job
from emp
where deptno=10 or deptno=20;

--2
/*Find job such that there was a person employed on this position in the year 1982 and also in 2005.*/
select job
from emp
where hiredate between '01-JAN-82' and '31-DEC-82'
intersect
select job
from emp
where hiredate between '01-JAN-05' and '31-DEC-05';

--3
/*Find name of department in NEW YORK and peaople working there.*/
select dname, ename,loc
from emp e, dept d
where e.deptno=d.deptno and loc='NEW YORK';

--4
/*Find jobs such that at least one person having this job earns salary in grade 2*/
select job,count(empno)
from emp,salgrade
where sal between losal and hisal and grade=2
group by job;

--5
/*Find staff numbers who work longer than their supervisor*/
select e.ename,e.hiredate,b.ename,b.hiredate
from emp e, emp b
where e.mgr=b.empno and e.hiredate<b.hiredate;

--6
/*How much money do you need to pay yearly income for peaople in each grade.*/
select grade, sum(sal*12+nvl(comm,0))
from emp,salgrade
where sal between losal and hisal
group by grade;

--7
/*For each boss find the number of peaople supervised by him.*/
select b.ename,count(e.empno)
from emp e,emp b
where e.mgr=b.empno
group by b.ename;

--8
/*Find names of departments employing more than 3 staff member.*/
select dname,count(empno)
from dept d,emp e
where d.deptno=e.deptno
group by dname
having count(empno)>3;

--9
/*Find min salary for each job in each location.*/
select loc,job,min(sal)
from dept d,emp e
where d.deptno=e.deptno
group by loc,job;


select job,sal,loc
from dept d,emp e
where d.deptno=e.deptno
and (loc,sal) in (
select loc,min(sal)
from dept d,emp e
where d.deptno=e.deptno
group by loc);

--10
/*Find peaople earning the smallest salary for each location.*/
select ename
from dept d,emp e
where d.deptno=e.deptno
and (sal,loc) in (
select min(sal),loc from dept d,emp e
where d.deptno=e.deptno
group by loc );

--11
/*Who does earn max salary for each grade?*/
select ename,sal
from emp,salgrade
where sal between losal and hisal 
and (grade,sal) in (
select grade,max(sal)
from emp,salgrade
where sal between losal and hisal
group by grade
);

--12
/*Who earns more than person earning max salary of all having the same job as 'FORD'.*/
select ename,sal
from emp
where sal >(
select max(sal)
from emp
where ename='FORD');

--13
/*Who earns more than average salary for his location?*/
select ename,sal,loc
from emp e,dept d
where e.deptno=d.deptno and sal >(
select avg(sal) 
from emp v,dept f 
where v.deptno=f.deptno and f.loc = d.loc);

--14
/*Find location with biggest number of peaople employed.*/
select loc,count(empno)
from emp e,dept d
where e.deptno = d.deptno
group by loc
having count(empno)=(
select max(count(empno))
from emp
group by deptno);

--15
/*Show names of supervisors who supervise somebody in 'DALLAS'.*/
select distinct b.ename
from emp e,emp b
where e.mgr=b.empno and e.deptno=(select deptno from dept where loc='DALLAS');




