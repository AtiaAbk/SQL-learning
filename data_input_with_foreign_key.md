# MySQL SQL Quick Notes — CRUD, Data Types, Foreign Keys & INSERT

A simple, beginner-friendly MySQL reference covering the commands discussed in this lesson:

- Deleting a specific row
- Changing a column's data type
- Understanding Primary Key and Foreign Key relationships
- Inserting values into related tables
- Correct insertion order for multiple related tables
- Foreign Key rules
- MySQL Shell examples with expected output
- Common mistakes and how to avoid them

---

## 1. Delete a Specific Row

To delete a particular row from a table, use:

```sql
DELETE FROM table_name
WHERE condition;
```

### Example

Suppose the `Employee` table contains:

| Employee_ID | Employee_Name | Department_ID |
|---:|---|---:|
| 101 | Oishi | 1 |
| 102 | Maliha | 2 |
| 103 | Sanjida | 3 |
| 104 | Nusrat | 4 |
| 105 | Tania | 5 |

To delete only the employee whose ID is `103`:

```sql
DELETE FROM Employee
WHERE Employee_ID = 103;
```

### Verify the result

```sql
SELECT * FROM Employee;
```

### MySQL Shell — Visual Example

```text
mysql> SELECT * FROM Employee;
+-------------+---------------+---------------+
| Employee_ID | Employee_Name | Department_ID |
+-------------+---------------+---------------+
|         101 | Oishi         |             1 |
|         102 | Maliha        |             2 |
|         103 | Sanjida       |             3 |
|         104 | Nusrat        |             4 |
|         105 | Tania         |             5 |
+-------------+---------------+---------------+
5 rows in set

mysql> DELETE FROM Employee
    -> WHERE Employee_ID = 103;

Query OK, 1 row affected

mysql> SELECT * FROM Employee;
+-------------+---------------+---------------+
| Employee_ID | Employee_Name | Department_ID |
+-------------+---------------+---------------+
|         101 | Oishi         |             1 |
|         102 | Maliha        |             2 |
|         104 | Nusrat        |             4 |
|         105 | Tania         |             5 |
+-------------+---------------+---------------+
4 rows in set
```

### ⚠️ Important

Never accidentally omit the `WHERE` clause when you intend to delete one row.

```sql
DELETE FROM Employee;
```

This deletes **all rows** from `Employee`.

---

# 2. Change a Column's Data Type

In MySQL, use `ALTER TABLE` with `MODIFY` to change a column's data type.

### Syntax

```sql
ALTER TABLE table_name
MODIFY column_name NEW_DATA_TYPE;
```

### Example

Change `Employee_Name` from `VARCHAR(50)` to `VARCHAR(100)`:

```sql
ALTER TABLE Employee
MODIFY Employee_Name VARCHAR(100);
```

Change `Employee_ID` to `BIGINT`:

```sql
ALTER TABLE Employee
MODIFY Employee_ID BIGINT;
```

### Keeping a constraint

If the column is supposed to remain `NOT NULL`, specify it again:

```sql
ALTER TABLE Employee
MODIFY Employee_ID BIGINT NOT NULL;
```

> When modifying a column, include the constraints you want the column to keep.

---

## 3. `MODIFY` vs `CHANGE`

### MODIFY

Use `MODIFY` when the column name stays the same.

```sql
ALTER TABLE Employee
MODIFY Employee_Name VARCHAR(100);
```

### CHANGE

Use `CHANGE` when you want to rename the column and/or change its definition.

```sql
ALTER TABLE Employee
CHANGE Employee_Name Name VARCHAR(100);
```

This changes:

```text
Employee_Name
      ↓
     Name
```

and changes the data type to `VARCHAR(100)`.

---

# 4. Primary Key and Foreign Key — Basic Idea

A **Primary Key (PK)** uniquely identifies each row in a table.

A **Foreign Key (FK)** creates a relationship between a child table and a parent table.

Example:

