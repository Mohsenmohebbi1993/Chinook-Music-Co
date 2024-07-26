with invoce_with_customerid as
	(select ie.InvoiceId, ie.TrackId,ie.UnitPrice, ie.Quantity,
		ic.CustomerId,
		cu.SupportRepId
		from invoiceline ie
	join invoice ic on ic.InvoiceId = ie.InvoiceId
	join customer cu on cu.CustomerId= ic.CustomerId),
employee_quantity as
(select ii.quantity,
	em.EmployeeId, em.LastName, em.FirstName
	from invoce_with_customerid ii
join employee em on ii.SupportRepId = em.EmployeeId)

select FirstName, LastName, sum(quantity) as total_quantity from employee_quantity
group by FirstName, LastName
order by total_quantity DESC