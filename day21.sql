-- For every order-item record, display:

-- ProductID
-- SellingPrice
-- Average selling price of that product


select 
ProductID,
SellingPrice,
avg(SellingPrice) over(partition by ProductID)
from `e1.order_items`;

-- Display every order-item record and assign a row number based on Total, from highest to lowest.


select 
  ProductID,
  Total,
  row_number() over(order by total desc) as totalrank
from `e1.order_items`;

-- For every product, assign a row number to its order-item records based on sales from highest to lowest.


select
ProductID,
Total,
row_number() over(partition by ProductID order by Total desc) as ranking
from `e1.order_items`;


-- CTE
-- common Table Expression

select
ProductID,
total,
rank() over(order by Total desc) from(
select
ProductID,
sum(Total) as total
from `e1.order_items`
group by ProductID

)


-- For every customer, show the number of orders they have placed, including customers with zero orders.



select
  c.CustomerID,
  c.Name,
  count(distinct o.OrderID) as totalorders
from `e1.customers` as c
left join `e1.orders` as o
on c.CustomerID = o.CustomerID
group by c.Name,
c.CustomerID
order by totalorders 


-- Show every order with:

-- Customer name
-- Product name
-- Category
-- Quantity
-- Selling price
-- Total

select 
  c.CustomerID,
  c.Name,
  p.ProductID,
  p.ProductName,
  p.CategoryID,
  oi.SellingPrice,
  sum(oi.Quantity) as total_Quantity,
  sum(oi.Total) as total
from `e1.orders` as o

inner join `e1.customers` as c
  on c.CustomerID = o.CustomerID

inner join `e1.order_items` as oi
  on o.OrderID = oi.OrderID

inner join `e1.products` as p
  on p.ProductID = oi.ProductID

group by 
  c.CustomerID,
  c.Name,
  p.ProductID,
  p.ProductName,
  p.CategoryID,
  oi.SellingPrice



-- Sales by Category and Supplier



select 
  c.CategoryName,
  s.SupplierName,
  sum(oi.total) as total_Sales

from `e1.order_items` as oi
inner join `e1.products` as p
on p.ProductID = oi.ProductID

inner join `e1.categories` as c
on c.CategoryID = p.CategoryID

inner join `e1.suppliers` as s
on s.SupplierID = p.SupplierID

group by
  c.CategoryName,
  s.SupplierName



-- How many different products has each customer purchased?


