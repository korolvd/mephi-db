with recursive manager_struct as (select e.employeeid,
                                         e.name,
                                         e.managerid,
                                         e.departmentid,
                                         e.roleid
                                  from employees e
                                           inner join roles r on e.roleid = r.roleid
                                  where r.rolename = 'Менеджер'
                                  union all
                                  select e.employeeid,
                                         e.name,
                                         e.managerid,
                                         e.departmentid,
                                         e.roleid
                                  from employees e
                                           inner join manager_struct ms on e.managerid = ms.employeeid)

select ms.employeeid                                              as "EmployeeID",
       ms.name                                                    as "EmployeeName",
       ms.managerid                                               as "ManagerID",
       d.departmentname                                           as "DepartmentName",
       r.rolename                                                 as "RoleName",
       coalesce(string_agg(distinct p.projectname, ', '), 'NULL') as "ProjectNames",
       coalesce(string_agg(distinct t.taskname, ', '), 'NULL')    as "TaskNames",
       count(distinct e.employeeid)                               as "TotalSubordinates"
from manager_struct ms
         left join departments d on ms.departmentid = d.departmentid
         left join roles r on ms.roleid = r.roleid
         left join projects p on ms.departmentid = p.departmentid
         left join tasks t on ms.employeeid = t.assignedto
         left join employees e on ms.employeeid = e.managerid
group by ms.employeeid, ms.name, ms.managerid, d.departmentname, r.rolename
having count(distinct e.employeeid) > 0
order by ms.name;