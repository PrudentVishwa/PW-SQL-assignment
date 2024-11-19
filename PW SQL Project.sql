1. Create a table called employees with the following structure?
- emp_id (integer, should not be NULL and should be a primary key)Q
- emp_name (text, should not be NULL)Q
- age (integer, should have a check constraint to ensure the age is at least 18)Q
- email (text, should be unique for each employee)Q
- salary (decimal, with a default value of 30,000).
Write the SQL query to create the above table with all constraints.
USE pw
CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000
);

2- Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.

Constraints enforce rules in a database to maintain data integrity by ensuring accuracy, consistency, and validity of data. They prevent errors and improve data quality.

Common Constraints:
1- PRIMARY KEY: Uniquely identifies each row in a table.
   Example: emp_id in an employees table. Each emp_id must be unique and not null.
2- UNIQUE: Ensures values in a column are unique.
   Example: email in an employees table to ensure no two employees share the same email.
3- NOT NULL: Requires that a column cannot be empty.
   Example: emp_name in an employees table must have a value for each employee.
4- CHECK: Enforces a condition on column values.
   Example: age in an employees table must be at least 18 (CHECK (age >= 18)).
5- DEFAULT: Sets a default value if none is provided.
   Example: salary in an employees table defaults to 30,000 if no value is provided.
6- FOREIGN KEY: Links data between tables, enforcing referential integrity.
   Example: department_id in employees references id in a departments table, ensuring each employee is assigned to a valid department.
   
   
3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer.

The NOT NULL constraint is applied to a column to ensure that every record in that column has a value, preventing null (empty) entries. This is especially useful when the column holds essential information that must be present for data integrity. For example, in an employees table, you might set the emp_name column to NOT NULL to ensure that every employee has a name.

A PRIMARY KEY cannot contain NULL values. This is because a primary key is meant to uniquely identify each record in the table, and NULL represents the absence of a value, which cannot uniquely identify anything. A primary key must always be unique and complete, with no gaps (NULLs), to reliably distinguish each record.

4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.


To add or remove constraints on an existing table, you generally use the ALTER TABLE command in SQL. Below are the steps and SQL commands for both adding and removing constraints.

Adding a Constraint
Use ALTER TABLE: Start by specifying the table you want to alter.
Add the Constraint: Use ADD CONSTRAINT with the specific type of constraint you want to apply (e.g., NOT NULL, UNIQUE, CHECK).
Example: Adding a UNIQUE constraint to the email column in the employees table:
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);
Removing a Constraint
Identify the Constraint Name: Most databases require the name of the constraint to remove it.
Use ALTER TABLE with DROP CONSTRAINT: Specify the table and the constraint name to be dropped.
Example: Removing the unique_email constraint from the email column in the employees table:
ALTER TABLE employees
DROP CONSTRAINT unique_email;


5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
Attempting to insert, update, or delete data in a way that violates constraints can lead to errors that prevent the operation from completing. These errors ensure data integrity by blocking actions that would compromise the rules established in the database.

Consequences of Violating Constraints
1- INSERT Violations: Trying to insert data that breaks a constraint, such as a NULL value in a NOT NULL column, will fail and raise an error.
2- UPDATE Violations: Attempting to update a record with values that violate constraints, like setting a duplicate value in a UNIQUE column, will also fail and throw an error.
3- DELETE Violations: If a row is referenced by a FOREIGN KEY in another table, deleting it will be blocked unless ON DELETE CASCADE is specified.
Examples of Constraint Violations and Error Messages
1- NOT NULL Constraint Violation:
Attempting to insert a NULL value in a NOT NULL column.
INSERT INTO employees (emp_id, emp_name, age) VALUES (1, NULL, 25);
Error Message:
ERROR: Column 'emp_name' cannot be null
2- UNIQUE Constraint Violation:
Inserting or updating a record with a duplicate value in a column that has a UNIQUE constraint.
INSERT INTO employees (emp_id, emp_name, age, email) VALUES (2, 'Alice', 30, 'alice@example.com');
INSERT INTO employees (emp_id, emp_name, age, email) VALUES (3, 'Bob', 28, 'alice@example.com');
Error Message:
ERROR: Duplicate entry 'alice@example.com' for key 'unique_email'
3- CHECK Constraint Violation:
Inserting or updating a value that fails the CHECK constraint.
INSERT INTO employees (emp_id, emp_name, age) VALUES (4, 'Charlie', 16);
Error Message:
ERROR: Check constraint 'age_check' is violated: age >= 18
4- FOREIGN KEY Constraint Violation:
Attempting to insert a record with a FOREIGN KEY value that doesn’t exist in the referenced table.
INSERT INTO orders (order_id, emp_id) VALUES (1, 999); -- 999 does not exist in employees table
Error Message:
ERROR: Cannot add or update a child row: a foreign key constraint fails


