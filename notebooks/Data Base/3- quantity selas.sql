with track_quntity as(
select TrackId, Quantity, sum(Quantity) as sum_quantity from invoiceline
group by TrackId, Quantity)
select distinct sum_quantity from track_quntity;	