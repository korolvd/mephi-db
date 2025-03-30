select *
from (select distinct on (c.class) c.name          as car_name,
                                   c.class         as car_class,
                                   avg(r.position) as average_position,
                                   count(*)        as race_count
      from results r
               join cars c on c.name = r.car
      group by c.name, c.class
      order by c.class, average_position) t
order by t.average_position;