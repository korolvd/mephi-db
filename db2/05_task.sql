with cars_avg as (select c.name            as car_name,
                         c.class           as car_class,
                         avg(rsl.position) as average_position,
                         count(*)          as race_count
                  from results rsl
                           join cars c on c.name = rsl.car
                  group by c.name
                  having avg(rsl.position) > 3),
     classes_avg as (select c.class,
                            count(rsl.position)            as total_races,
                            count(distinct c_avg.car_name) as low_position_count
                     from results rsl
                              join cars c on c.name = rsl.car
                              left join cars_avg c_avg on c.name = c_avg.car_name
                     group by c.class)
select c_avg.*,
       cl.country as car_country,
       cl_avg.total_races,
       cl_avg.low_position_count
from cars_avg c_avg
         join classes_avg cl_avg on cl_avg.class = c_avg.car_class
         join classes cl on cl.class = c_avg.car_class
order by cl_avg.low_position_count;