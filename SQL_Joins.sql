/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT p.Name, c.Name
FROM products AS p
INNER JOIN categories AS c
ON p.CategoryID = c.CategoryID
WHERE p.CategoryID = 1;

/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT p.Name, p.Price, r.Rating
FROM products AS p
INNER JOIN reviews AS r
ON p.ProductID = r.ProductID
WHERE r.Rating = 5;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT CONCAT(e.FirstName, " ", e.LastName) AS Name, SUM(s.Quantity) AS TotalQuantity
FROM employees AS e
INNER JOIN sales AS s
ON e.EmployeeID = s.EmployeeID
Group BY s.EmployeeID
Having TotalQuantity = (SELECT SUM(sales.Quantity) AS Total
						FROM sales
                        GROUP BY sales.EmployeeID
                        ORDER BY Total DESC
                        LIMIT 1);

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT c.Name AS Category, d.Name AS Department
FROM categories AS c
INNER JOIN departments AS d
ON c.DepartmentID = d.DepartmentID
WHERE c.Name = "Appliances" OR c.Name = "GAMES";

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
SELECT p.Name, SUM(s.Quantity) AS Quantity, SUM(s.Quantity * s.PricePerUnit) AS Total
FROM products AS p
INNER JOIN sales AS s
ON p.ProductID = s.ProductID
WHERE p.Name = "Eagles: Hotel California";

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT p.Name, r.Reviewer, r.Rating, r.Comment
FROM reviews AS r
INNER JOIN products AS p
ON r.ProductID = p.ProductID
WHERE r.Rating = 1 AND p.Name = "Visio TV";

-- ------------------------------------------ Extra - May be difficult

/* Your goal is to write a query that serves as an employee sales report.
This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold */
SELECT e.EmployeeID, CONCAT(e.FirstName, " ", e.LastName) AS Name, p.Name AS Product, SUM(s.Quantity)
FROM ((sales AS s
		INNER JOIN employees AS e
        ON s.EmployeeID = e.EmployeeID)
INNER JOIN products AS p
ON s.ProductID = p.ProductID)
GROUP BY Name, Product
ORDER BY Name;