6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
Now, you realise that?
- The product_id should be a primary keyQ
- The price should have a default value of 50.00

To add the constraints to the existing products table, you can use the ALTER TABLE command. Here’s how to modify the table:

1- Add a Primary Key Constraint to product_id.
2- Set a Default Value for the price column.
SQL Commands to Alter the Table:
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;


7- Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

SELECT student_name, class_name
FROM students
INNER JOIN classes ON students.class_id = classes.class_id;

8- Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN).

SELECT order_id, customer_name, product_name
FROM orders
LEFT JOIN products ON orders.product_id = products.product_id;

9- Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

SELECT product_name, SUM(price * quantity) AS total_sales
FROM products
INNER JOIN sales ON products.product_id = sales.product_id
GROUP BY product_name;


10- Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.

SELECT order_id, customer_name, quantity
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id;


## SQL Commands

1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences

Primary Keys: These uniquely identify each row within a table, e.g., actor_id in the actor table, address_id in the address table.
Foreign Keys: These link one table to another, ensuring referential integrity. For example, city_id in the address table is a foreign key referencing city_id in the city table.
Differences: Primary keys enforce uniqueness and cannot be NULL, whereas foreign keys can contain duplicate values and NULLs (if allowed) and are used to create relationships between tables.

2- List all details of actors

SELECT * FROM actor;

3 -List all customer information from DB.

SELECT * FROM customer;

4 -List different countries.

SELECT DISTINCT country FROM country;

5 -Display all active customers.

SELECT * FROM customer WHERE active = 1;

6 -List of all rental IDs for customer with ID 1.

SELECT rental_id FROM rental WHERE customer_id = 1;

7 - Display all the films whose rental duration is greater than 5 .

SELECT * FROM film WHERE rental_duration > 5;

8 - List the total number of films whose replacement cost is greater than $15 and less than $20.

SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

9 - Display the count of unique first names of actors.

SELECT COUNT(DISTINCT first_name) FROM actor;

10- Display the first 10 records from the customer table .

SELECT * FROM customer LIMIT 10;

11 - Display the first 3 records from the customer table whose first name starts with ‘b’.

SELECT * FROM customer WHERE first_name LIKE 'B%' LIMIT 3;

12 -Display the names of the first 5 movies which are rated as ‘G’.

SELECT title FROM film WHERE rating = 'G' LIMIT 5;

13-Find all customers whose first name starts with "a".

SELECT * FROM customer WHERE first_name LIKE 'A%';

14- Find all customers whose first name ends with "a".

SELECT * FROM customer WHERE first_name LIKE '%A';

15- Display the list of first 4 cities which start and end with ‘a’ .

SELECT * FROM city WHERE city LIKE 'A%' AND city LIKE '%A' LIMIT 4;

16- Find all customers whose first name have "NI" in any position.

SELECT * FROM customer WHERE first_name LIKE '%NI%';

17- Find all customers whose first name have "r" in the second position .

SELECT * FROM customer WHERE first_name LIKE '_R%';

18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

19- Find all customers whose first name starts with "a" and ends with "o".

SELECT * FROM customer WHERE first_name LIKE 'A%O';

20 - Get the films with pg and pg-13 rating using IN operator.

SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

21 - Get the films with length between 50 to 100 using between operator.

SELECT * FROM film WHERE length BETWEEN 50 AND 100;

22 - Get the top 50 actors using limit operator.

SELECT * FROM actor LIMIT 50;

23 - Get the distinct film ids from inventory table.

SELECT DISTINCT film_id FROM inventory;


## Functions

# Basic Aggregate Functions:

Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.

SELECT COUNT(*) AS total_rentals FROM rental;

Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.

