-- Second highest salary query
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)

-- Delete duplicate emails
DELETE FROM Person
WHERE id IN
(SELECT id FROM
(SELECT id,rownum FROM 
(SELECT id,email,ROW_NUMBER() OVER(PARTITION BY email ORDER BY id) rownum FROM Person) x
WHERE rownum!=1) 
 y) 
 ;
