-- task 1 top 10 music taht more selase
SELECT ie.TrackId, tr.name,
 SUM(ie.UnitPrice * ie.Quantity) AS Total_prise_per_track,
 SUM(ie.Quantity) as total_quantity
FROM invoiceline ie
JOIN track tr ON ie.TrackId = tr.TrackId
GROUP BY tr.TrackId, tr.name
ORDER BY Total_prise_per_track DESC
LIMIT 20;
-- ****************
-- task 2 find first genre by most tack selas and total price
with genre_wuantiyi_price as(
select ie.TrackId, ie.UnitPrice, ie.Quantity,
tr.GenreId,
gr.name as Genre_name
from invoiceline ie
join track tr on ie.TrackId = tr.TrackId
join genre gr on gr.GenreId = tr.GenreId)

select Genre_name,
 sum(UnitPrice* Quantity) as total_price,
 sum(Quantity) as total_quantity
from genre_wuantiyi_price
group by Genre_name
limit 1
-- *******************
-- task 3: Which customer has not made a purchase yet?
with Who_not_bought as(
select cu.CustomerId, cu.FirstName, cu.LastName, count(iv.InvoiceId) as count_order  from customer cu
right join invoice iv on cu.CustomerId = iv.CustomerId
group by cu.CustomerId, cu.FirstName, cu.LastName)
select * from Who_not_bought
-- total_customer_order 
select count(distinct CustomerId) as total_customer_order from customer
-- total_customer_order
select count(distinct CustomerId) as total_customer_order from invoice
-- ********************
-- task 4: Average time of each song in each album
select distinct tr.AlbumId,
	al.Title,
	avg(tr.Milliseconds/(1000*60)) over (partition by tr.AlbumId) as avrage_time_tarck_in_each_alboum_secend
	from track tr
join album al on tr.AlbumId = al.AlbumId
order by avrage_time_tarck_in_each_alboum_secend desc
-- **********************
-- task 5 Which employee had the most sales?
with invoce_with_customerid as
	(select ie.InvoiceId, ie.TrackId, ie.UnitPrice, ie.Quantity,
		ic.CustomerId,
		cu.SupportRepId,
        em.EmployeeId, em.LastName, em.FirstName
		from invoiceline ie
	join invoice ic on ic.InvoiceId = ie.InvoiceId
	join customer cu on cu.CustomerId= ic.CustomerId
    join employee em on cu.SupportRepId = em.EmployeeId)

select EmployeeId, FirstName, LastName,
sum(quantity) as total_quantity,
sum(UnitPrice * Quantity) as total_price
from invoce_with_customerid
group by EmployeeId, FirstName, LastName
order by total_quantity desc


