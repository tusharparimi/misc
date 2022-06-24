/* -------------------------------------------------------------------------------------- 
  max number with COUNT()=1 
   -------------------------------------------------------------------------------------- */
/*SELECT MAX(num) AS num
FROM
(SELECT num 
FROM MyNumbers
GROUP BY num
HAVING COUNT(num)=1
) x
;
*/

SELECT IFNULL(
(SELECT num 
FROM MyNumbers
GROUP BY num
HAVING COUNT(num)=1
 ORDER BY num DESC
 LIMIT 1
),NULL) AS num;



/* -------------------------------------------------------------------------------------- 
   acceptance rate of requests when requests in one table and accepted requested in another
   -------------------------------------------------------------------------------------- */
SELECT 
ROUND(
    IFNULL(
(SELECT COUNT(*) FROM (SELECT DISTINCT requester_id, accepter_id FROM RequestAccepted) AS a)/
(SELECT COUNT(*) FROM (SELECT DISTINCT sender_id, send_to_id FROM FriendRequest) AS r),0
    )
    ,2) AS accept_rate;



/* -------------------------------------------------------------------------------------- 
  player activities and their first ever device used based on event_date
   -------------------------------------------------------------------------------------- */
SELECT a.player_id,a.device_id
FROM Activity a INNER JOIN
(SELECT player_id,MIN(event_date) AS event_date
FROM Activity 
GROUP BY  player_id) b
ON a.player_id=b.player_id AND a.event_date=b.event_date;



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

/* -------------------------------------------------------------------------------------- 
   gain or loss calculation based on  all operations done on stocks
   -------------------------------------------------------------------------------------- */


SELECT stock_name,
SUM(
CASE 
    WHEN operation='Buy' THEN -1*price
    ELSE price
    END
) AS capital_gain_loss
FROM Stocks
GROUP BY 1
;


/* -------------------------------------------------------------------------------------- 
   joining tables and aggregation based on column value
   -------------------------------------------------------------------------------------- */


/*
SELECT u.user_id AS buyer_id,u.join_date,COUNT(o.order_id) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON u.user_id=o.buyer_id
WHERE o.order_date LIKE '2019%'
GROUP BY u.user_id
UNION ALL
SELECT user_id,join_date,0
FROM Users
WHERE user_id NOT IN 
(SELECT u.user_id 
 FROM Users u
LEFT JOIN Orders o ON u.user_id=o.buyer_id
WHERE o.order_date LIKE '2019%')
;
*/

SELECT u.user_id AS buyer_id,u.join_date,SUM(
CASE 
    WHEN o.order_date LIKE "2019%" THEN 1
    ELSE 0
    END
) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON u.user_id=o.buyer_id
GROUP BY u.user_id
;

/* -------------------------------------------------------------------------------------- 
   jswap consequtive row id
   -------------------------------------------------------------------------------------- */


SELECT
(CASE
WHEN id%2=0 THEN id-1
WHEN id%2!=0 AND id=(SELECT MAX(id) FROM Seat) THEN id
ELSE id+1
END) AS id,student
FROM Seat

ORDER BY id
;

/*--------------------------------------------------------------------------------------
consequtive free seats
---------------------------------------------------------------------------------------*/

SELECT DISTINCT c1.seat_id
FROM Cinema c1 JOIN Cinema c2
ON ABS(c1.seat_id-c2.seat_id)=1
AND c1.free=1 AND c2.free=1
ORDER BY c1.seat_id;