```text
┌─────────────────────┐
│     Department      │
├─────────────────────┤
│ PK Department_ID    │
│ Department_Name     │
└──────────┬──────────┘
           │
           │ FK
           ▼
┌─────────────────────┐
│      Employee       │
├─────────────────────┤
│ PK Employee_ID      │
│ Employee_Name       │
│ FK Department_ID    │
└──────────┬──────────┘
           │
           │ FK
           ▼
┌─────────────────────┐
│      Customer       │
├─────────────────────┤
│ PK Customer_ID      │
│ Customer_Name       │
│ FK Employee_ID      │
└─────────────────────┘
```

In this example:

- `Department.Department_ID` → Parent Key
- `Employee.Department_ID` → Foreign Key
- `Employee.Employee_ID` → Parent Key for Customer
- `Customer.Employee_ID` → Foreign Key

---

# 5. The Most Important Foreign Key Rule

## Parent First → Child Second

If a Foreign Key references a value in another table, that referenced value must already exist in the parent table before the child row can be inserted.

### Simple example

```text
Department
    │
    │ Department_ID
    ▼
Employee
    │
    │ Employee_ID
    ▼
Customer
```

Therefore:

```text
1. Insert Department
          ↓
2. Insert Employee
          ↓
3. Insert Customer
```

This is the correct insertion order.

---

# 6. Complete Example with 3 Related Tables

## Step 1 — Create the Department Table

```sql
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);
```

## Step 2 — Create the Employee Table

```sql
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Department_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);
```

## Step 3 — Create the Customer Table

```sql
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Employee_ID INT,
    FOREIGN KEY (Employee_ID)
        REFERENCES Employee(Employee_ID)
);
```

The relationship is:

```text
Department.Department_ID
            │
            │ referenced by
            ▼
Employee.Department_ID

Employee.Employee_ID
            │
            │ referenced by
            ▼
Customer.Employee_ID
```

---

# 7. Insert 5 Values into Department

Because `Department` is the first parent table, insert its data first.

```sql
INSERT INTO Department (Department_ID, Department_Name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');
```

### Check the table

```sql
SELECT * FROM Department;
```

### MySQL Shell Output

```text
mysql> SELECT * FROM Department;
+---------------+-----------------+
| Department_ID | Department_Name |
+---------------+-----------------+
|             1 | IT              |
|             2 | HR              |
|             3 | Finance         |
|             4 | Marketing       |
|             5 | Sales           |
+---------------+-----------------+
5 rows in set
```

---

# 8. Insert 5 Values into Employee

Now insert employees.

Notice that every `Department_ID` below already exists in the `Department` table.

```sql
INSERT INTO Employee (Employee_ID, Employee_Name, Department_ID)
VALUES
(101, 'Oishi', 1),
(102, 'Maliha', 2),
(103, 'Sanjida', 3),
(104, 'Nusrat', 4),
(105, 'Tania', 5);
```

### Relationship

```text
Oishi    → Department 1 → IT
Maliha   → Department 2 → HR
Sanjida  → Department 3 → Finance
Nusrat   → Department 4 → Marketing
Tania    → Department 5 → Sales
```

### Check the table

```sql
SELECT * FROM Employee;
```

### MySQL Shell Output

```text
mysql> SELECT * FROM Employee;
+-------------+---------------+---------------+
| Employee_ID | Employee_Name | Department_ID |
+-------------+---------------+---------------+
|         101 | Oishi         |             1 |
|         102 | Maliha        |             2 |
|         103 | Sanjida       |             3 |
|         104 | Nusrat        |             4 |
|         105 | Tania         |             5 |
+-------------+---------------+---------------+
5 rows in set
```

---

# 9. Insert 5 Values into Customer

Now the `Employee` table contains Employee IDs `101`–`105`, so those values can safely be used as Foreign Key values in `Customer`.

```sql
INSERT INTO Customer (Customer_ID, Customer_Name, Employee_ID)
VALUES
(201, 'Rahim', 101),
(202, 'Karim', 102),
(203, 'Hasan', 103),
(204, 'Jamal', 104),
(205, 'Sakib', 105);
```

