with recursive empl_struct as (select e.employeeid,
                                      e.name,
                                      e.managerid,
                                      e.departmentid,
                                      e.roleid
                               from employees e
                               where e.employeeid = 1
                               union all
                               select e.employeeid,
                                      e.name,
                                      e.managerid,
                                      e.departmentid,
                                      e.roleid
                               from employees e
                                        inner join empl_struct es on e.managerid = es.employeeid)
select es.employeeid                                              as "EmployeeID",
       es.name                                                    as "EmployeeName",
       es.managerid                                               as "ManagerID",
       d.departmentname                                           as "DepartmentName",
       r.rolename                                                 as "RoleName",
       coalesce(string_agg(distinct p.projectname, ', '), 'NULL') as "ProjectNames",
       coalesce(string_agg(distinct t.taskname, ', '), 'NULL')    as "TaskNames"
from empl_struct es
         left join departments d on es.departmentid = d.departmentid
         left join roles r on es.roleid = r.roleid
         left join projects p on p.departmentid = es.departmentid
         left join tasks t on es.employeeid = t.assignedto
group by es.employeeid, es.name, es.managerid, d.departmentname, r.rolename
order by es.name;
