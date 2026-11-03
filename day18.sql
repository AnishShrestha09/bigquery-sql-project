-- For every category, calculate:

-- CategoryName
-- Number of products
-- Minimum MRP
-- Maximum MRP
-- Difference between maximum and minimum MRP

-- Display only categories where the difference between the maximum and minimum MRP is greater than ₹10,000.


select 
  c.CategoryName,
  count(distinct p.ProductID) as no_of_prod,
  min(p.MRP) as min_mrp,
  max(p.mrp) as max_mrp,
  ( max(p.mrp)-min(p.MRP)) as difference
from `e1.categories` as c
inner join `e1.products` as p
on p.CategoryID = c.CategoryID
group by  c.CategoryName
having difference > 10000;

-- For each payment method, calculate:

-- Number of successful transactions
-- Total successful payment amount
-- Average successful transaction amount
-- Maximum successful transaction amount

-- Display only payment methods having more than 10 successful transactions.

-- Sort by average transaction amount from highest to lowest.

select 
p.method,
count(*) as successfull_payments,
sum(p.amount) as total_amt,
avg(p.amount) as avg_amount,
max(p.amount) as max_amount
from (
  select 
  Method,
  Amount,
  Status
  from `e1.payments`
  where Status = "Success"
) as p
group by p.method
having successfull_payments >10
order by avg_amount desc

-- Find the top 15 products based on total quantity sold

-- Display:

-- ProductID
-- ProductName
-- CategoryName
-- Total quantity sold
-- Total sales value

-- Sort by quantity sold from highest to lowest.



select 
  p.ProductID,
  p.ProductName,
  c.CategoryName,
sum(oi.Quantity) as total_quantity,
sum(oi.Total) as total_sales
from `e1.products` as p
inner join `e1.categories` as c
on c.CategoryID = p.CategoryID
inner join `e1.order_items` as oi
on oi.ProductID = p.ProductID
group by 
   p.ProductID,
  p.ProductName,
  c.CategoryName
order by total_quantity desc
limit 15


-- For every warehouse, calculate:

-- WarehouseID
-- Warehouse name
-- Number of inventory records
-- Total stock
-- Average stock
-- Highest stock in a single inventory record

-- Display only warehouses where the average stock per inventory record is greater than 100.

-- Sort by total stock descending.
