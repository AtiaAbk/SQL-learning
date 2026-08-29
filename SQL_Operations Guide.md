# 🗄️ DBMS & MySQL — Complete SQL Operations Guide

> **A complete beginner-to-intermediate SQL/DBMS reference for Database, Tables, Records, Columns, Constraints, ALTER operations, Keys, INSERT, UPDATE, DELETE, DROP, TRUNCATE and more.**

<p align="center">

![MySQL](https://img.shields.io/badge/MySQL-Database-blue?style=for-the-badge\&logo=mysql)
![SQL](https://img.shields.io/badge/SQL-Structured_Query_Language-orange?style=for-the-badge)
![DBMS](https://img.shields.io/badge/DBMS-Complete_Guide-green?style=for-the-badge)

</p>

---

## 📚 Table of Contents

* [1. DBMS Basic Concepts](#1-dbms-basic-concepts)
* [2. Database Operations](#2-database-operations)
* [3. Table Operations](#3-table-operations)
* [4. Column Operations](#4-column-operations)
* [5. Data / Record Operations](#5-data--record-operations)
* [6. SELECT Operations](#6-select-operations)
* [7. INSERT Operations](#7-insert-operations)
* [8. UPDATE Operations](#8-update-operations)
* [9. DELETE Operations](#9-delete-operations)
* [10. DELETE vs TRUNCATE vs DROP](#10-delete-vs-truncate-vs-drop)
* [11. Integrity Constraints](#11-integrity-constraints)
* [12. PRIMARY KEY](#12-primary-key)
* [13. FOREIGN KEY](#13-foreign-key)
* [14. UNIQUE Constraint](#14-unique-constraint)
* [15. NOT NULL Constraint](#15-not-null-constraint)
* [16. CHECK Constraint](#16-check-constraint)
* [17. DEFAULT Constraint](#17-default-constraint)
* [18. ALTER TABLE](#18-alter-table)
* [19. Add Constraint Externally](#19-add-constraint-externally)
* [20. Drop Constraint Externally](#20-drop-constraint-externally)
* [21. Rename Column](#21-rename-column)
* [22. Move Column](#22-move-column)
* [23. Remove Column](#23-remove-column)
* [24. Add Column](#24-add-column)
* [25. Foreign Key Actions](#25-foreign-key-actions)
* [26. Composite Keys](#26-composite-keys)
* [27. Useful Inspection Commands](#27-useful-inspection-commands)
* [28. Complete Example](#28-complete-example)
* [29. Quick Syntax Cheat Sheet](#29-quick-syntax-cheat-sheet)
* [30. Common Mistakes](#30-common-mistakes)
* [31. Final Mental Model](#31-final-mental-model)

---

# 1. DBMS Basic Concepts

## What is DBMS?

**DBMS (Database Management System)** is software used to create, store, manage, retrieve and manipulate data in databases.

Examples:

* MySQL
* PostgreSQL
* Oracle Database
* Microsoft SQL Server
* SQLite

---

## Important Terms

### Database

A database is a collection of organized data.

Example:

```text
University
├── Student
├── Course
├── Teacher
└── Department
```

### Table

A table stores data in rows and columns.

Example:

```text
Student
--------------------------------
ID | Name | Department | Age
--------------------------------
1  | Atia | ICE        | 22
2  | Oishi| CSE        | 21
```

### Row / Record

One complete entry in a table is called a **row** or **record**.

```text
1 | Atia | ICE | 22
```

### Column / Attribute

A property/field of a table.

```text
ID
Name
Department
Age
```

### Cell / Value

The intersection of a row and column.

```text
Atia
ICE
22
```

---

# 2. Database Operations

## Create Database

```sql
CREATE DATABASE University;
```

---

## Show Databases

```sql
SHOW DATABASES;
```

---

## Select / Use Database

```sql
USE University;
```

After `USE`, SQL commands normally operate on that database.

---

## Delete Database

```sql
DROP DATABASE University;
```

Safer version:

```sql
DROP DATABASE IF EXISTS University;
```

### ⚠️ Important

`DROP DATABASE` removes:

```text
Database
 ├── Tables
 ├── Data
 ├── Structure
 └── Everything inside
```

---

# 3. Table Operations

## Create Table

```sql
CREATE TABLE Student (
    ID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Age INT
);
```

---

## Show Tables

```sql
SHOW TABLES;
```

---

## Describe Table

```sql
DESCRIBE Student;
```

or:

```sql
DESC Student;
```

---

## Show Complete Table Definition

```sql
SHOW CREATE TABLE Student;
```

This is especially useful for checking:

* Primary Key
* Foreign Key
* Unique constraints
* Check constraints
* Default values
* Column definitions

---

## Delete Table

```sql
DROP TABLE Student;
```

Safer:

```sql
DROP TABLE IF EXISTS Student;
```

### `DROP TABLE`

Deletes:

```text
Table Structure ❌
Table Data      ❌
```

---

# 4. Column Operations

## Add a Column

```sql
ALTER TABLE Student
ADD Phone VARCHAR(15);
```

---

## Add Multiple Columns

```sql
ALTER TABLE Student
ADD Email VARCHAR(100),
ADD Address VARCHAR(150);
```

---

## Rename a Column

```sql
ALTER TABLE Student
RENAME COLUMN Ename TO Name;
```

### Meaning

```text
Ename = old column name
Name  = new column name
```

General syntax:

```sql
ALTER TABLE table_name
RENAME COLUMN old_column_name TO new_column_name;
```

### Example

```sql
ALTER TABLE Student
RENAME COLUMN Student_Name TO Name;
```

---

## Remove a Column

```sql
ALTER TABLE Student
DROP COLUMN Ename;
```

General syntax:

```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

⚠️ This removes the entire column and its values.

---

## Modify Column

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(100);
```

You can use `MODIFY` to change things such as:

* Data type
* NULL/NOT NULL
* Column definition

Example:

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(100) NOT NULL;
```

---

# 5. Data / Record Operations

There are three major operations:

```text
INSERT → Add data
UPDATE → Change data
DELETE → Remove data
```

---

# 6. SELECT Operations

## Select Everything

```sql
SELECT * FROM Student;
```

---

## Select Specific Columns

```sql
SELECT Name, Age
FROM Student;
```

---

## WHERE

```sql
SELECT *
FROM Student
WHERE Age = 22;
```

---

## Comparison Operators

```text
=       Equal
>       Greater than
<       Less than
>=      Greater than or equal
<=      Less than or equal
<>      Not equal
```

Example:

```sql
SELECT *
FROM Student
WHERE Age >= 18;
```

---

## AND

```sql
SELECT *
FROM Student
WHERE Department = 'ICE'
AND Age >= 18;
```

Both conditions must be true.

---

## OR

```sql
SELECT *
FROM Student
WHERE Department = 'ICE'
OR Age = 22;
```

At least one condition must be true.

---

## BETWEEN

```sql
SELECT *
FROM Student
WHERE Age BETWEEN 20 AND 25;
```

---

## IN

```sql
SELECT *
FROM Student
WHERE Department IN ('ICE', 'CSE');
```

---

## IS NULL

```sql
SELECT *
FROM Student
WHERE Department IS NULL;
```

❌ Don't write:

```sql
WHERE Department = NULL;
```

Use:

```sql
IS NULL
```

---

## IS NOT NULL

```sql
SELECT *
FROM Student
WHERE Department IS NOT NULL;
```

---

# 7. INSERT Operations

## Insert One Complete Row

```sql
INSERT INTO Student
VALUES (1, 'Atia', 'ICE', 22);
```

---

## Insert Using Column Names

Recommended:

```sql
INSERT INTO Student (ID, Name, Department, Age)
VALUES (1, 'Atia', 'ICE', 22);
```

---

## Insert Multiple Rows

```sql
INSERT INTO Student (ID, Name, Department, Age)
VALUES
(1, 'Atia', 'ICE', 22),
(2, 'Oishi', 'CSE', 21),
(3, 'Raisa', 'EEE', 23);
```

---

# 8. UPDATE Operations

`UPDATE` is used to change existing data.

## Update One Value

```sql
UPDATE Student
SET Age = 23
WHERE ID = 1;
```

Only ID 1's Age changes.

---

## Update Multiple Columns

```sql
UPDATE Student
SET Name = 'Atia Sanjida',
    Age = 23
WHERE ID = 1;
```

---

## Update Multiple Rows

```sql
UPDATE Student
SET Department = 'ICE'
WHERE Age = 22;
```

Every matching row will be updated.

---

## Remove a Single Cell's Value

If you want to keep the row but remove the value from one column:

```sql
UPDATE Student
SET Department = NULL
WHERE ID = 1;
```

Result:

```text
ID | Name | Department | Age
--------------------------------
1  | Atia | NULL       | 22
```

### Important

`DELETE` removes **rows**.

`UPDATE ... SET column = NULL` removes/clears a **value inside a row**.

---

# 9. DELETE Operations

## Delete One Row

```sql
DELETE FROM Student
WHERE ID = 2;
```

---

## Delete Multiple Rows

```sql
DELETE FROM Student
WHERE Department = 'ICE';
```

---

## Delete Using Conditions

```sql
DELETE FROM Student
WHERE Age > 22;
```

---

## Delete Using AND

```sql
DELETE FROM Student
WHERE Department = 'ICE'
AND Age = 22;
```

---

## Delete Using OR

```sql
DELETE FROM Student
WHERE Department = 'ICE'
OR Age = 23;
```

---

## Delete Using BETWEEN

```sql
DELETE FROM Student
WHERE Age BETWEEN 20 AND 22;
```

---

## Delete Using IN

```sql
DELETE FROM Student
WHERE ID IN (1, 3, 5);
```

---

## Delete NULL Records

```sql
DELETE FROM Student
WHERE Department IS NULL;
```

---

## Delete ALL Rows

```sql
DELETE FROM Student;
```

⚠️ No `WHERE` means **all rows** are deleted.

The table itself remains.

---

# 10. DELETE vs TRUNCATE vs DROP

This is one of the most important DBMS concepts.

| Command         | Rows/Data         | Table Structure | Database |
| --------------- | ----------------- | --------------- | -------- |
| `DELETE`        | Selected/all rows | Remains         | Remains  |
| `TRUNCATE`      | All rows          | Remains         | Remains  |
| `DROP TABLE`    | Deleted           | Deleted         | Remains  |
| `DROP DATABASE` | Deleted           | Deleted         | Deleted  |

---

## DELETE

```sql
DELETE FROM Student
WHERE ID = 2;
```

Can remove selected rows.

---

## DELETE All

```sql
DELETE FROM Student;
```

Removes all rows.

---

## TRUNCATE

```sql
TRUNCATE TABLE Student;
```

Removes all rows while keeping the table structure.

---

## DROP TABLE

```sql
DROP TABLE Student;
```

Removes the complete table.

---

## DROP DATABASE

```sql
DROP DATABASE University;
```

Removes the complete database.

---

# 11. Integrity Constraints

**Integrity constraints** are rules that keep database data accurate, valid and consistent.

Major constraints:

```text
PRIMARY KEY
FOREIGN KEY
UNIQUE
NOT NULL
CHECK
DEFAULT
```

---

# 12. PRIMARY KEY

A Primary Key uniquely identifies each row.

Example:

```sql
CREATE TABLE Student (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);
```

### Primary Key Properties

A Primary Key:

* Must be unique
* Cannot contain NULL
* Identifies each record
* Normally exists once per table
* Can consist of multiple columns

---

## Add Primary Key Externally

If the table was created without a Primary Key:

```sql
ALTER TABLE Student
ADD CONSTRAINT pk_student
PRIMARY KEY (ID);
```

Or:

```sql
ALTER TABLE Student
ADD PRIMARY KEY (ID);
```

### Meaning

```text
ADD
    ↓
Add something

CONSTRAINT
    ↓
Database rule

pk_student
    ↓
Name of the constraint

PRIMARY KEY (ID)
    ↓
ID is the Primary Key
```

`pk_student` is **not a column**.

It is simply the name of the constraint.

---

## Drop Primary Key

```sql
ALTER TABLE Student
DROP PRIMARY KEY;
```

---

# 13. FOREIGN KEY

A Foreign Key creates a relationship between two tables.

Example:

### Parent Table

```sql
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
```

### Child Table

```sql
CREATE TABLE Student (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    DeptID INT
);
```

Now connect them:

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

---

## Understanding the Syntax

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

### `Student`

The table where the Foreign Key is being added.

### `fk_student_department`

The **name of the Foreign Key constraint**.

It is NOT a column.

### `DeptID`

The Foreign Key column in `Student`.

### `Department(DeptID)`

The parent table and referenced column.

Relationship:

```text
Department                    Student
-----------                   -----------
DeptID  <-------------------- DeptID
 PK                             FK
```

---

## Drop Foreign Key

```sql
ALTER TABLE Student
DROP FOREIGN KEY fk_student_department;
```

The Foreign Key constraint is removed, but the `DeptID` column itself remains.

---

# 14. UNIQUE Constraint

A UNIQUE constraint prevents duplicate values.

Example:

```sql
CREATE TABLE Student (
    ID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);
```

---

## Add UNIQUE Externally

```sql
ALTER TABLE Student
ADD CONSTRAINT uq_student_email
UNIQUE (Email);
```

---

## Drop UNIQUE

First check the constraint/index name:

```sql
SHOW CREATE TABLE Student;
```

Then:

```sql
ALTER TABLE Student
DROP INDEX uq_student_email;
```

---

# 15. NOT NULL Constraint

`NOT NULL` means a column cannot contain NULL.

Example:

```sql
CREATE TABLE Student (
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);
```

---

## Add NOT NULL Externally

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(50) NOT NULL;
```

---

## Remove NOT NULL

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(50) NULL;
```

---

# 16. CHECK Constraint

`CHECK` ensures that data satisfies a condition.

Example:

```sql
CREATE TABLE Student (
    ID INT,
    Age INT,
    CHECK (Age >= 18)
);
```

---

## Add CHECK Externally

```sql
ALTER TABLE Student
ADD CONSTRAINT chk_student_age
CHECK (Age >= 18);
```

---

## Drop CHECK

```sql
ALTER TABLE Student
DROP CHECK chk_student_age;
```

Depending on MySQL version, this may also be expressed as:

```sql
ALTER TABLE Student
DROP CONSTRAINT chk_student_age;
```

---

# 17. DEFAULT Constraint

`DEFAULT` provides a value automatically when no value is supplied.

Example:

```sql
CREATE TABLE Student (
    ID INT,
    Department VARCHAR(30) DEFAULT 'ICE'
);
```

If:

```sql
INSERT INTO Student (ID)
VALUES (1);
```

then Department gets the default value.

---

## Add DEFAULT Externally

```sql
ALTER TABLE Student
ALTER Department SET DEFAULT 'ICE';
```

---

## Remove DEFAULT

```sql
ALTER TABLE Student
ALTER Department DROP DEFAULT;
```

---

# 18. ALTER TABLE

`ALTER TABLE` is used to modify an existing table structure.

General pattern:

```sql
ALTER TABLE table_name
operation;
```

Common operations:

```text
ADD
DROP
MODIFY
CHANGE
RENAME
```

---

## Add Column

```sql
ALTER TABLE Student
ADD Phone VARCHAR(15);
```

---

## Drop Column

```sql
ALTER TABLE Student
DROP COLUMN Phone;
```

---

## Modify Column

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(100);
```

---

## Rename Column

```sql
ALTER TABLE Student
RENAME COLUMN Ename TO Name;
```

---

## Rename Table

```sql
RENAME TABLE Student TO Students;
```

---

# 19. Add Constraint Externally

A constraint does not always have to be created during `CREATE TABLE`.

It can be added later using `ALTER TABLE`.

---

## Primary Key

```sql
ALTER TABLE Student
ADD CONSTRAINT pk_student
PRIMARY KEY (ID);
```

---

## Foreign Key

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

---

## UNIQUE

```sql
ALTER TABLE Student
ADD CONSTRAINT uq_student_email
UNIQUE (Email);
```

---

## CHECK

```sql
ALTER TABLE Student
ADD CONSTRAINT chk_student_age
CHECK (Age >= 18);
```

---

## NOT NULL

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(50) NOT NULL;
```

---

## DEFAULT

```sql
ALTER TABLE Student
ALTER Department SET DEFAULT 'ICE';
```

---

# 20. Drop Constraint Externally

## Drop Primary Key

```sql
ALTER TABLE Student
DROP PRIMARY KEY;
```

---

## Drop Foreign Key

```sql
ALTER TABLE Student
DROP FOREIGN KEY fk_student_department;
```

---

## Drop UNIQUE

```sql
ALTER TABLE Student
DROP INDEX uq_student_email;
```

---

## Drop CHECK

```sql
ALTER TABLE Student
DROP CHECK chk_student_age;
```

---

## Remove NOT NULL

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(50) NULL;
```

---

## Remove DEFAULT

```sql
ALTER TABLE Student
ALTER Department DROP DEFAULT;
```

---

# 21. Rename Column

Syntax:

```sql
ALTER TABLE table_name
RENAME COLUMN old_name TO new_name;
```

Example:

```sql
ALTER TABLE Student
RENAME COLUMN Ename TO Name;
```

Meaning:

```text
Old:
Ename

New:
Name
```

### Important

`RENAME COLUMN` changes the **column name**.

It does not delete the data.

---

# 22. Move Column

MySQL allows changing the position of a column.

## Move to First Position

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(50) FIRST;
```

---

## Move After Another Column

```sql
ALTER TABLE Student
MODIFY Age INT AFTER Name;
```

Example:

Before:

```text
ID | Name | Email | Age
```

After:

```text
ID | Name | Age | Email
```

### Important

Moving a column changes its **position**, not its data.

---

# 23. Remove Column

```sql
ALTER TABLE Student
DROP COLUMN Ename;
```

This removes:

```text
Column
+
All values stored in that column
```

It is different from:

```sql
DELETE
```

because `DELETE` removes rows, while `DROP COLUMN` removes a column.

---

# 24. Add Column

```sql
ALTER TABLE Student
ADD Email VARCHAR(100);
```

---

## Add Column at First Position

```sql
ALTER TABLE Student
ADD Email VARCHAR(100) FIRST;
```

---

## Add Column After Another Column

```sql
ALTER TABLE Student
ADD Email VARCHAR(100) AFTER Name;
```

---

# 25. Foreign Key Actions

Foreign Keys can define what happens when a referenced parent record is deleted or updated.

---

## ON DELETE CASCADE

```sql
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID)
ON DELETE CASCADE;
```

Meaning:

```text
Delete Parent
     ↓
Related Child records
     ↓
Automatically deleted
```

Use carefully because deleting one parent record can remove related child records.

---

## ON DELETE SET NULL

```sql
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID)
ON DELETE SET NULL;
```

When the parent is deleted:

```text
Child DeptID → NULL
```

The child row remains.

The Foreign Key column must allow NULL.

---

## ON DELETE RESTRICT

```sql
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID)
ON DELETE RESTRICT;
```

If related child records exist, deletion of the parent is prevented.

---

# 26. Composite Keys

A key can contain multiple columns.

## Composite Primary Key

```sql
ALTER TABLE Student
ADD CONSTRAINT pk_student
PRIMARY KEY (ID, Department);
```

Here:

```text
ID + Department
       ↓
Composite Primary Key
```

The combination is used to uniquely identify a row.

---

## Composite UNIQUE Constraint

```sql
ALTER TABLE Student
ADD CONSTRAINT uq_student
UNIQUE (Name, Department);
```

The combination of `Name + Department` must be unique.

---

# 27. Useful Inspection Commands

## Show Databases

```sql
SHOW DATABASES;
```

---

## Select Database

```sql
USE University;
```

---

## Show Tables

```sql
SHOW TABLES;
```

---

## Describe Table

```sql
DESCRIBE Student;
```

or:

```sql
DESC Student;
```

---

## Show Complete Structure

```sql
SHOW CREATE TABLE Student;
```

This is extremely useful when you need to find:

* Constraint names
* Primary Key
* Foreign Key
* Unique indexes
* Column definitions
* Default values
* Check constraints

---

## Check Current Database

```sql
SELECT DATABASE();
```

---

# 28. Complete Example

Let's build a small database from scratch.

## Step 1 — Create Database

```sql
CREATE DATABASE University;
```

---

## Step 2 — Select Database

```sql
USE University;
```

---

## Step 3 — Create Department

```sql
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
```

---

## Step 4 — Insert Departments

```sql
INSERT INTO Department
VALUES
(1, 'ICE'),
(2, 'CSE'),
(3, 'EEE');
```

---

## Step 5 — Create Student

```sql
CREATE TABLE Student (
    ID INT,
    Name VARCHAR(50),
    Email VARCHAR(100),
    Age INT,
    DeptID INT
);
```

---

## Step 6 — Add Primary Key

```sql
ALTER TABLE Student
ADD CONSTRAINT pk_student
PRIMARY KEY (ID);
```

---

## Step 7 — Add UNIQUE

```sql
ALTER TABLE Student
ADD CONSTRAINT uq_student_email
UNIQUE (Email);
```

---

## Step 8 — Add CHECK

```sql
ALTER TABLE Student
ADD CONSTRAINT chk_student_age
CHECK (Age >= 18);
```

---

## Step 9 — Add Foreign Key

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

---

## Step 10 — Insert Students

```sql
INSERT INTO Student
VALUES
(1, 'Atia', 'atia@example.com', 22, 1),
(2, 'Oishi', 'oishi@example.com', 21, 2),
(3, 'Raisa', 'raisa@example.com', 23, 3);
```

---

## Step 11 — View Data

```sql
SELECT * FROM Student;
```

---

## Step 12 — Update Data

```sql
UPDATE Student
SET Age = 23
WHERE ID = 1;
```

---

## Step 13 — Delete One Row

```sql
DELETE FROM Student
WHERE ID = 2;
```

---

## Step 14 — Inspect Structure

```sql
SHOW CREATE TABLE Student;
```

---

# 29. Quick Syntax Cheat Sheet

## DATABASE

```sql
CREATE DATABASE db_name;

SHOW DATABASES;

USE db_name;

DROP DATABASE db_name;
```

---

## TABLE

```sql
CREATE TABLE table_name (...);

SHOW TABLES;

DESCRIBE table_name;

DROP TABLE table_name;

TRUNCATE TABLE table_name;
```

---

## INSERT

```sql
INSERT INTO table_name
VALUES (...);
```

```sql
INSERT INTO table_name (col1, col2)
VALUES (value1, value2);
```

---

## SELECT

```sql
SELECT * FROM table_name;
```

```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```

---

## UPDATE

```sql
UPDATE table_name
SET column = value
WHERE condition;
```

---

## DELETE

```sql
DELETE FROM table_name
WHERE condition;
```

---

## ADD COLUMN

```sql
ALTER TABLE table_name
ADD column_name datatype;
```

---

## DROP COLUMN

```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

---

## RENAME COLUMN

```sql
ALTER TABLE table_name
RENAME COLUMN old_name TO new_name;
```

---

## MODIFY COLUMN

```sql
ALTER TABLE table_name
MODIFY column_name datatype;
```

---

## PRIMARY KEY

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
PRIMARY KEY (column_name);
```

Drop:

```sql
ALTER TABLE table_name
DROP PRIMARY KEY;
```

---

## FOREIGN KEY

```sql
ALTER TABLE child_table
ADD CONSTRAINT constraint_name
FOREIGN KEY (child_column)
REFERENCES parent_table(parent_column);
```

Drop:

```sql
ALTER TABLE child_table
DROP FOREIGN KEY constraint_name;
```

---

## UNIQUE

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
UNIQUE (column_name);
```

Drop:

```sql
ALTER TABLE table_name
DROP INDEX constraint_name;
```

---

## CHECK

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
CHECK (condition);
```

Drop:

```sql
ALTER TABLE table_name
DROP CHECK constraint_name;
```

---

## NOT NULL

Add:

```sql
ALTER TABLE table_name
MODIFY column_name datatype NOT NULL;
```

Remove:

```sql
ALTER TABLE table_name
MODIFY column_name datatype NULL;
```

---

## DEFAULT

Add:

```sql
ALTER TABLE table_name
ALTER column_name SET DEFAULT value;
```

Remove:

```sql
ALTER TABLE table_name
ALTER column_name DROP DEFAULT;
```

---

# 30. Common Mistakes

## ❌ Mistake 1 — Forgetting WHERE

Never blindly run:

```sql
DELETE FROM Student;
```

unless you actually want to delete every row.

Similarly:

```sql
UPDATE Student
SET Age = 20;
```

updates every row.

Safer:

```sql
UPDATE Student
SET Age = 20
WHERE ID = 1;
```

---

## ❌ Mistake 2 — Confusing DELETE and DROP

```sql
DELETE
```

removes rows.

```sql
DROP COLUMN
```

removes a column.

```sql
DROP TABLE
```

removes the table.

```sql
DROP DATABASE
```

removes the database.

---

## ❌ Mistake 3 — Confusing Constraint Name and Column Name

In:

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

```text
fk_student_department
        ↓
Constraint name

DeptID
        ↓
Column name
```

`fk_student_department` is **not a column**.

---

## ❌ Mistake 4 — Using `= NULL`

Wrong:

```sql
WHERE Department = NULL;
```

Correct:

```sql
WHERE Department IS NULL;
```

---

## ❌ Mistake 5 — Dropping Foreign Key vs Column

This:

```sql
ALTER TABLE Student
DROP FOREIGN KEY fk_student_department;
```

removes the **Foreign Key constraint**.

It does NOT remove:

```text
DeptID column
```

To remove the column:

```sql
ALTER TABLE Student
DROP COLUMN DeptID;
```

---

## ❌ Mistake 6 — Thinking RENAME Deletes Data

```sql
ALTER TABLE Student
RENAME COLUMN Ename TO Name;
```

does not delete the values.

It only changes:

```text
Ename → Name
```

---

# 31. Final Mental Model

The easiest way to remember SQL operations is to think about **what exactly you want to remove/change**.

```text
                    DATABASE
                       │
              ┌────────┴────────┐
              │                 │
            TABLES            Data
              │                 │
       ┌──────┴──────┐          │
       │             │          │
    Columns        Rows        Values
       │             │          │
       │             │          │
       ↓             ↓          ↓
  DROP COLUMN     DELETE      UPDATE
                                SET NULL
```

### If you want to...

| You want to...           | Use                              |
| ------------------------ | -------------------------------- |
| Create database          | `CREATE DATABASE`                |
| Delete database          | `DROP DATABASE`                  |
| Create table             | `CREATE TABLE`                   |
| Delete table             | `DROP TABLE`                     |
| Delete all table data    | `TRUNCATE`                       |
| Delete selected rows     | `DELETE ... WHERE`               |
| Delete all rows          | `DELETE FROM table`              |
| Change a value           | `UPDATE`                         |
| Clear one value          | `UPDATE ... SET column = NULL`   |
| Add column               | `ALTER TABLE ... ADD`            |
| Remove column            | `ALTER TABLE ... DROP COLUMN`    |
| Rename column            | `RENAME COLUMN`                  |
| Move column              | `MODIFY ... FIRST/AFTER`         |
| Change column definition | `MODIFY`                         |
| Add Primary Key          | `ADD PRIMARY KEY`                |
| Remove Primary Key       | `DROP PRIMARY KEY`               |
| Add Foreign Key          | `ADD CONSTRAINT ... FOREIGN KEY` |
| Remove Foreign Key       | `DROP FOREIGN KEY`               |
| Add UNIQUE               | `ADD CONSTRAINT ... UNIQUE`      |
| Remove UNIQUE            | `DROP INDEX`                     |
| Add NOT NULL             | `MODIFY ... NOT NULL`            |
| Remove NOT NULL          | `MODIFY ... NULL`                |
| Add CHECK                | `ADD CONSTRAINT ... CHECK`       |
| Remove CHECK             | `DROP CHECK`                     |
| Add DEFAULT              | `SET DEFAULT`                    |
| Remove DEFAULT           | `DROP DEFAULT`                   |
| See table structure      | `DESCRIBE`                       |
| See complete constraints | `SHOW CREATE TABLE`              |

---

# 🧠 One-Minute Revision

```text
DATABASE
   CREATE → DROP

TABLE
   CREATE → ALTER → TRUNCATE → DROP

COLUMN
   ADD → MODIFY → RENAME → MOVE → DROP

DATA
   INSERT → SELECT → UPDATE → DELETE

CONSTRAINTS
   PRIMARY KEY
   FOREIGN KEY
   UNIQUE
   NOT NULL
   CHECK
   DEFAULT

KEY OPERATIONS
   ADD CONSTRAINT
   DROP CONSTRAINT / DROP FOREIGN KEY / DROP PRIMARY KEY
```

---

# ⭐ Golden Rule

Before executing a destructive command, ask:

> **"Am I deleting a database, a table, a column, a row, or only a value?"**

Because:

```text
DROP DATABASE → Database disappears

DROP TABLE → Table disappears

DROP COLUMN → Column disappears

DELETE → Row disappears

UPDATE ... SET NULL → Value disappears

TRUNCATE → All rows disappear, table remains
```

Once you understand **what level of the database hierarchy you are modifying**, most SQL DELETE/ALTER/constraint questions become straightforward.

---

## 🚀 Recommended Practice Order

Practice SQL in this order:

```text
1. CREATE DATABASE
       ↓
2. USE DATABASE
       ↓
3. CREATE TABLE
       ↓
4. INSERT
       ↓
5. SELECT
       ↓
6. UPDATE
       ↓
7. DELETE
       ↓
8. ALTER TABLE
       ↓
9. ADD / DROP COLUMN
       ↓
10. PRIMARY KEY
       ↓
11. FOREIGN KEY
       ↓
12. UNIQUE
       ↓
13. NOT NULL
       ↓
14. CHECK
       ↓
15. DEFAULT
       ↓
16. TRUNCATE
       ↓
17. DROP
```

> **This sequence gives you a strong foundation for SQL/DBMS laboratory work, exams, and practical database design.**