### Relationship

```text
Rahim  → Employee 101 → Oishi
Karim  → Employee 102 → Maliha
Hasan  → Employee 103 → Sanjida
Jamal  → Employee 104 → Nusrat
Sakib  → Employee 105 → Tania
```

### Check the table

```sql
SELECT * FROM Customer;
```

### MySQL Shell Output

```text
mysql> SELECT * FROM Customer;
+-------------+---------------+-------------+
| Customer_ID | Customer_Name | Employee_ID |
+-------------+---------------+-------------+
|         201 | Rahim         |         101 |
|         202 | Karim         |         102 |
|         203 | Hasan         |         103 |
|         204 | Jamal         |         104 |
|         205 | Sakib         |         105 |
+-------------+---------------+-------------+
5 rows in set
```

---

# 10. Complete Data Relationship

After inserting all 15 rows:

```text
                    DEPARTMENT
              ┌─────────────────┐
              │ 1  → IT         │
              │ 2  → HR         │
              │ 3  → Finance    │
              │ 4  → Marketing  │
              │ 5  → Sales      │
              └────────┬────────┘
                       │
                       │ Department_ID
                       ▼
                    EMPLOYEE
              ┌─────────────────┐
              │ 101 → Oishi     │
              │ 102 → Maliha    │
              │ 103 → Sanjida   │
              │ 104 → Nusrat    │
              │ 105 → Tania     │
              └────────┬────────┘
                       │
                       │ Employee_ID
                       ▼
                    CUSTOMER
              ┌─────────────────┐
              │ 201 → Rahim     │
              │ 202 → Karim     │
              │ 203 → Hasan     │
              │ 204 → Jamal     │
              │ 205 → Sakib     │
              └─────────────────┘
```

---

# 11. What Happens if You Insert the Child First?

Suppose the `Department` table does **not** contain Department ID `20`.

If you try:

```sql
INSERT INTO Employee
(Employee_ID, Employee_Name, Department_ID)
VALUES
(106, 'Someone', 20);
```

MySQL will reject the row because `Department_ID = 20` does not exist in the parent table.

Typical error:

```text
ERROR 1452 (23000):
Cannot add or update a child row:
a foreign key constraint fails
```

### Why?

```text
Employee.Department_ID = 20
              │
              ▼
Does Department.Department_ID = 20 exist?
              │
         ┌────┴────┐
         │         │
        YES        NO
         │         │
       INSERT     ERROR
```

---

# 12. Correct Way to Fix It

First create the parent value:

```sql
INSERT INTO Department
(Department_ID, Department_Name)
VALUES
(20, 'Research');
```

Then insert the employee:

```sql
INSERT INTO Employee
(Employee_ID, Employee_Name, Department_ID)
VALUES
(106, 'Someone', 20);
```

Now the Foreign Key relationship is valid.

---

# 13. `INSERT` Syntax You Should Remember

### Insert one row

```sql
INSERT INTO Department
(Department_ID, Department_Name)
VALUES
(6, 'Administration');
```

### Insert multiple rows

```sql
INSERT INTO Department
(Department_ID, Department_Name)
VALUES
(7, 'Security'),
(8, 'Support'),
(9, 'Operations');
```

### Check inserted data

```sql
SELECT * FROM Department;
```

---

# 14. Foreign Key Rules — Quick Reference

| Rule | Explanation |
|---|---|
| Parent first | Insert referenced values into the parent table first |
| Child second | Insert the Foreign Key value into the child after the parent exists |
| FK must match | A non-NULL FK normally must match an existing referenced key |
| PK must be unique | Primary Key values cannot be duplicated |
| Don't use random FK values | The referenced value must exist in the parent |
| Deletion can be restricted | A parent row may not be deletable while referenced by a child |
| Update can be restricted | Changing a referenced parent key may be restricted depending on the FK rules |

---

# 15. Insert Order vs Delete Order

For the example:

