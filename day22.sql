-- The CRM team wants to understand the sequence in which customers placed their orders.

-- For every order, display:

-- CustomerID
-- OrderID
-- OrderDate
-- The order number for that customer

-- For example:

-- Customer C001
-- First order + 1
-- Second order + 2
-- Third order + 3

-- The numbering should be based on OrderDate, from oldest to newest.

select
  c.CustomerID,
  o.OrderID,
  o.OrderDate,
  row_number() over(partition by o.CustomerID  order by o.OrderDate asc) as ordernumber
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID



-- Find the total amount successfully paid by each customer.

-- Display:

-- CustomerID
-- Customer name
-- Number of successful payments
-- Total successful payment amount

-- Show only customers whose successful payment amount is greater than ₹50,000.



select
  c.CustomerID,
  c.Name,
  count(distinct p.PaymentID) as totalPayments,
  sum(p.Amount) as total_amt
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.payments` as p
on o.OrderID = p.OrderID
where p.Status ="Success"
group by
  c.CustomerID,
  c.Name
having total_amt > 50000;

-- For each category, calculate:

-- Category name
-- Number of products
-- Average MRP
-- Average selling price
-- Average discount amount

-- Consider:

-- Discount = MRP - SellingPrice

-- Display categories with at least 5 products,


select
  c.CategoryName,
  count(distinct p.ProductID) as total_prod,
  avg(p.MRP) as avg_Mrp,
  avg(p.SellingPrice) as avg_sellingp,
  avg(p.MRP) - avg(p.SellingPrice) as avg_disc
from `e1.categories` as c
inner join `e1.products` as p
on c.CategoryID = p.CategoryID
group by
  c.CategoryName
having total_prod >= 5


-- For every supplier, calculate:

-- Supplier name
-- Number of products supplied
-- Number of order-item records
-- Total quantity sold
-- Total sales value

-- Include suppliers even if they currently have no sales.

-- Sort by total sales from highest to lowest.



select
  s.SupplierName,
  count(distinct p.ProductID) as total_prod,
  count(distinct oi.OrderItemID) as totalorderrec,
  sum(oi.Quantity) as total_quant,
  sum(oi.Total) as total_amt
from `e1.suppliers` as s
left join `e1.products` as p
on s.SupplierID = p.SupplierID
left join `e1.order_items` as oi
on p.ProductID = oi.ProductID
group by 
  s.SupplierName
order by 
   total_amt desc
-- For every warehouse, calculate:

-- Warehouse name
-- Number of orders handled
-- Total inventory stock
-- Average inventory stock

-- Include warehouses even if they have no orders.

select 
  w.Warehouse,
  count(distinct o.OrderID) as number_of_orders,
  sum(i.Stock) as total_Stock,
  avg(i.stock) as avg_stock
from `e1.warehouse` as w
left join `e1.inventory` as i
on w.WarehouseID = i.WarehouseID
left join `e1.orders` as o
on o.WarehouseID = w.WarehouseID
group by 
 w.Warehouse;


-- Find the category whose products have the highest average selling price.

-- Display:

-- CategoryID
-- CategoryName
-- Average selling price


select 
  c.CategoryID as categoryid,
  c.CategoryName,
  avg(p.SellingPrice) as avg_selleing_price
from `e1.categories` as c
inner join `e1.products` as p
on c.CategoryID = p.CategoryID
group by
  CategoryID,
  CategoryName
limit 1;


-- For every supplier, rank their products according to selling price, from highest to lowest.

-- Display:

-- Supplier name
-- Product name
-- Selling price
-- Rank within supplier


select 
  s.SupplierName,
  p.ProductName,
  p.SellingPrice,
  rank() over(partition by p.SupplierID order by p.SellingPrice desc) as ranking
from `e1.suppliers` as s
inner join `e1.products` as p
on s.SupplierID = p.SupplierID;


-- show the details of the customers who have joined in the recent 1000 days

select current_date() as today

select * 
from `e1.customers` 
where SignupDate >= date_sub(current_date(), INTERVAL 1000 day)




-- How many orders were placed in each year?
select 
order_year,
count(order_day)
from (
select 
OrderID,
OrderDate,
extract(year FROM OrderDate ) as order_year,
extract(month FROM OrderDate ) as order_month,
extract(day FROM OrderDate ) as order_day

from `e1.orders`
)
group by 
order_year



-- total orders of a month

select
extract(month from orderDate) as month,
count(*) as total_iorders

from `e1.orders`
group by month

select 
OrderDate,
date_trunc(OrderDate, MONTH)
from `e1.orders`

-- What were the total sales for each month?

select 
date_trunc(orderdate,month) as month,
sum(oi.total) as total_sales
from `e1.orders` as o
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
group by month


-- How many days has each customer been registered?

select 
Name,
date_diff(current_date(), SignupDate, day)
from `e1.customers`
