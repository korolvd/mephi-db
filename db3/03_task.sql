select *
from (with c_hotel as (select h.id_hotel,
                              h.name,
                              avg(r.price) as avg_price
                       from hotel h
                                join room r on h.id_hotel = r.id_hotel
                       group by h.id_hotel)
      select c.id_customer,
             c.name,
             case
                 when max(h.avg_price) > 300 then 'Дорогой'
                 when max(h.avg_price) < 175 then 'Дешевый'
                 else 'Средний' end            as preferred_hotel_type,
             string_agg(distinct h.name, ', ') as visited_hotels
      from customer c
               join booking b on c.id_customer = b.id_customer
               join room r on r.id_room = b.id_room
               join c_hotel h on h.id_hotel = r.id_hotel
      group by c.id_customer) с
order by array_position(array ['Дешевый', 'Средний', 'Дорогой'], preferred_hotel_type);
