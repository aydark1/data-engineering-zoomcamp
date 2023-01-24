/*Q3*/
select count(*) from green_tripdata where lpep_pickup_datetime::date = '2019-01-15' 

/*Q4*/
select lpep_pickup_datetime from green_tripdata where trip_distance =
(select max(trip_distance) from green_tripdata) --where lpep_dropoff_datetime::date = '2019-01-15' 

/*Q5*/
select passenger_count, count(*) 
from green_tripdata where lpep_pickup_datetime::date = '2019-01-01' 
group by passenger_count

/*Q6*/
select * from 
(select z2."Zone", tip_amount, max(tip_amount) over() max_tip_amount from green_tripdata t join zones z1 on t."PULocationID" = z1."LocationID"
join zones z2 on t."DOLocationID" = z2."LocationID" 
where z1."Zone" = 'Astoria' ) a where tip_amount = max_tip_amount
