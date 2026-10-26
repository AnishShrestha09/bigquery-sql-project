-- find all the products whose mrp is greater than the average mrp

select * 
from `e1.products`
where MRP >(
select avg(MRP)
from `e1.products`);



--  filter out those products whose mrp is among the top 5 distinct highest mrps

select *
from `e1.products`
order by MRP desc
limit 5;



-- second way(4 products only)
select *
from `e1.products`
where (MRP =4937) or (MRP =4927) or (MRP =4880) or (MRP =4698);


-- third way
select *
from `e1.products`
where MRP in (4937,4927,4880,4698);


select *
from `e1.products`
where MRP in (

select distinct(MRP)
from `e1.products`
order by MRP desc
limit 5

);



-- find the minimum from the top 5 products itself

select *
from(
  select *
from `e1.products`
order by MRP desc
limit 5
)
order by MRP asc
limit 1;

-- Find the product or products having the highest MRP.


select *
from `e1.products`
where MRP =(
select max(MRP)
from `e1.products`
);

-- Find products supplied by suppliers who supply at least 5 products.

select *
from `e1.products`
where SupplierID in (
select SupplierID
from `e1.products`
group by SupplierID
having count(*) >= 5
);


-- Find customer IDs who have placed atleast 3 orders.
select
 customerID,
 count(*)
from `e1.orders`
group by CustomerID
having count(*) >3;


-- Display details of those customers who have placed atleast 3 orders
select *
from `e1.customers`
where CustomerID in(


select
 customerID

from `e1.orders`
group by CustomerID
having count(*) >3
);


-- Find suppliers whose number of products is
-- greater than the average number of products supplied per supplier.


select SupplierID ,
count(SupplierID) as total_supplied
from `e1.products`
group by SupplierID
having total_supplied >=(
  select 
  avg(supplied) from(
  select SupplierID, count(SupplierID) as supplied
  from `e1.products`
  group by SupplierID
  )
)






