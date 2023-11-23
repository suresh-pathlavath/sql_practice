with cte as (SELECT a.cid as cid, a.fid as fid, a.origin as origin, a.destination as destination, 
b.cid as b_cid, b.fid as b_fid, b.origin as b_origin, b.destination as b_destination

 FROM tiger_analytics_flights as a 
inner JOIN tiger_analytics_flights as b on a.destination = b.origin and a.cid = b.cid)
SELECT origin, b_destination as destination
 from cte where destination is not null
;
SELECT * FROM tiger_analytics_flights;
SELECT * FROM tiger_analytics_flights;

-- https://www.youtube.com/watch?v=eMQDHHfUJtU&ab_channel=AnkitBansal