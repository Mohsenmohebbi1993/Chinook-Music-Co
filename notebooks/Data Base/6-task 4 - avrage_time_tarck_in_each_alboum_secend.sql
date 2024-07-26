select distinct tr.AlbumId,
	al.Title,
	avg(tr.Milliseconds/1000) over (partition by tr.AlbumId) as avrage_time_tarck_in_each_alboum_secend
	from track tr
join album al on tr.AlbumId = al.AlbumId
order by avrage_time_tarck_in_each_alboum_secend desc
