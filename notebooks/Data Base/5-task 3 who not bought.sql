with Who_not_bought as(
select cu.CustomerId, cu.FirstName, cu.LastName, count(iv.InvoiceId) as count_order  from customer cu
right join invoice iv on cu.CustomerId = iv.CustomerId
group by cu.CustomerId, cu.FirstName, cu.LastName)
select * from Who_not_bought



select count(distinct CustomerId) as total_customer_order from customer

select count(distinct CustomerId) as total_customer_order from invoice
س