SELECT AVG(rental_duration) AS average_rental_duration FROM film;

String Functions:
Question 3:
Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function.

SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name FROM customer;

Question 4:
Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.

SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

GROUP BY:
Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.

SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id;

Question 6:
Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.

SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

Question 7:
Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use COUNT() and GROUP BY.

SELECT category.name AS category_name, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

Question 8:
Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY.

SELECT language.name AS language_name, AVG(film.rental_rate) AS average_rental_rate
FROM film
JOIN language ON film.language_id = language.language_id
GROUP BY language.name;

Joins
Questions 9 -
Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.

SELECT film.title, customer.first_name, customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id;

Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.

SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Gone with the Wind';

Question 11:
Retrieve the customer names along with the total amount they've spent on rentals'.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS total_spent
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;

Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.

SELECT customer.first_name, customer.last_name, film.title
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
WHERE city.city = 'London'
GROUP BY customer.customer_id, film.title;


Advanced Joins and GROUP BY:
Question 13:
Display the top 5 rented movies along with the number of times they've been rented'.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id
ORDER BY rental_count DESC
LIMIT 5;

Question 14:
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

SELECT customer.customer_id, customer.first_name, customer.last_name
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE inventory.store_id IN (1, 2)
GROUP BY customer.customer_id
HAVING COUNT(DISTINCT inventory.store_id) = 2;


Windows Function:
1. Rank the customers based on the total amount they've spent on rentals'.

SELECT customer_id, first_name, last_name, 
       SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS spending_rank
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.customer_id;

2. Calculate the cumulative revenue generated by each film over time.

SELECT film_id, title, rental_date, 
       SUM(amount) OVER (PARTITION BY film_id ORDER BY rental_date) AS cumulative_revenue
FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id;

3. Determine the average rental duration for each film, considering films with similar lengths.

SELECT film_id, title, length, 
       AVG(rental_duration) OVER (PARTITION BY length) AS avg_rental_duration_for_length
FROM film;

4. Identify the top 3 films in each category based on their rental counts.

SELECT category.name AS category_name, film.title, 
       COUNT(rental.rental_id) AS rental_count,
       RANK() OVER (PARTITION BY category.category_id ORDER BY COUNT(rental.rental_id) DESC) AS rank_in_category
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.category_id, film.film_id
HAVING rank_in_category <= 3;

5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers'.

WITH customer_rental_counts AS (
    SELECT customer_id, 
           COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY customer_id
),
average_rentals AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM customer_rental_counts
)
SELECT customer_rental_counts.customer_id, 
       customer_rental_counts.total_rentals,
       (customer_rental_counts.total_rentals - average_rentals.avg_rentals) AS rental_difference
FROM customer_rental_counts, average_rentals;

6. Find the monthly revenue trend for the entire rental store over time.

SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, 
       SUM(amount) AS monthly_revenue,
       SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) AS cumulative_revenue
FROM payment
GROUP BY month;

7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

WITH spending AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
)
SELECT customer_id, total_spent
FROM spending
WHERE total_spent >= PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_spent);

8. Calculate the running total of rentals per category, ordered by rental count.

SELECT category.name AS category_name, film.title, 
       COUNT(rental.rental_id) AS rental_count,
       SUM(COUNT(rental.rental_id)) OVER (PARTITION BY category.category_id ORDER BY rental_count DESC) AS running_total
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.category_id, film.film_id;

9. Find the films that have been rented less than the average rental count for their respective categories.

WITH category_avg AS (
    SELECT category.category_id, category.name AS category_name, 
           AVG(rental_count) AS avg_rental_count
    FROM (
        SELECT film_category.category_id, COUNT(rental.rental_id) AS rental_count
        FROM rental
        JOIN inventory ON rental.inventory_id = inventory.inventory_id
        JOIN film ON inventory.film_id = film.film_id
        JOIN film_category ON film.film_id = film_category.film_id
        GROUP BY film.film_id, film_category.category_id
    ) AS film_rentals
    JOIN category ON film_rentals.category_id = category.category_id
    GROUP BY category.category_id
)
SELECT film.title, category.category_name, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, category.category_id
HAVING rental_count < (SELECT avg_rental_count FROM category_avg WHERE category_avg.category_id = film_category.category_id);

