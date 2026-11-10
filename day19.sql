
--   Find customers who have purchased products from at least 3 different categories.

-- Display:

-- CustomerID
-- Customer name
-- Number of different categories purchased
-- Total quantity purchased
-- Total amount spent


select
c.CustomerID,
c.Name,
count(distinct p.CategoryID) as no_of_categories,
sum(oi.Quantity) as total_qunatity,
sum(oi.Total) as total_amount
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
inner join `e1.products` as p
on p.ProductID = oi.ProductID
group by 
c.CustomerID,
c.Name
having no_of_categories >= 3;

-- For every warehouse, calculate:

-- WarehouseID
-- Warehouse name
-- Number of inventory records
-- Total stock
-- Average stock
-- Highest stock in a single inventory record

-- Display only warehouses where the average stock per inventory record is greater than 100.

-- Sort by total stock descending.

select 
  w.Warehouse,
  w.WarehouseID,
  count(*) as no_of_inventrec,
  sum(i.Stock) as totalstock,
  avg(i.Stock) as avg_stock,
  max(i.stock) as max_stock
from `e1.warehouse` as w
inner join  `e1.inventory` as i
on w.WarehouseID = i.WarehouseID
group by 
  w.Warehouse,
  w.WarehouseID
having avg_stock > 100
order by totalstock desc

-- Find products that:

-- Exist in the product catalogue
-- Have inventory records
-- Have never appeared in any order item

-- Display:

-- ProductID
-- ProductName
-- SupplierID
-- Number of inventory records
-- Total stock

-- Sort by total stock from highest to lowest.


SELECT
    p.ProductID,
    p.ProductName,
    p.SupplierID,
    COUNT(*) AS no_of_records,
    SUM(i.Stock) AS totalstock
FROM `e1.products` AS p
INNER JOIN `e1.inventory` AS i
    ON p.ProductID = i.ProductID
LEFT JOIN `e1.order_items` AS oi
    ON p.ProductID = oi.ProductID
WHERE oi.ProductID IS NULL
GROUP BY
    p.ProductID,
    p.ProductName,
    p.SupplierID
ORDER BY totalstock DESC;


-- Premium Supplier if average MRP >= ₹30,000
-- Mid-Range Supplier if average MRP >= ₹15,000
-- Budget Supplier otherwise

-- Display the suppliers with the highest average MRP first.


select 
s.SupplierID,
s.SupplierName,
case
    when avg(p.MRP) >= 30000 then "Premium Supplier"
    when avg(p.MRP) >= 15000 then "Mid-Range Supplier"
    else "Budget Supplier"
end as supplier_categ
from `e1.suppliers` as s
inner join `e1.products` as p
on s.SupplierID = p.SupplierID
group by 
s.SupplierID,
s.SupplierName
order by avg(p.MRP) desc;


-- Display:

-- CustomerID
-- Customer name
-- Number of different categories purchased
-- Total quantity purchased
-- Total amount spent

-- Sort by number of different categories purchased from highest to lowest.

select 
    c.CustomerID,
    c.Name,
    count(distinct p.CategoryID) as total_diff_categ,
    sum(oi.Quantity) as total_Quanity,
    sum(oi.Total) as total_amount
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
inner join `e1.products` as p
on p.ProductID = oi.ProductID
group by 
    c.CustomerID,
    c.Name
order by total_diff_categ desc;


-- Find customers who have at least one order associated with a failed payment.

-- Display:

-- CustomerID
-- CustomerName
-- Number of orders having failed payments
-- Total value of those orders

-- Display customers with the highest failed-payment order value first.


select
    c.CustomerID,
    c.Name,
    count(distinct o.OrderID) as total_failed_payments,
    sum(oi.total) as total_failed_amount
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.payments` as p
on o.OrderID = p.OrderID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
where p.Status != "Success"
group by 
    c.CustomerID,
    c.Name
order by total_failed_amount desc;

-- Find employees who have handled at least one order whose total value is greater than <75, 000.

-- Display:

-- EmployeeID
-- EmployeeName
-- Number of high-value orders
-- Total value of high-value orders
-- Average high-value order amount

-- Sort by total high-value sales from highest to lowest.


select 
    e.EmployeeID,
    e.Name,
    count(distinct o.orderid) as totalorders,
    sum(oi.total) as total_value,
    avg(oi.Total) as avg_total
from `e1.orders` as o
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
inner join `e1.employees` as e
on e.EmployeeID =o.EmployeeID
group by 
    e.EmployeeID,
    e.Name
having total_value > 75000
order by total_value desc


