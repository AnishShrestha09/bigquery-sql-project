-- Find products whose MRP is greater than the average MRP of all
-- products.

-- Display:

-- ProductID -- > product
-- ProductName -- > product
-- CategoryName -- > category
-- MRP -- > product
-- Sort from highest MRP to lowest.



select
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.MRP
from `e1.products` as p
inner join `e1.categories` as c
on p.CategoryID = c.CategoryID
where p.mrp > (select 
                avg(MRP) 
                from `e1.products`)
order by p.MRP desc;




-- For each warehouse, calculate total stock and classify the

-- warehouse as:
-- High Stock - total stock >= 5,000
-- Medium Stock - total stock >= 2,500
-- Low Stock - total stock < 2,500

-- Display:

-- Warehouse ID
-- Warehouse name
-- Average stock -
-- Stock classific
-- Total stock

select 
    w.Warehouse,
    w.WarehouseID,
    avg(i.Stock) as avg_stock,
    case 
        when sum(i.stock) >= 5000 then "High Stock"
        when  sum(i.stock) >= 2500 then "Medium Stock"
        else "Low stock"
    end as stock_classification,
    sum(i.stock) as total_stock
from `e1.warehouse` as w
inner join `e1.inventory` as i
on w.WarehouseID = i.WarehouseID
group by 
    w.Warehouse,
    w.WarehouseID;

-- select * from `e1.warehouse`
-- select * from `e1.inventory`



-- Find customers who have placed orders on more than 2 different order dates.
-- Display:

-- CustomerID -
-- CustomerName
-- Number of differeent order dated
-- Total number of orders
-- Total quantity purchased





select 
    c.CustomerID,
    c.Name,   count(distinct o.OrderDate) as diff_dates,
    count(distinct o.OrderID) as total_orders,
    sum(oi.Quantity) as total_Quanity
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
where c.CustomerID in
            (
            select 
                c.CustomerID          
            from `e1.customers` as c
            inner join `e1.orders` as o
            on c.CustomerID = o.CustomerID
            group by
                c.CustomerID,
                c.Name
            having count(distinct o.OrderDate) > 2
            )
group by
    c.CustomerID,
    c.Name

-- For each category, find the product having the highest MRP.
-- Display:

-- CategoryName
-- ProductID -
-- ProductName
-- MRP 

--wrong
select 
    p.ProductID,
    p.CategoryID,
max(p.MRP) as highest_mrp
from `e1.products` as p
inner join `e1.categories` as c
on p.CategoryID = c.CategoryID
where(

)
group by 
    p.ProductID,
    p.CategoryID



-- Show every order-item record, but also show the total sales of that product beside every row.

-- Show every order-item record, but also show the total sales of that product beside every row.
select
  ProductID,
  OrderID,
  Total,
  sum(total) over(partition by ProductID) as product_total_sales
from `e1.order_items`;


select * from  `e1.order_items`

-- function() over(partition by column order by column)

-- For every order-item record, display:

-- ProductID
-- SellingPrice
-- Average selling price of that product

select 
  oi.ProductID,
  oi.SellingPrice,
  avg(oi.SellingPrice) over(partition by oi.ProductID) as avg_product_selling_price
from `e1.order_items` as oi

-- For every order-item record, show:

-- ProductID
-- OrderID
-- Number of order-item records for that product



select 
ProductID,
OrderID,
count(ProductID) over(partition by ProductID) as no_of_products
from `e1.order_items`;

-- For every order-item record, display:

-- OrderID
-- ProductID
-- Total
-- Total sales across the entire order_items table


select
OrderID,
ProductID,
Total,
sum(total) over() as total_overall_sales
from `e1.order_items`;

-- Display every order-item record and assign a row number based on Total, from highest to lowest.


select
OrderID,
ProductID,
Total,
row_number() over(order by Total desc) as row_number
from `e1.order_items` ;
-- Show every order-item record, but also show the total sales of that product beside every row.
select
  ProductID,
  OrderID,
  Total,
  sum(total) over(partition by ProductID) as product_total_sales
from `e1.order_items`;


select * from  `e1.order_items`

-- function() over(partition by column order by column)

-- For every order-item record, display:

-- ProductID
-- SellingPrice
-- Average selling price of that product

select 
  oi.ProductID,
  oi.SellingPrice,
  avg(oi.SellingPrice) over(partition by oi.ProductID) as avg_product_selling_price
from `e1.order_items` as oi

-- For every order-item record, show:

-- ProductID
-- OrderID
-- Number of order-item records for that product



select 
ProductID,
OrderID,
count(ProductID) over(partition by ProductID) as no_of_products
from `e1.order_items`;

-- For every order-item record, display:

-- OrderID
-- ProductID
-- Total
-- Total sales across the entire order_items table


select
OrderID,
ProductID,
Total,
sum(total) over() as total_overall_sales
from `e1.order_items`;

-- Display every order-item record and assign a row number based on Total, from highest to lowest.


select
OrderID,
ProductID,
Total,
row_number() over(order by Total desc) as row_number
from `e1.order_items` ;
