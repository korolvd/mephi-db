select c.id_customer                                       as "ID_customer",
       c.name,
       count(b.id_booking)                                 as total_bookings,
       sum(r.price * (b.check_out_date - b.check_in_date)) as total_spent,
       count(distinct h.name)                              as unique_hotels
from customer c
         join booking b on c.id_customer = b.id_customer
         join room r on b.id_room = r.id_room
         join hotel h on r.id_hotel = h.id_hotel
group by c.id_customer
having count(distinct h.id_hotel) > 1 and count(b.id_booking) > 2
order by total_spent;
