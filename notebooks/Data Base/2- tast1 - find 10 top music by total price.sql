SELECT ie.TrackId, tr.name,
 SUM(ie.UnitPrice * ie.Quantity) AS Total_prise_per_track,
 SUM(ie.Quantity) as total_quantity
FROM invoiceline ie
JOIN track tr ON ie.TrackId = tr.TrackId
GROUP BY tr.TrackId, tr.name
ORDER BY Total_prise_per_track DESC
LIMIT 20;
