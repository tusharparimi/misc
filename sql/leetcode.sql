-- Second highest salary query
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)

-- Delete duplicate emails
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
    p1.Email = p2.Email AND p1.Id > p2.Id;
 -- alternate
  DELETE FROM Person WHERE Id NOT IN 
(SELECT * FROM(
    SELECT MIN(Id) FROM Person GROUP BY Email) as p);

-- Employee salary greater than manager (self join)
SELECT e1.name AS Employee 
FROM Employee e1 
INNER JOIN Employee e2 ON e1.managerid=e2.id
WHERE e1.salary>e2.salary;

-- DATEDIFF
SELECT w1.id FROM Weather w1, Weather w2 
WHERE DATEDIFF( w1.recordDate, w2.recordDate)=1 AND w1.temperature>w2.temperature;
    
 
 
