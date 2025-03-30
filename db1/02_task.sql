select *
from vehicle v
         join (select c.model, c.horsepower, c.engine_capacity
               from car c
               where c.horsepower > 150
                 and c.engine_capacity < 3
                 and c.price < 35000
               union
               select m.model, m.horsepower, m.engine_capacity
               from motorcycle m
               where m.horsepower > 150
                 and m.engine_capacity < 1.5
                 and m.price < 20000
               union
               select b.model, null, null
               from bicycle b
               where b.gear_count > 18
                 and b.price < 4000) t on v.model = t.model
order by t.horsepower desc nulls last;