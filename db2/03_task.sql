with classes_avg as (select c.class,
                            avg(rsl.position)   as average_position,
                            count(rsl.position) as total_races
                     from results rsl
                              join cars c on c.name = rsl.car
                     group by c.class)
select c.*,
       cl.country as car_country,
       cl_avg.total_races
from (select c.name            as car_name,
             c.class           as car_class,
             avg(rsl.position) as average_position,
             count(*)          as race_count
      from results rsl
               join cars c on c.name = rsl.car
      group by c.name) c
         join classes_avg cl_avg on cl_avg.class = c.car_class
         join classes cl on cl.class = c.car_class
where cl_avg.average_position = (select min(average_position) from classes_avg);