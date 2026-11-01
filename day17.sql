-- For every order, calculate the total order value by adding the Total column from order_items.

-- Then classify each order as:

-- High Value + Total order value > ₹50,000
-- Medium Value - Total order value between ₹20,000 and ₹49,999
-- Low Value - Total order value < ₹20,000

-- Display:

-- OrderID
-- OrderDate
-- CustomerName
-- TotalOrderValue
-- OrderCategory



select
  o.OrderID,
  o.OrderDate,
  c.Name,
sum(oi.Total) as totalamount,
case
  when sum(oi.Total) >50000 then "high_value"
  when sum(oi.Total) >20000 then "medium_value"
  when sum(oi.Total) < 20000 then "low_value"
end as amountcateg
from `e1.orders` as o
inner join `e1.customers` as c
on o.CustomerID = c.CustomerID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
group by
  o.OrderID,
  o.OrderDate,
  c.Name
order by totalamount desc;




-- categorise customers as
-- 18-20: genz,
-- 21-40 : adult,
-- 41 onwards : senior_citizen


select
Name,
case
when Age <=20 and Age >= 18 then "Genz"
when Age <=40 and Age >= 21 then "Adult"
when Age > 40 then "Seniorc"
end as customertype
from `e1.customers`;

-- Create a category-level sales report containing:

-- CategoryID
-- CategoryName
-- Number of products in the category
-- Number of different products sold
-- Total quantity sold
-- Total sales value
-- Average selling price

-- Only consider order-item records where:

-- SellingPrice > ₹10,000

-- Display only categories where:

-- Total sales value > ₹5,00,000

select
  c.CategoryID,
  c.CategoryName,
  count( p.ProductID) as totalprod,
  sum(oi.Quantity) as totalqsold,
  sum(oi.Total) as totalsoldamt,
  avg(oi.SellingPrice) as avg_sell_price
from `e1.categories` as c
inner join `e1.products` as p
on c.CategoryID = p.CategoryID
inner join `e1.order_items` as oi
on p.ProductID = oi.ProductID
where oi.SellingPrice > 1000
group by
  c.CategoryID,
  c.CategoryName 
having totalsoldamt > 50000
order by totalqsold;


-- Find products where:

-- MRP is greater than ₹15,000
-- Discount percentage is greater than 20%
-- Total sales value is greater than ₹75,000

-- Display:

-- ProductID
-- ProductName
-- CategoryName
-- MRP
-- SellingPrice
-- Discount percentage
-- Total sales

-- Sort by discount percentage from highest to lowest.

select
p.ProductID,
p.ProductName,
c.CategoryName,
p.MRP,
p.SellingPrice,
p.MRP - p.SellingPrice as discount,
((p.MRP - p.SellingPrice )/p.MRP * 100) as dis_perc,
sum(oi.Total) as totalsale
from `e1.products` as p
inner join `e1.order_items` as oi
on p.ProductID = oi.ProductID
inner join `e1.categories` as c
on p.CategoryID = c.CategoryID
where p.MRP >15000
group by
p.ProductID,
p.ProductName,
c.CategoryName,
p.MRP,
p.SellingPrice
having 
dis_perc > 20 and
totalsale> 75000
order by dis_perc desc



-- For every employee, calculate:

-- EmployeeID
-- Employee name
-- Department
-- Number of orders handled
-- Number of orders whose total value exceeds ₹50,000
-- Total sales value of all orders handled

-- Display only employees who have handled at least 5 orders.

-- Sort employees by total sales value from highest to lowest.





