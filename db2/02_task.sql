select c.name          as car_name,
       cl.class        as car_class,
       avg(r.position) as average_position,
       count(r.race)   as race_count,
       cl.country      as car_country
from cars c
         join results r on c.name = r.car
         join classes cl on cl.class = c.class
group by c.name, cl.class
order by average_position, car_name
limit 1;