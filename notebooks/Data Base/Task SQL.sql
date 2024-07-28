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
