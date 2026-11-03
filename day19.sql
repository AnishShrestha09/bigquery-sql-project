
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