```text
Department
    ↓
Employee
    ↓
Customer
```

### INSERT

Go from **Parent → Child**:

```text
Department
    ↓
Employee
    ↓
Customer
```

### DELETE

When Foreign Key restrictions are active, you generally need to remove dependent child rows first:

```text
Customer
    ↓
Employee
    ↓
Department
```

This is because a child row may depend on the parent row.

---

# 16. Useful Verification Commands

### Show all databases

```sql
SHOW DATABASES;
```

### Select a database

```sql
USE database_name;
```

### Show all tables

```sql
SHOW TABLES;
```

### Show table structure

```sql
DESCRIBE Employee;
```

or:

```sql
DESC Employee;
```

### View all rows

```sql
SELECT * FROM Employee;
```

---

# 17. Important Commands at a Glance

| Task | Command |
|---|---|
| Insert data | `INSERT INTO ... VALUES ...;` |
| Read data | `SELECT * FROM table_name;` |
| Delete specific row | `DELETE FROM table_name WHERE condition;` |
| Delete all rows | `DELETE FROM table_name;` |
| Change column type | `ALTER TABLE ... MODIFY ...;` |
| Rename/change column | `ALTER TABLE ... CHANGE ...;` |
| Show tables | `SHOW TABLES;` |
| Show structure | `DESCRIBE table_name;` |

---

# 18. Exam-Friendly Rules to Memorize

### Rule 1 — DELETE

```text
DELETE + WHERE = delete specific rows
```

Example:

```sql
DELETE FROM Employee
WHERE Employee_ID = 103;
```

---

### Rule 2 — Change Data Type

```text
ALTER TABLE + MODIFY
```

Example:

```sql
ALTER TABLE Employee
MODIFY Employee_Name VARCHAR(100);
```

---

### Rule 3 — Foreign Key INSERT

```text
PARENT → CHILD
```

Example:

```text
Department → Employee → Customer
```

---

### Rule 4 — Foreign Key Value

Before inserting:

```text
Employee.Department_ID = 5
```

make sure:

```text
Department.Department_ID = 5
```

already exists.

---

# 19. One Complete Practice Script

The following script demonstrates the complete process from table creation to insertion.

```sql
-- Create Department
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);

-- Create Employee
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Department_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);

-- Create Customer
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Employee_ID INT,
    FOREIGN KEY (Employee_ID)
        REFERENCES Employee(Employee_ID)
);

-- Insert into Parent Table
INSERT INTO Department (Department_ID, Department_Name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

-- Insert into Child Table
INSERT INTO Employee (Employee_ID, Employee_Name, Department_ID)
VALUES
(101, 'Oishi', 1),
(102, 'Maliha', 2),
(103, 'Sanjida', 3),
(104, 'Nusrat', 4),
(105, 'Tania', 5);

-- Insert into Next Child Table
INSERT INTO Customer (Customer_ID, Customer_Name, Employee_ID)
VALUES
(201, 'Rahim', 101),
(202, 'Karim', 102),
(203, 'Hasan', 103),
(204, 'Jamal', 104),
(205, 'Sakib', 105);

-- View the data
SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Customer;
```

---

# 20. Final Mental Model

Whenever you see multiple tables connected by Foreign Keys, ask:

```text
1. Which table is the PARENT?
           ↓
2. Which table is the CHILD?
           ↓
3. Which column is the PRIMARY KEY?
           ↓
4. Which column is the FOREIGN KEY?
           ↓
5. Does the referenced parent value already exist?
           ↓
6. If YES → INSERT
   If NO  → Insert the parent value first
```

### The easiest rule:

> **A Foreign Key cannot normally point to a parent value that does not exist.**

So remember:

```text
        INSERT
           │
           ▼
     ┌───────────┐
     │  PARENT   │
     └─────┬─────┘
           │
           │ PK
           ▼
     ┌───────────┐
     │   CHILD   │
     └───────────┘
           FK
```

**Parent first. Child second.**

That one rule will prevent most Foreign Key insertion errors.