10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, 
       SUM(amount) AS monthly_revenue
FROM payment
GROUP BY month
ORDER BY monthly_revenue DESC
LIMIT 5;


Normalisation & CTE

1. First Normal Form (1NF):
 a. Identify a table in the Sakila database that violates 1NF. Explain how you
 would normalize it to achieve 1NF.
 
- Violation: A table that violates 1NF might store multiple values in a single field, such as a table with a column for phone_numbers containing multiple comma-separated phone numbers for each customer.
- Solution: To achieve 1NF, split this column into multiple rows, so each phone number is in a separate row. For example, create a separate customer_phone table with customer_id and phone_number columns, linking to the customer table with a foreign key.

2. Second Normal Form (2NF):
 a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
 If it violates 2NF, explain the steps to normalize it.
 
- Example: Suppose there’s a rental_details table with columns rental_id, customer_id, store_id, and store_address.
- Violation: This table violates 2NF if store_address depends only on store_id, not on the entire primary key (rental_id and store_id).
- Solution: Move store_id and store_address to a separate store table and link it to rental_details through store_id.

3. Third Normal Form (3NF):
 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
 present and outline the steps to normalize the table to 3NF.
 
- Example: A table like film might contain columns film_id, director_id, director_name, and film_title.
- Violation: There’s a transitive dependency since director_name depends on director_id rather than film_id.
- Solution: Create a separate director table with director_id and director_name, and link it to the film table using director_id.

4. Normalization Process:
 a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 
 unnormalized form up to at least 2NF.
 
 Normalization Process:

- Example: Starting with an unnormalized orders table that stores multiple products in one row: order_id, customer_id, product_ids.
- 1NF: Split product_ids into multiple rows.
- 2NF: Remove any partial dependencies, e.g., split customer_address into a separate customer table.
- 3NF: Remove transitive dependencies by creating separate tables for customer, order, and product.

5. CTE Basics:
 a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
 have acted in from the actor and film_actor tables.
 
 WITH actor_films AS (
    SELECT actor_id, first_name, last_name, COUNT(film_id) AS film_count
    FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    GROUP BY actor.actor_id
)
SELECT first_name, last_name, film_count FROM actor_films;

6. CTE with Joins:
 a. Create a CTE that combines information from the film and language tables to display the film title, 
 language name, and rental rate.
 
 WITH film_language AS (
    SELECT film.title, language.name AS language_name, film.rental_rate
    FROM film
    JOIN language ON film.language_id = language.language_id
)
SELECT * FROM film_language;

7. CTE for Aggregation:
 a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
 from the customer and payment tables.
 
 WITH customer_revenue AS (
    SELECT customer_id, SUM(amount) AS total_revenue
    FROM payment
    GROUP BY customer_id
)
SELECT customer_id, total_revenue FROM customer_revenue;

8. CTE with Window Functions:
 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH ranked_films AS (
    SELECT film_id, title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS rental_duration_rank
    FROM film
)
SELECT * FROM ranked_films;

9. CTE and Filtering:
 a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
 customer table to retrieve additional customer details.
 
 WITH frequent_customers AS (
    SELECT customer_id, COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING rental_count > 2
)
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
JOIN frequent_customers ON customer.customer_id = frequent_customers.customer_id;

10. CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month, considering the 
 rental_date from the rental table.
 
 WITH monthly_rentals AS (
    SELECT DATE_FORMAT(rental_date, '%Y-%m') AS month, COUNT(*) AS total_rentals
    FROM rental
    GROUP BY month
)
SELECT * FROM monthly_rentals;

11. CTE and Self-Join:
 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
 together, using the film_actor table.
 
 WITH film_pairs AS (
    SELECT a1.actor_id AS actor1_id, a2.actor_id AS actor2_id, film_id
    FROM film_actor a1
    JOIN film_actor a2 ON a1.film_id = a2.film_id
    WHERE a1.actor_id < a2.actor_id
)
SELECT actor1_id, actor2_id, film_id FROM film_pairs;

12. CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
 considering the reports_to column
 
 WITH RECURSIVE employee_hierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = <manager_id>  -- Replace <manager_id> with the specific manager's ID

    UNION ALL

    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN employee_hierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM employee_hierarchy;
