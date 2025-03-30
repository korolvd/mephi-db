select v.maker,
       m.model
from vehicle v
         join motorcycle m on v.model = m.model
where m.horsepower > 150
  and m.price < 20000
  and m.type = 'Sport'
order by m.horsepower desc;