/* -------------------------------------------------------------------------------------- 
   Second highest salary query
   -------------------------------------------------------------------------------------- */
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)



/* -------------------------------------------------------------------------------------- 
   Delete duplicate emails
   -------------------------------------------------------------------------------------- */

-- Using ROW_NUMBER()
DELETE FROM Person
WHERE id IN
(SELECT id FROM
(SELECT id,rownum FROM 
(SELECT id,email,ROW_NUMBER() OVER(PARTITION BY email ORDER BY id) rownum FROM Person) x
WHERE rownum!=1) 
 y) 
 ;

 -- Using self join
 DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id
;
 -- alternate
  DELETE FROM Person WHERE Id NOT IN 
(SELECT * FROM(
    SELECT MIN(Id) FROM Person GROUP BY Email) as p);



/* -------------------------------------------------------------------------------------- 
   Employee salary greater than manager (self join)
   -------------------------------------------------------------------------------------- */
SELECT e1.name AS Employee 
FROM Employee e1 
INNER JOIN Employee e2 ON e1.managerid=e2.id
WHERE e1.salary>e2.salary;

-- Rising Temperature
SELECT w1.id FROM Weather w1, Weather w2 
WHERE DATEDIFF( w1.recordDate, w2.recordDate)=1 AND w1.temperature>w2.temperature
;
    



/* -------------------------------------------------------------------------------------- 
   customer placing largest order
   -------------------------------------------------------------------------------------- */
/*
SELECT customer_number
FROM 
(SELECT customer_number,COUNT(order_number)
FROM Orders
GROUP BY 1
ORDER BY 2 DESC
) x
LIMIT 1;
*/
SELECT customer_number
FROM Orders
GROUP BY 1
ORDER BY COUNT(order_number) DESC
LIMIT 1
;



/* -------------------------------------------------------------------------------------- 
   Sales person not associated with a particular company
   -------------------------------------------------------------------------------------- */
SELECT DISTINCT s.name 
FROM SalesPerson s
WHERE
s.sales_id NOT IN
(SELECT sales_id 
 FROM Orders
INNER JOIN Company ON Orders.com_id=Company.com_id
WHERE Company.name='RED')
;



/* -------------------------------------------------------------------------------------- 
   product only sold in a date range
   -------------------------------------------------------------------------------------- */
SELECT product_id,product_name 
FROM Product p
WHERE product_id NOT IN
(SELECT p.product_id
 FROM Sales s
 INNER JOIN Product p ON s.product_id=p.product_id
WHERE sale_date>'2019-03-31' OR sale_date<'2019-01-01'
);



/* -------------------------------------------------------------------------------------- 
   updating a table with case
   -------------------------------------------------------------------------------------- */
UPDATE salary
SET 
    sex=
        CASE 
        WHEN sex='m' THEN 'f'
        ELSE 'm'
        END
;

/* -------------------------------------------------------------------------------------- 
   Each distinct value in a column as a new column
   -------------------------------------------------------------------------------------- */


SELECT id,
SUM(CASE WHEN month='Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
SUM(CASE WHEN month='Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
SUM(CASE WHEN month='Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
SUM(CASE WHEN month='Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
SUM(CASE WHEN month='May' THEN revenue ELSE NULL END) AS May_Revenue,
SUM(CASE WHEN month='Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
SUM(CASE WHEN month='Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
SUM(CASE WHEN month='Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
SUM(CASE WHEN month='Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
SUM(CASE WHEN month='Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
SUM(CASE WHEN month='Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
SUM(CASE WHEN month='Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY 1
;

/* -------------------------------------------------------------------------------------- 
   convert columns as rows
   -------------------------------------------------------------------------------------- */


SELECT product_id, 'store1' AS store, store1 AS price FROM Products WHERE store1 IS NOT NULL
UNION ALL
SELECT product_id, 'store2' AS store, store2 AS price FROM Products WHERE store2 IS NOT NULL
UNION ALL
SELECT product_id, 'store3' AS store, store3 AS price FROM Products WHERE store3 IS NOT NULL
