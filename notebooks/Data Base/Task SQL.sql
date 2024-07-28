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
limit 1
-- ***********************
-- task 6: Users who have purchased more than one genre
with Customer_by_gener as
(select ie.Quantity,
	ic.CustomerId,
   concat(cu.FirstName," - ", cu.LastName) as Customer_name,
   tr.GenreId,
   gr.name as gener_name
 from invoiceline ie
 join invoice ic on ic.InvoiceId = ie.InvoiceId
 join customer cu on cu.CustomerId = ic.CustomerId
 join track tr on tr.TrackId = ie.TrackId
 join genre gr on gr.GenreId = tr.GenreId)
 select CustomerId, Customer_name,
 count( distinct GenreId) as count_gener
 from Customer_by_gener

 group by CustomerId, Customer_name
 order by count_gener desc;
 where count_gener > 1;
 
 -- ********************
 -- task 7: Top three grossing songs for each genre
with Track_price_genre as (
select ie.InvoiceId, ie.TrackId, tr.Name as Track_name,
 sum(ie.UnitPrice* ie.Quantity) over(partition by ie.TrackId) as total_price, 
 tr.GenreId,
gr.Name as genre_name
from invoiceline ie
join track tr on tr.TrackId = ie.TrackId
join genre gr on gr.GenreId = tr.GenreId),

distinct_track as(select distinct trackid, Track_name, total_price, GenreId, genre_name
-- row_number() over (partition by GenreId order by total_price) as rank_music_per_genre
 from Track_price_genre),
 
rank_per_genre as(
select trackid, Track_name, total_price, GenreId, genre_name,
row_number() over (partition by GenreId order by total_price desc) as rank_per_genre
from distinct_track)
select * from rank_per_genre
where rank_per_genre <4
-- ************************
-- task 8: Cumulative number of songs sold per year
select Year_selse, total_price, total_quantity,
    SUM(total_price) over (order by Year_selse) as cumulative_price,
    SUM(total_quantity) over (order by Year_selse) as cumulative_quantity
from (select 
	SUBSTRING_INDEX(iv.InvoiceDate, "-", 1) AS Year_selse,
	sum(ie.Quantity * ie.UnitPrice) AS total_price,
	sum(ie.Quantity) as total_quantity
    from invoiceline ie
    join invoice iv on iv.InvoiceId = ie.InvoiceId
    group by Year_selse
) as year_totao_price
order by Year_selse





