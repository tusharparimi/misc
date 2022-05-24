-- Order COunts grouped by month and category
SELECT SUBSTR(OrderDate,1,7) AS order_month,CategoryName,COUNT(*) AS order_count
FROM Orders o
LEFT JOIN OrderDetails od ON o.OrderID=od.OrderID
LEFT JOIN Products p ON od.ProductID=p.ProductID
LEFT JOIN Categories c ON p.CategoryID=c.CategoryID
GROUP BY 1,2
;



-- Top 10 Suppliers wrt order counts
SELECT SupplierName,COUNT(o.OrderID) AS order_count
FROM Orders o 
LEFT JOIN OrderDetails od ON o.OrderID=od.OrderID
LEFT JOIN Products p ON od.ProductID=p.ProductID
LEFT JOIN Suppliers s on p.SupplierID=s.SupplierID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;
