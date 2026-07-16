# 🐬 Ultimate MySQL Handbook

> complete guide to MySQL — from installation to advanced database management. This repository is a structured, hands on reference covering everything from basic CRUD operations to stored procedures, triggers, and query optimization.

![MySQL](https://img.shields.io/badge/MySQL-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Database-blue?style=for-the-badge)

---

## 📖 Table of Contents

1. [Installing MySQL](#1-installing-mysql)
2. [Linux (Ubuntu) Installation & User Setup](#2-linux-ubuntu-installation--user-setup)
3. [Getting Started — Databases & Tables](#3-getting-started--databases--tables)
4. [Working with Tables (SELECT, RENAME, ALTER)](#4-working-with-tables)
5. [Inserting Data](#5-inserting-data)
6. [Querying Data with SELECT](#6-querying-data-with-select)
7. [UPDATE — Modifying Data](#7-update--modifying-data)
8. [DELETE — Removing Data](#8-delete--removing-data)
9. [Constraints](#9-constraints)
10. [SQL Functions](#10-sql-functions)
11. [Transactions & AutoCommit](#11-transactions--autocommit)
12. [PRIMARY KEY Deep Dive](#12-primary-key-deep-dive)
13. [Foreign Keys](#13-foreign-keys)
14. [JOINs](#14-joins)
15. [UNION & UNION ALL](#15-union--union-all)
16. [Self JOIN](#16-self-join)
17. [Views](#17-views)
18. [Indexes](#18-indexes)
19. [Subqueries](#19-subqueries)
20. [GROUP BY & HAVING](#20-group-by--having)
21. [Stored Procedures](#21-stored-procedures)
22. [Triggers](#22-triggers)
23. [More Useful MySQL Features](#23-more-useful-mysql-features)
24. [🎓 Recommended Learning Resources](#-recommended-learning-resources)
25. [👨‍💻 Author](#-author)
26. [📄 License](#-license)
---

## 1. Installing MySQL

**MySQL Workbench** is a visual tool for database development and administration — design databases, write queries, manage servers, create backups, and monitor performance without relying solely on the command line.

**DBMS (Database Management System):** Software that lets users create, store, organize, retrieve, and manage data efficiently — acting as a bridge between users and databases.

### Features of MySQL
- Open source and free to use
- High performance and reliable engine
- Cross-platform (Windows, Linux, macOS)
- Strong security and authentication

### Windows / macOS Installation
1. Download from [dev.mysql.com/downloads/installer](https://dev.mysql.com/downloads/installer/)
2. Run the installer → choose **Developer Default**
3. Follow the setup wizard
4. Set a root password
5. Install MySQL Workbench for GUI management
6. Launch MySQL Workbench

---

## 2. Linux (Ubuntu) Installation & User Setup

```bash
# Step 1: Update package index
sudo apt update

# Step 2: Install MySQL Server
sudo apt install mysql-server

# Step 3: Secure the installation
sudo mysql_secure_installation

# Step 4: Log into MySQL
sudo mysql
```

### Create a New User

```sql
CREATE USER 'harry'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'Atia'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
```

### Test the Login

```bash
mysql -u Atia -p
```

> ⚠️ Always replace `'password'` with a strong, secure password in production.

---

## 3. Getting Started — Databases & Tables

A **database** is a container for organized, related data. Think of it like:

| Analogy | Database | Table | Row |
|---|---|---|---|
| Folder | Folder | File | Content inside the file |
| Excel | Workbook | Sheet | Row in the sheet |

### Create & Use a Database

```sql
CREATE DATABASE startersql;
USE startersql;
```

### Create a Table

```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  gender ENUM('Male', 'Female', 'Other'),
  date_of_birth DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Drop a Database

```sql
DROP DATABASE startersql;
```

### Common Data Types

| Type | Description |
|---|---|
| `INT` | Whole numbers |
| `VARCHAR(n)` | Variable-length string, up to `n` characters |
| `ENUM` | A value chosen from a fixed list |
| `DATE` | Date values |
| `TIMESTAMP` | Date + time, can auto-set to current time |
| `BOOLEAN` | `TRUE` / `FALSE` |
| `DECIMAL(p, s)` | Exact numeric value — `p` = total digits, `s` = digits after decimal |

### Constraints Quick Reference

| Constraint | Purpose |
|---|---|
| `AUTO_INCREMENT` | Auto-generates a unique number per row |
| `PRIMARY KEY` | Uniquely identifies each row |
| `NOT NULL` | Column can't be NULL |
| `UNIQUE` | No duplicate values allowed |
| `DEFAULT` | Sets a fallback value |

---

## 4. Working with Tables

### Selecting Data

```sql
SELECT * FROM users;                  -- all columns
SELECT name, email FROM users;        -- specific columns
```

### Renaming a Table

```sql
RENAME TABLE users TO customers;
RENAME TABLE customers TO users;
```

### Altering Tables

```sql
-- Add a column
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT TRUE;

-- Drop a column
ALTER TABLE users DROP COLUMN is_active;

-- Modify a column's type
ALTER TABLE users MODIFY COLUMN name VARCHAR(150);

-- Reposition a column
ALTER TABLE users MODIFY COLUMN email VARCHAR(100) FIRST;
ALTER TABLE users MODIFY COLUMN gender ENUM('Male','Female','Other') AFTER name;

-- Add multiple columns at once
ALTER TABLE users
  ADD COLUMN phone VARCHAR(15),
  ADD COLUMN city VARCHAR(100);

-- Rename a column
ALTER TABLE users RENAME COLUMN phone TO mobile_number;
```

---

## 5. Inserting Data

### Full Row Insert (not recommended for evolving schemas)

```sql
INSERT INTO users VALUES
(1, 'Alice', 'alice@example.com', 'Female', '1995-05-14', DEFAULT);
```

### Insert by Column Name (Best Practice)

```sql
INSERT INTO users (name, email, gender, date_of_birth)
VALUES ('Bob', 'bob@example.com', 'Male', '1990-11-23');
```

### Multiple Row / Bulk Insert

```sql
INSERT INTO users (name, email, gender, date_of_birth)
VALUES
  ('Bob', 'bob@example.com', 'Male', '1990-11-23'),
  ('Charlie', 'charlie@example.com', 'Other', '1988-02-17'),
  ('David', 'david@example.com', 'Male', '2000-08-09');
```

> Bulk inserts reduce the number of round-trips to the database — much faster than inserting rows one at a time.

---

## 6. Querying Data with SELECT

### Basic Syntax

```sql
SELECT column1, column2 FROM table_name;
SELECT * FROM users;
```

### Filtering with WHERE

```sql
WHERE gender = 'Male'                 -- equal
WHERE gender != 'Female'              -- not equal (or <>)
WHERE date_of_birth < '1995-01-01'    -- less than
WHERE id > 10                         -- greater than
WHERE id >= 5 AND id <= 20            -- range
```

### NULL Handling

```sql
SELECT * FROM users WHERE date_of_birth IS NULL;
SELECT * FROM users WHERE date_of_birth IS NOT NULL;
```

### BETWEEN, IN, LIKE

```sql
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';
WHERE gender IN ('Male', 'Other');
WHERE name LIKE 'A%';    -- starts with A
WHERE name LIKE '%a';    -- ends with a
WHERE name LIKE '%li%';  -- contains 'li'
```

### AND / OR

```sql
WHERE gender = 'Female' AND date_of_birth > '1990-01-01';
WHERE gender = 'Male' OR gender = 'Other';
```

### Sorting & Limiting

```sql
SELECT * FROM users ORDER BY date_of_birth ASC;
SELECT * FROM users ORDER BY name DESC;

SELECT * FROM users LIMIT 5;                -- top 5
SELECT * FROM users LIMIT 10 OFFSET 5;      -- skip 5, take 10
SELECT * FROM users LIMIT 5, 10;            -- same as above (offset, count)
```

---

## 7. UPDATE — Modifying Data

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

**Examples:**

```sql
UPDATE users SET name = 'Alicia' WHERE id = 1;

UPDATE users
SET name = 'Robert', email = 'robert@example.com'
WHERE id = 2;

-- Increment an existing value
UPDATE users SET salary = salary + 10000 WHERE salary < 60000;
```

> ⚠️ **Never omit `WHERE`** unless you intend to update every single row:
> ```sql
> UPDATE users SET gender = 'Other'; -- updates ALL rows!
> ```

---

## 8. DELETE — Removing Data

```sql
DELETE FROM table_name WHERE condition;
```

```sql
DELETE FROM users WHERE id = 3;
DELETE FROM users WHERE gender = 'Other';

-- Delete all rows but keep table structure
DELETE FROM users;

-- Delete the table entirely (structure + data)
DROP TABLE users;
```

### Best Practices
- Always use `WHERE` unless intentionally deleting everything.
- Run the equivalent `SELECT` first to preview affected rows.
- Back up important data before destructive operations.

---

## 9. Constraints

| Constraint | Purpose |
|---|---|
| `UNIQUE` | Prevents duplicate values |
| `NOT NULL` | Ensures a value is always provided |
| `CHECK` | Restricts values using a custom condition |
| `DEFAULT` | Sets a default value |
| `PRIMARY KEY` | Uniquely identifies each row |
| `AUTO_INCREMENT` | Auto-generates unique numeric IDs |

```sql
-- UNIQUE
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);

-- NOT NULL
ALTER TABLE users MODIFY COLUMN name VARCHAR(100) NOT NULL;

-- CHECK
ALTER TABLE users ADD CONSTRAINT chk_dob CHECK (date_of_birth > '2000-01-01');

-- DEFAULT
ALTER TABLE users ALTER COLUMN is_active SET DEFAULT TRUE;

-- PRIMARY KEY (added later)
ALTER TABLE users ADD PRIMARY KEY (id);
```

---

## 10. SQL Functions

### Aggregate Functions

```sql
SELECT COUNT(*) FROM users;
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM users;
SELECT SUM(salary) AS total_payroll FROM users;
SELECT AVG(salary) AS avg_salary FROM users;

SELECT gender, AVG(salary) AS avg_salary
FROM users
GROUP BY gender;
```

### String Functions

```sql
SELECT name, LENGTH(name) AS name_length FROM users;
SELECT name, LOWER(name) AS lowercase_name FROM users;
SELECT name, UPPER(name) AS uppercase_name FROM users;
SELECT CONCAT(name, ' <', email, '>') AS user_contact FROM users;
```

### Date Functions

```sql
SELECT NOW();
SELECT name, YEAR(date_of_birth) AS birth_year FROM users;
SELECT name, DATEDIFF(CURDATE(), date_of_birth) AS days_lived FROM users;
SELECT name, TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age FROM users;
```

### Mathematical Functions

```sql
SELECT salary, ROUND(salary) AS rounded, FLOOR(salary) AS floored, CEIL(salary) AS ceiled FROM users;
SELECT id, MOD(id, 2) AS remainder FROM users;
```

### Conditional Functions

```sql
SELECT name, gender, IF(gender = 'Female', 'Yes', 'No') AS is_female FROM users;
```

| Function | Purpose |
|---|---|
| `COUNT()` | Count rows |
| `SUM()` | Total of a column |
| `AVG()` | Average of values |
| `MIN()` / `MAX()` | Lowest / highest value |
| `LENGTH()` | String length |
| `CONCAT()` | Merge strings |
| `YEAR()` / `DATEDIFF()` | Date breakdown / age |
| `ROUND()` | Rounding numbers |
| `IF()` | Conditional logic |

---

## 11. Transactions & AutoCommit

By default, MySQL runs in **AutoCommit** mode — every statement commits automatically. Disable it for manual control over complex, multi-step operations.

```sql
-- Disable AutoCommit
SET autocommit = 0;

-- Make changes
UPDATE users SET salary = 80000 WHERE id = 5;

-- Save changes permanently
COMMIT;

-- OR revert changes since the last COMMIT/ROLLBACK
ROLLBACK;

-- Re-enable AutoCommit
SET autocommit = 1;
```

### Best Practices
- Use `COMMIT` to finalize changes you're confident about.
- Use `ROLLBACK` to discard changes if something goes wrong.
- Disable AutoCommit for complex multi-step updates.
- Always test transactional queries before running them in production.

---

## 12. PRIMARY KEY Deep Dive

A `PRIMARY KEY`:
- Must be unique
- Cannot be NULL
- Identifies each row
- Can be a single column or a composite of columns
- Only **one** per table

### PRIMARY KEY vs UNIQUE

| Feature | PRIMARY KEY | UNIQUE |
|---|---|---|
| Must be unique | ✅ Yes | ✅ Yes |
| Allows NULL | ❌ No | ✅ Yes (multiple NULLs allowed) |
| How many allowed | Only 1 per table | Multiple allowed |
| Required | Recommended/often required | Optional |
| Dropping | Restricted | Easy |

```sql
-- Drop a primary key
ALTER TABLE users DROP PRIMARY KEY;

-- Drop a unique constraint
ALTER TABLE users DROP INDEX email;

-- Reset AUTO_INCREMENT starting value
ALTER TABLE users AUTO_INCREMENT = 1000;
```

---

## 13. Foreign Keys

A **foreign key** links two tables, ensuring a value in one table matches a value in another — maintaining data integrity.

```sql
CREATE TABLE addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  street VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(100),
  pincode VARCHAR(10),
  CONSTRAINT fk_user
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Adding / Dropping Later

```sql
ALTER TABLE addresses
  ADD CONSTRAINT fk_user
  FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE addresses DROP FOREIGN KEY fk_user;
```

### ON DELETE Options

| Option | Behavior |
|---|---|
| `CASCADE` | Deletes related child rows automatically |
| `SET NULL` | Sets the foreign key to NULL in the child table |
| `RESTRICT` | Prevents deletion of the parent if children exist (default) |

```sql
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
```

---

## 14. JOINs

Given:

**users**

| id | name |
|---|---|
| 1 | Aarav |
| 2 | Sneha |
| 3 | Raj |

**addresses**

| id | user_id | city |
|---|---|---|
| 1 | 1 | Mumbai |
| 2 | 2 | Kolkata |
| 3 | 4 | Delhi |

### INNER JOIN — only matching rows

```sql
SELECT users.name, addresses.city
FROM users
INNER JOIN addresses ON users.id = addresses.user_id;
```
→ Aarav–Mumbai, Sneha–Kolkata (Raj and Delhi excluded — no match)

### LEFT JOIN — all left rows, matched or NULL

```sql
SELECT users.name, addresses.city
FROM users
LEFT JOIN addresses ON users.id = addresses.user_id;
```
→ Includes Raj with `NULL` city

### RIGHT JOIN — all right rows, matched or NULL

```sql
SELECT users.name, addresses.city
FROM users
RIGHT JOIN addresses ON users.id = addresses.user_id;
```
→ Includes Delhi with `NULL` name

---

## 15. UNION & UNION ALL

`UNION` combines results from multiple `SELECT` statements and **removes duplicates**. `UNION ALL` keeps duplicates.

```sql
SELECT name FROM users
UNION
SELECT name FROM admin_users;

SELECT name FROM users
UNION ALL
SELECT name FROM admin_users;

-- Multiple columns + labeling source
SELECT name, 'User' AS role FROM users
UNION
SELECT name, 'Admin' AS role FROM admin_users;

-- With sorting
SELECT name FROM users
UNION
SELECT name FROM admin_users
ORDER BY name;
```

### Rules
1. Column count and compatible data types must match across all `SELECT`s.
2. `UNION` removes duplicates; `UNION ALL` keeps them.

**Use cases:** merging similar/archived tables, combining filtered results from multiple sources, cross-category reporting.

---

## 16. Self JOIN

Joining a table **with itself** — useful for hierarchical/referral relationships.

```sql
ALTER TABLE users ADD COLUMN referred_by_id INT;

UPDATE users SET referred_by_id = 1 WHERE id IN (2, 3);
UPDATE users SET referred_by_id = 2 WHERE id = 4;

SELECT
  a.id,
  a.name AS user_name,
  b.name AS referred_by
FROM users a
LEFT JOIN users b ON a.referred_by_id = b.id;
```

> Use table aliases (`a`, `b`) to distinguish the two instances of the same table. Common in employee-manager hierarchies and referral systems.

---

## 17. Views

A **view** is a virtual table based on a saved `SELECT` query. It stores no data of its own — it always reflects the live data in the base tables.

```sql
CREATE VIEW high_salary_users AS
SELECT id, name, salary
FROM users
WHERE salary > 70000;

SELECT * FROM high_salary_users;

DROP VIEW high_salary_users;
```

### Why Use Views?
- Simplify complex/repeated queries
- Reuse query logic
- Hide certain columns from end users
- Get a live, filtered "snapshot" of data — updates automatically as base tables change

---

## 18. Indexes

Indexes speed up data retrieval — like a book's index — helping MySQL find rows faster for searches, filters, and joins.

```sql
-- View existing indexes
SHOW INDEXES FROM users;

-- Single-column index
CREATE INDEX idx_email ON users(email);

-- Multi-column (composite) index
CREATE INDEX idx_gender_salary ON users(gender, salary);

-- Drop an index
DROP INDEX idx_email ON users;
```

### Notes
- Indexes consume extra disk space and slightly slow down `INSERT`/`UPDATE`/`DELETE`.
- Use indexes on columns used in `WHERE`, `JOIN`, and `ORDER BY`.
- **Column order matters** in composite indexes — the leftmost column must be present in the filter for the index to be used effectively.

| Feature | Description |
|---|---|
| `SHOW INDEXES` | View current indexes on a table |
| `CREATE INDEX` | Create single or multi-column indexes |
| `DROP INDEX` | Remove an index |
| Use when | Query performance on large tables is a concern |
| Avoid on | Rarely queried or always-unique columns |

---

## 19. Subqueries

A query nested inside another — useful for breaking complex problems into smaller pieces.

### Scalar Subquery

```sql
SELECT id, name, salary
FROM users
WHERE salary > (SELECT AVG(salary) FROM users);
```

### Subquery with IN

```sql
SELECT id, name, referred_by_id
FROM users
WHERE referred_by_id IN (
  SELECT id FROM users WHERE salary > 75000
);
```

### Subquery in SELECT

```sql
SELECT name, salary,
  (SELECT AVG(salary) FROM users) AS average_salary
FROM users;
```

| Subquery Type | Use Case |
|---|---|
| Scalar Subquery | Returns one value (e.g. AVG, MAX) |
| Subquery with IN | Returns multiple values |
| Subquery in SELECT | Shows a related calculated value |
| Subquery in FROM | Acts as a virtual/derived table |

---

## 20. GROUP BY & HAVING

`GROUP BY` groups rows sharing the same column values (used with aggregates). `HAVING` filters **groups** after aggregation — `WHERE` filters individual rows **before** grouping.

```sql
-- Average salary by gender
SELECT gender, AVG(salary) AS average_salary
FROM users
GROUP BY gender;

-- Count referrals per referrer
SELECT referred_by_id, COUNT(*) AS total_referred
FROM users
WHERE referred_by_id IS NOT NULL
GROUP BY referred_by_id;

-- Filter groups with HAVING
SELECT gender, AVG(salary) AS avg_salary
FROM users
GROUP BY gender
HAVING AVG(salary) > 75000;

-- Subtotals + grand total
SELECT gender, COUNT(*) AS total_users
FROM users
GROUP BY gender WITH ROLLUP;
```

| Clause | Purpose | Can use aggregates? |
|---|---|---|
| `WHERE` | Filters rows before grouping | ❌ No |
| `GROUP BY` | Groups rows by column values | N/A |
| `HAVING` | Filters groups after aggregation | ✅ Yes |

---

## 21. Stored Procedures

A saved, reusable block of SQL logic. Since procedures use `;` internally, we temporarily change the statement **delimiter** while defining them.

```sql
DELIMITER $$

CREATE PROCEDURE AddUser(
  IN p_name VARCHAR(100),
  IN p_email VARCHAR(100),
  IN p_gender ENUM('Male', 'Female', 'Other'),
  IN p_dob DATE,
  IN p_salary INT
)
BEGIN
  INSERT INTO users (name, email, gender, date_of_birth, salary)
  VALUES (p_name, p_email, p_gender, p_dob, p_salary);
END$$

DELIMITER ;
```

```sql
-- Call it
CALL AddUser('Kiran Sharma', 'kiran@example.com', 'Female', '1994-06-15', 72000);

-- View existing procedures
SHOW PROCEDURE STATUS WHERE Db = 'startersql';

-- Drop a procedure
DROP PROCEDURE IF EXISTS AddUser;
```

| Command | Purpose |
|---|---|
| `DELIMITER $$` | Temporarily change the statement delimiter |
| `CREATE PROCEDURE` | Define a new stored procedure |
| `CALL procedure_name(...)` | Execute a stored procedure |
| `DROP PROCEDURE` | Remove an existing procedure |

---

## 22. Triggers

A **trigger** automatically runs when a specific event (`INSERT`, `UPDATE`, `DELETE`) occurs on a table. Common uses: logging changes, enforcing business rules, syncing related data.

```sql
CREATE TABLE user_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  name VARCHAR(100),
  created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER after_user_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO user_log (user_id, name)
  VALUES (NEW.id, NEW.name);
END$$

DELIMITER ;
```

```sql
-- Drop a trigger
DROP TRIGGER IF EXISTS after_user_insert;
```

| Trigger Component | Description |
|---|---|
| `BEFORE` / `AFTER` | When the trigger runs |
| `INSERT` / `UPDATE` / `DELETE` | The action that fires it |
| `NEW.column` | Refers to the new row (INSERT/UPDATE) |
| `OLD.column` | Refers to the old row (UPDATE/DELETE) |
| `FOR EACH ROW` | Runs once per affected row |

---

## 23. More Useful MySQL Features

### Logical Operators

| Operator | Description | Example |
|---|---|---|
| `AND` | All conditions must be true | `salary > 50000 AND gender = 'Male'` |
| `OR` | At least one condition is true | `gender = 'Male' OR gender = 'Other'` |
| `NOT` | Reverses a condition | `NOT gender = 'Female'` |

### Wildcards (with `LIKE`)

| Wildcard | Description | Example |
|---|---|---|
| `%` | Matches any sequence of characters | `name LIKE 'A%'` |
| `_` | Matches exactly one character | `name LIKE '_a%'` |

### LIMIT with OFFSET

```sql
SELECT * FROM users ORDER BY id LIMIT 5 OFFSET 10;
SELECT * FROM users ORDER BY id LIMIT 10, 5; -- equivalent
```

### DISTINCT

```sql
SELECT DISTINCT gender FROM users;
```

### TRUNCATE vs DELETE

```sql
TRUNCATE TABLE users;
```
- Removes all rows, keeps the table structure
- Faster than `DELETE FROM users`
- Cannot be rolled back in most cases

### CHANGE vs MODIFY

```sql
-- CHANGE: rename + change datatype
ALTER TABLE users CHANGE COLUMN city location VARCHAR(150);

-- MODIFY: only change datatype
ALTER TABLE users MODIFY COLUMN salary BIGINT;
```

---

## 🧠 Quick Reference Cheat Sheet

| Category | Key Commands |
|---|---|
| Database | `CREATE DATABASE`, `USE`, `DROP DATABASE` |
| Table | `CREATE TABLE`, `ALTER TABLE`, `RENAME TABLE`, `DROP TABLE`, `TRUNCATE TABLE` |
| Data (CRUD) | `INSERT INTO`, `SELECT`, `UPDATE`, `DELETE` |
| Filtering | `WHERE`, `AND`/`OR`/`NOT`, `IN`, `LIKE`, `BETWEEN`, `IS NULL` |
| Sorting/Limiting | `ORDER BY`, `LIMIT`, `OFFSET` |
| Aggregation | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING` |
| Relationships | `PRIMARY KEY`, `FOREIGN KEY`, `JOIN` (`INNER`/`LEFT`/`RIGHT`/`SELF`) |
| Combining | `UNION`, `UNION ALL` |
| Reusable Logic | `VIEW`, `PROCEDURE`, `TRIGGER` |
| Performance | `INDEX` |
| Transactions | `SET autocommit`, `COMMIT`, `ROLLBACK` |

---
---

# 🎓 Recommended Learning Resources

If you want to master MySQL from beginner to advanced, I highly recommend the following free resources.

## 📺 YouTube Courses

### 🟢 Beginner
- 🎥 Bro Code – MySQL Full Course  
  https://youtu.be/5OdVJbNCSso

- 🎥 Programming with Mosh – SQL Tutorial for Beginners  
  https://youtu.be/7S_tz1z_5bA

- 🎥 freeCodeCamp – SQL Full Database Course (4+ Hours)  
  https://youtu.be/HXV3zeQKqGY

### 🟡 Intermediate
- 🎥 Hussein Nasser – Database Engineering Playlist  
  https://www.youtube.com/@hnasr

- 🎥 ByteByteGo – Database & System Design  
  https://www.youtube.com/@ByteByteGo

- 🎥 TechTFQ – Advanced SQL Playlist  
  https://www.youtube.com/@TechTFQ

### 🔴 Advanced
- 🎥 CMU Database Systems (15-445)
  https://www.youtube.com/@CMUDatabaseGroup

- 🎥 Neso Academy – DBMS Playlist
  https://www.youtube.com/@nesoacademy

---

## 💻 SQL Practice Platforms

- HackerRank SQL  
  https://www.hackerrank.com/domains/sql

- LeetCode Database Problems  
  https://leetcode.com/problemset/database/

- SQLBolt  
  https://sqlbolt.com/

- SQLZoo  
  https://sqlzoo.net/

- StrataScratch  
  https://www.stratascratch.com/

---

## 📚 Recommended Books

- Learning SQL — Alan Beaulieu
- SQL Cookbook — Anthony Molinaro
- High Performance MySQL
- Database System Concepts
- Designing Data-Intensive Applications

---

# 👨‍💻 Author

**Atia Sanjida Oishi**

🎓 Information & Communication Engineering (ICE)  
Bangladesh Army University of Engineering & Technology (BAUET)

- 🌐 GitHub: https://github.com/AtiaAbk
- 💼 LinkedIn: https://www.linkedin.com/in/atia-sanjida-085947233/

If you found this repository helpful, please consider giving it a ⭐ on GitHub. Your support motivates me to create more open-source learning resources.

---
## 🙏 Credits

Notes compiled from **CodeWithHarry's Ultimate MySQL Notebook**, restructured here as a personal Git reference for learning and revision.

## 📄 License

This project is intended for educational purposes. Feel free to use, modify, and share it for learning and personal projects.

⭐ **If this repository helped you, don't forget to star it!**

