with Genre_with_Track_and_total_price as
(select ie.TrackId,
 tr.GenreId,
 tr.Name as Genre_name,
 ie.Quantity,
 ie.UnitPrice,
 (ie.Quantity * ie.UnitPrice) as Total_price
from invoiceline ie
join track tr on ie.TrackId = tr.TrackId
group by ie.TrackId, tr.GenreId, Genre_name, ie.Quantity, ie.UnitPrice)

SELECT Genre_name,
    SUM(Total_price) AS Total_price_genre,
    count(TrackId) AS Track_count
FROM Genre_with_Track_and_total_price
GROUP BY Genre_name
order by  Track_count DESC , Total_price_genre DESC
