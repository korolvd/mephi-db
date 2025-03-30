with classes_avg as (select c.class,
                            avg(rsl.position) as average_position
                     from results rsl
                              join cars c on rsl.car = c.name
                     group by c.class
                     having count(c.name) > 1)
select c.*,
       cl.country as car_country
from (select c.name            as car_name,
             c.class           as car_class,
             avg(rsl.position) as average_position,
             count(*)          as race_count
      from results rsl
               join cars c on c.name = rsl.car
      group by c.name, c.class) c
         join classes_avg cl_avg on cl_avg.class = c.car_class
         join classes cl on cl.class = c.car_class
where c.average_position < cl_avg.average_position
order by c.car_class, c.average_position;