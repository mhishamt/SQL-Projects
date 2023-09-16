-- Retrieve all sales data with the corresponding customer names, product names, and region information:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate,  p.ProductName, r.Suburb, r.City, r.Postcode
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
JOIN region r ON s.DeliveryRegionIndex = r.Index
JOIN products p ON s.ProductDescriptionIndex = p.Index;

-- Retrieve sales data for a specific customer name:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate, c.CustomerNames, p.ProductName
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
JOIN products p ON s.ProductDescriptionIndex = p.Index
WHERE c.CustomerNames = 'Apollo Ltd';

-- Retrieve sales data for a specific product name:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate, c.CustomerNames, p.ProductName
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
JOIN products p ON s.ProductDescriptionIndex = p.Index
WHERE p.ProductName = 'Product 10';

-- Retrieve sales data for a specific region:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate, c.CustomerNames, p.ProductName,r.City
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
JOIN products p ON s.ProductDescriptionIndex = p.Index
JOIN region r ON s.DeliveryRegionIndex = r.Index
WHERE r.City = 'Hamilton';

-- Retrieve the total revenue for each customer:
SELECT c.CustomerNames, SUM(s.TotalRevenue) AS TotalRevenue
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
GROUP BY c.CustomerNames;

-- Retrieve the top 5 customers with the highest total revenue:
SELECT c.CustomerNames, SUM(s.TotalRevenue) AS TotalRevenue
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
GROUP BY c.CustomerNames
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Retrieve the count of sales made in each city:
SELECT r.City, COUNT(*) AS SalesCount
FROM sales s
JOIN region r ON s.DeliveryRegionIndex = r.Index
GROUP BY r.City
ORDER BY SalesCount DESC;

-- Retrieve the average unit price for each product:
SELECT p.ProductName, AVG(s.UnitPrice) AS AverageUnitPrice
FROM sales s
JOIN products p ON s.ProductDescriptionIndex = p.Index
GROUP BY p.ProductName
ORDER BY AverageUnitPrice DESC;

-- Retrieve the sales data for a specific order number:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate, c.CustomerNames, p.ProductName
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
JOIN products p ON s.ProductDescriptionIndex = p.Index
WHERE s.OrderNumber = 'SO - 000225';

-- Retrieve the total revenue and total unit cost for each product:
SELECT p.ProductName, SUM(s.TotalRevenue) AS TotalRevenue, SUM(s.TotalUnitCost) AS TotalUnitCost
FROM sales s
JOIN products p ON s.ProductDescriptionIndex = p.Index
GROUP BY p.ProductName;

-- Retrieve the top 5 best-selling products by total quantity sold:
SELECT p.ProductName, SUM(s.OrderQuantity) AS TotalQuantity
FROM sales s
JOIN products p ON s.ProductDescriptionIndex = p.Index
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 5;

-- Retrieve the average revenue per order for each customer:
SELECT c.CustomerNames, AVG(s.TotalRevenue) AS AverageRevenuePerOrder
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
GROUP BY c.CustomerNames
ORDER BY AverageRevenuePerOrder DESC;

-- Retrieve the orders that were shipped late:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate, c.CustomerNames
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
WHERE s.ShipDate > s.OrderDate;

-- Retrieve the orders that had a negative profit margin:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate, c.CustomerNames
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
WHERE s.TotalRevenue - s.TotalUnitCost < 0;

-- Retrieve the top 5 customers with the highest average revenue per order, along with their total revenue:
SELECT c.CustomerNames, AVG(s.TotalRevenue) AS AverageRevenuePerOrder, SUM(s.TotalRevenue) AS TotalRevenue
FROM sales s
JOIN customers c ON s.CustomerNameIndex = c.CustomerIndex
GROUP BY c.CustomerNames
ORDER BY AverageRevenuePerOrder DESC
LIMIT 5;

-- Retrieve the products that have been ordered by all customers:
SELECT p.ProductName
FROM products p
WHERE NOT EXISTS (
  SELECT DISTINCT c.CustomerIndex
  FROM customers c
  WHERE NOT EXISTS (
    SELECT s.ProductDescriptionIndex
    FROM sales s
    WHERE s.ProductDescriptionIndex = p.Index AND s.CustomerNameIndex = c.CustomerIndex
  )
);

-- Retrieve the customer who has placed the most orders:
SELECT c.CustomerNames, COUNT(s.OrderNumber) AS OrderCount
FROM customers c
JOIN sales s ON c.CustomerIndex = s.CustomerNameIndex
GROUP BY c.CustomerNames
ORDER BY OrderCount DESC
LIMIT 1;

-- Retrieve the orders that have a higher total revenue than the average total revenue of all orders:
SELECT s.OrderNumber, s.OrderDate, s.ShipDate, s.TotalRevenue
FROM sales s
WHERE s.TotalRevenue > (
  SELECT AVG(TotalRevenue)
  FROM sales
);

-- Retrieve the top 3 suburbs with the highest total revenue, along with their respective cities:
SELECT r.Suburb, r.City, SUM(s.TotalRevenue) AS TotalRevenue
FROM sales s
JOIN region r ON s.DeliveryRegionIndex = r.Index
GROUP BY r.Suburb, r.City
ORDER BY TotalRevenue DESC
LIMIT 3;












