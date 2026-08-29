# 🗄️ DBMS Lab — ALTER TABLE, PRIMARY KEY & FOREIGN KEY

<p align="center">
  <b>Database Management System Lab</b><br>
  MySQL • ALTER TABLE • Constraints • Relationships
</p>

---


# 📌 Table of Contents

1. [Introduction](#-introduction)
2. [Database Overview](#-database-overview)
3. [Database Visualization](#-database-visualization)
4. [Table Structure](#-table-structure)
5. [Understanding Primary Key](#-understanding-primary-key)
6. [Understanding Foreign Key](#-understanding-foreign-key)
7. [Primary Key vs Foreign Key](#-primary-key-vs-foreign-key)
8. [Common ALTER TABLE Syntax](#-common-alter-table-syntax)
9. [Create Primary Key](#1-create-primary-key)
10. [Check Primary Key](#2-check-primary-key)
11. [Add Foreign Key Columns](#3-add-foreign-key-columns)
12. [Create Foreign Key](#4-create-foreign-key)
13. [Check Foreign Key](#5-check-foreign-key)
14. [Drop Foreign Key](#6-drop-foreign-key)
15. [Drop Primary Key](#7-drop-primary-key)
16. [Composite Primary Key](#8-composite-primary-key)
17. [Rename Table](#9-rename-table)
18. [Rename Column](#10-rename-column)
19. [Add Column](#11-add-column)
20. [Set Default Value](#12-set-default-value)
21. [Insert Data](#13-insert-data)
22. [Update Data](#14-update-data)
23. [Delete Data](#15-delete-data)
24. [Drop Order of Constraints](#-correct-order-for-dropping-constraints)
25. [Complete Practical Example](#-complete-practical-example)
26. [Useful MySQL Commands](#-useful-mysql-commands)
27. [Common Errors](#-common-errors)
28. [Quick Cheat Sheet](#-quick-cheat-sheet)
29. [Conclusion](#-conclusion)

---

# 🎯 Introduction

This lab focuses on practicing the `ALTER TABLE` command in MySQL.

The main objectives are:

* Add Primary Key constraints.
* Add Composite Primary Keys.
* Add Foreign Key constraints.
* Check existing Primary and Foreign Keys.
* Drop Foreign Key constraints.
* Drop Primary Key constraints.
* Add and remove columns.
* Rename tables.
* Rename columns.
* Set default values.
* Insert, update and delete records.
* Understand relationships between database tables.

---

# 🗃️ Database Overview

For this lab, we work with three main tables:

```text
                    DATABASE
                       │
          ┌────────────┼────────────┐
          │            │            │
          ▼            ▼            ▼
       ┌──────┐    ┌────────┐   ┌─────────┐
       │ HALL │    │ COURSE │   │ STUDENT │
       └──────┘    └────────┘   └─────────┘
```

The three tables represent:

| Table     | Purpose                    |
| --------- | -------------------------- |
| `HALL`    | Stores hall information    |
| `COURSE`  | Stores course information  |
| `STUDENT` | Stores student information |

---

# 🧩 Database Visualization

The complete relationship between the tables can be visualized as follows:

```text
                         ┌─────────────────────────┐
                         │          HALL           │
                         ├─────────────────────────┤
                         │ PK  STD_HALL_ID         │
                         │     HALL_NAME           │
                         │     HALL_CLEARENCE      │
                         └────────────┬────────────┘
                                      │
                                      │ 1
                                      │
                                      │
                                      │ N
                         ┌────────────▼────────────┐
                         │        STUDENT          │
                         ├─────────────────────────┤
                         │ PK  STUDENT_ID          │
                         │     STUDENT_NAME        │
                         │ FK  HALL_ID             │
                         │ FK  COURSE_ID           │
                         └────────────┬────────────┘
                                      │
                                      │ N
                                      │
                                      │ 1
                         ┌────────────▼────────────┐
                         │         COURSE          │
                         ├─────────────────────────┤
                         │ PK  COURSE_ID           │
                         │     COURSE_CODE         │
                         │     COURSE_NAME         │
                         └─────────────────────────┘
```

### Relationship Explanation

```text
STUDENT.HALL_ID
       │
       │ FOREIGN KEY
       ▼
HALL.STD_HALL_ID
       │
       │ PRIMARY KEY
       ▼
HALL
```

And:

```text
STUDENT.COURSE_ID
       │
       │ FOREIGN KEY
       ▼
COURSE.COURSE_ID
       │
       │ PRIMARY KEY
       ▼
COURSE
```

### Relationship Summary

```text
HALL
  │
  │  STD_HALL_ID
  │       ▲
  │       │
  │       │ FK
  ▼       │
STUDENT ──┘
  │
  │ COURSE_ID
  │       ▲
  │       │
  │       │ FK
  ▼       │
COURSE ───┘
```

---

# 🏗️ Table Structure

## 1. HALL Table

```text
┌─────────────────────────────────┐
│              HALL               │
├─────────────────────────────────┤
│ PK  STD_HALL_ID    INT          │
│     HALL_NAME      VARCHAR(50)  │
│     HALL_CLEARENCE INT          │
└─────────────────────────────────┘
```

Example:

| STD_HALL_ID | HALL_NAME        | HALL_CLEARENCE |
| ----------: | ---------------- | -------------: |
|           1 | Bonolota Hall    |              1 |
|           2 | Bangabandhu Hall |              1 |
|           3 | Shaheed Hall     |              1 |

---

## 2. COURSE Table

```text
┌─────────────────────────────────┐
│             COURSE              │
├─────────────────────────────────┤
│ PK  COURSE_ID      INT          │
│     COURSE_CODE    VARCHAR(10)  │
│     COURSE_NAME    VARCHAR(50)  │
└─────────────────────────────────┘
```

Example:

| COURSE_ID | COURSE_CODE | COURSE_NAME |
| --------: | ----------- | ----------- |
|       101 | ICT3112     | DBMS Lab    |
|       102 | ICE2214     | Signals Lab |
|       103 | ICT3111     | DBMS        |

---

## 3. STUDENT Table

```text
┌─────────────────────────────────┐
│            STUDENT              │
├─────────────────────────────────┤
│ PK  STUDENT_ID     INT          │
│     STUDENT_NAME   VARCHAR(50)  │
│ FK  HALL_ID        INT          │
│ FK  COURSE_ID      INT          │
└─────────────────────────────────┘
```

Example:

| STUDENT_ID | STUDENT_NAME  | HALL_ID | COURSE_ID |
| ---------: | ------------- | ------: | --------: |
|        101 | Atia Sanjida  |       1 |       101 |
|        102 | Tiana Ashrafi |       2 |       102 |
|        103 | Raisa         |       3 |       103 |

---

# 🔑 Understanding Primary Key

A **Primary Key (PK)** uniquely identifies every record in a table.

### Properties

* Cannot contain duplicate values.
* Cannot contain `NULL`.
* A table can have only one Primary Key constraint.
* It can contain one or multiple columns.

Example:

```text
STUDENT
┌─────────────┬──────────────┐
│ STUDENT_ID  │ STUDENT_NAME │
├─────────────┼──────────────┤
│ 101         │ Atia         │
│ 102         │ Tiana        │
│ 103         │ Raisa        │
└─────────────┴──────────────┘
      ↑
      │
  PRIMARY KEY
```

Here, `STUDENT_ID` uniquely identifies each student.

---

# 🔗 Understanding Foreign Key

A **Foreign Key (FK)** creates a relationship between two tables.

The Foreign Key is usually placed in the **child table** and references a Primary Key or suitable `UNIQUE` key in the **parent table**.

Example:

```text
PARENT TABLE
HALL
┌──────────────────┐
│ PK STD_HALL_ID   │
├──────────────────┤
│ 1                │
│ 2                │
│ 3                │
└────────┬─────────┘
         │
         │ referenced by
         │
         ▼
CHILD TABLE
STUDENT
┌──────────────────┐
│ FK HALL_ID       │
├──────────────────┤
│ 1                │
│ 2                │
│ 3                │
└──────────────────┘
```

Therefore:

```text
STUDENT.HALL_ID
       │
       │ REFERENCES
       ▼
HALL.STD_HALL_ID
```

---

# ⚖️ Primary Key vs Foreign Key

| Feature                  | Primary Key                  | Foreign Key                              |
| ------------------------ | ---------------------------- | ---------------------------------------- |
| Purpose                  | Uniquely identifies a record | Creates relationship                     |
| Duplicate values         | ❌ Not allowed                | ✅ Usually allowed                        |
| NULL                     | ❌ Not allowed                | ✅ Can be allowed depending on definition |
| Number per table         | One PK constraint            | Multiple FKs possible                    |
| References another table | No                           | Yes                                      |
| Example                  | `HALL.STD_HALL_ID`           | `STUDENT.HALL_ID`                        |

---

# 🛠️ Common ALTER TABLE Syntax

## Add Column

```sql
ALTER TABLE table_name
ADD COLUMN column_name datatype;
```

---

## Drop Column

```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

---

## Add Primary Key

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
PRIMARY KEY (column_name);
```

---

## Add Composite Primary Key

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
PRIMARY KEY (column1, column2);
```

---

## Drop Primary Key

```sql
ALTER TABLE table_name
DROP PRIMARY KEY;
```

---

## Add Foreign Key

```sql
ALTER TABLE child_table
ADD CONSTRAINT constraint_name
FOREIGN KEY (child_column)
REFERENCES parent_table(parent_column);
```

---

## Drop Foreign Key

```sql
ALTER TABLE table_name
DROP FOREIGN KEY constraint_name;
```

---

## Rename Table

```sql
ALTER TABLE old_table
RENAME TO new_table;
```

---

## Rename Column

```sql
ALTER TABLE table_name
RENAME COLUMN old_column TO new_column;
```

---

## Set Default Value

```sql
ALTER TABLE table_name
ALTER COLUMN column_name SET DEFAULT value;
```

---

# 1️⃣ Create Primary Key

If `STUDENT_ID` is not a Primary Key:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_ID
PRIMARY KEY (STUDENT_ID);
```

### Course

```sql
ALTER TABLE COURSE
ADD CONSTRAINT PK_COURSE_ID
PRIMARY KEY (COURSE_ID);
```

### Hall

```sql
ALTER TABLE HALL
ADD CONSTRAINT PK_HALL_ID
PRIMARY KEY (STD_HALL_ID);
```

---

# 2️⃣ Check Primary Key

Use:

```sql
DESC STUDENT;
```

Example:

```text
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| STUDENT_ID  | int         | NO   | PRI | NULL    |       |
| STUDENT_NAME| varchar(50) | YES  |     | NULL    |       |
| HALL_ID     | int         | YES  | MUL | NULL    |       |
| COURSE_ID   | int         | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+
```

### Meaning of `Key`

```text
PRI → Primary Key
MUL → Column has a non-unique index / may be associated with a Foreign Key
UNI → Unique Key
```

For complete details:

```sql
SHOW CREATE TABLE STUDENT\G
```

---

# 3️⃣ Add Foreign Key Columns

First, the required columns must exist in the child table.

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT,
ADD COLUMN COURSE_ID INT;
```

Or separately:

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT;
```

```sql
ALTER TABLE STUDENT
ADD COLUMN COURSE_ID INT;
```

---

# 4️⃣ Create Foreign Key

## Student → Hall

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_HALL
FOREIGN KEY (HALL_ID)
REFERENCES HALL(STD_HALL_ID);
```

Visualization:

```text
HALL
┌──────────────────┐
│ PK STD_HALL_ID   │
└────────┬─────────┘
         │
         │ REFERENCES
         │
         ▼
STUDENT
┌──────────────────┐
│ FK HALL_ID       │
└──────────────────┘
```

---

## Student → Course

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_COURSE
FOREIGN KEY (COURSE_ID)
REFERENCES COURSE(COURSE_ID);
```

Visualization:

```text
COURSE
┌──────────────────┐
│ PK COURSE_ID     │
└────────┬─────────┘
         │
         │ REFERENCES
         │
         ▼
STUDENT
┌──────────────────┐
│ FK COURSE_ID     │
└──────────────────┘
```

---

# 5️⃣ Check Foreign Key

## Recommended Method

```sql
SHOW CREATE TABLE STUDENT\G
```

Example output:

```text
CONSTRAINT `FK_STUDENT_HALL`
FOREIGN KEY (`HALL_ID`)
REFERENCES `HALL` (`STD_HALL_ID`)
```

This confirms that the Foreign Key exists.

---

## Using `information_schema`

```sql
SELECT
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'STUDENT'
AND REFERENCED_TABLE_NAME IS NOT NULL;
```

If the query returns a Foreign Key record, the table has a Foreign Key.

---

# 6️⃣ Drop Foreign Key

Suppose the Foreign Key is:

```text
FK_STUDENT_HALL
```

Use:

```sql
ALTER TABLE STUDENT
DROP FOREIGN KEY FK_STUDENT_HALL;
```

For Course:

```sql
ALTER TABLE STUDENT
DROP FOREIGN KEY FK_STUDENT_COURSE;
```

### Important

Dropping the Foreign Key does **not** remove the column.

For example:

```sql
ALTER TABLE STUDENT
DROP FOREIGN KEY FK_STUDENT_HALL;
```

After this:

```text
HALL_ID
```

still exists.

Only the relationship is removed.

---

# 7️⃣ Drop Primary Key

To drop the Primary Key:

```sql
ALTER TABLE STUDENT
DROP PRIMARY KEY;
```

For Course:

```sql
ALTER TABLE COURSE
DROP PRIMARY KEY;
```

For Hall:

```sql
ALTER TABLE HALL
DROP PRIMARY KEY;
```

---

# ⚠️ Correct Order for Dropping Constraints

This is extremely important.

Suppose:

```text
HALL
┌──────────────────┐
│ PK STD_HALL_ID   │
└────────┬─────────┘
         │
         │ referenced by FK
         ▼
STUDENT
┌──────────────────┐
│ FK HALL_ID       │
└──────────────────┘
```

The Foreign Key depends on the referenced key.

Therefore:

### ❌ Do not do this first

```sql
ALTER TABLE HALL
DROP PRIMARY KEY;
```

if `STUDENT.HALL_ID` still references it.

### ✅ Correct process

### Step 1 — Drop Foreign Key

```sql
ALTER TABLE STUDENT
DROP FOREIGN KEY FK_STUDENT_HALL;
```

### Step 2 — Drop Primary Key

```sql
ALTER TABLE HALL
DROP PRIMARY KEY;
```

### Memory Trick

```text
CREATE:

PRIMARY KEY
     ↓
FOREIGN KEY


DROP:

FOREIGN KEY
     ↓
PRIMARY KEY
```

### In one line:

> **Create PK first → Create FK later → Drop FK first → Drop PK later**

---

# 8️⃣ Composite Primary Key

A Composite Primary Key consists of two or more columns.

Example:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_COMPOSITE
PRIMARY KEY (STUDENT_ID, STUDENT_NAME);
```

Visualization:

```text
┌──────────────────────────────┐
│           STUDENT            │
├──────────────────────────────┤
│ PK  STUDENT_ID              │
│ PK  STUDENT_NAME            │
│     HALL_ID                 │
│     COURSE_ID               │
└──────────────────────────────┘

        Combined Primary Key
               ↓
   (STUDENT_ID, STUDENT_NAME)
```

Before creating a new Primary Key, an existing Primary Key must normally be removed:

```sql
ALTER TABLE STUDENT
DROP PRIMARY KEY;
```

Then:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_COMPOSITE
PRIMARY KEY (STUDENT_ID, STUDENT_NAME);
```

---

# 9️⃣ Rename Table

General syntax:

```sql
ALTER TABLE old_table
RENAME TO new_table;
```

Example:

```sql
ALTER TABLE STUDENT_INFO
RENAME TO STUDENT;
```

Before:

```text
STUDENT_INFO
```

After:

```text
STUDENT
```

---

# 🔟 Rename Column

General syntax:

```sql
ALTER TABLE table_name
RENAME COLUMN old_column TO new_column;
```

Example:

```sql
ALTER TABLE HALL
RENAME COLUMN HALL_ID TO STD_HALL_ID;
```

Before:

```text
HALL_ID
```

After:

```text
STD_HALL_ID
```

---

# 1️⃣1️⃣ Add Column

General syntax:

```sql
ALTER TABLE table_name
ADD COLUMN column_name datatype;
```

Example:

```sql
ALTER TABLE HALL
ADD COLUMN HALL_CLEARENCE INT;
```

Student:

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT;
```

---

# 1️⃣2️⃣ Set Default Value

Suppose:

```text
HALL_CLEARENCE
```

is an integer column.

Set its default value to `1`:

```sql
ALTER TABLE HALL
ALTER COLUMN HALL_CLEARENCE SET DEFAULT 1;
```

Check it:

```sql
DESC HALL;
```

Expected:

```text
| HALL_CLEARENCE | int | YES | | 1 | |
```

---

# 1️⃣3️⃣ Insert Data

General syntax:

```sql
INSERT INTO table_name
(column1, column2)
VALUES
(value1, value2);
```

### Insert Hall Data

```sql
INSERT INTO HALL
(STD_HALL_ID, HALL_NAME)
VALUES
(1, 'Bonolota Hall'),
(2, 'Bangabandhu Hall'),
(3, 'Shaheed Hall');
```

### Insert Course Data

```sql
INSERT INTO COURSE
(COURSE_ID, COURSE_CODE, COURSE_NAME)
VALUES
(101, 'ICT3112', 'DBMS Lab'),
(102, 'ICE2214', 'Signals Lab'),
(103, 'ICT3111', 'DBMS');
```

### Insert Student Data

```sql
INSERT INTO STUDENT
(STUDENT_ID, STUDENT_NAME, HALL_ID, COURSE_ID)
VALUES
(1001, 'Atia Sanjida', 1, 101),
(1002, 'Tiana Ashrafi', 2, 102),
(1003, 'Raisa', 3, 103);
```

Check:

```sql
SELECT * FROM HALL;
```

```sql
SELECT * FROM COURSE;
```

```sql
SELECT * FROM STUDENT;
```

---

# 1️⃣4️⃣ Update Data

General syntax:

```sql
UPDATE table_name
SET column_name = value
WHERE condition;
```

Example:

```sql
UPDATE STUDENT
SET STUDENT_NAME = 'Atia'
WHERE STUDENT_ID = 1001;
```

Check:

```sql
SELECT * FROM STUDENT;
```

> ⚠️ Always use a suitable `WHERE` condition when you only want to modify specific records.

---

# 1️⃣5️⃣ Delete Data

General syntax:

```sql
DELETE FROM table_name
WHERE condition;
```

Example:

```sql
DELETE FROM STUDENT
WHERE STUDENT_ID = 1003;
```

Check:

```sql
SELECT * FROM STUDENT;
```

> ⚠️ Without `WHERE`, `DELETE` can remove all records from the table.

---

# 🧪 Complete Practical Example

The following example demonstrates the complete relationship.

---

## Step 1 — HALL Table

```text
┌──────────────────────────────┐
│             HALL             │
├──────────────────────────────┤
│ PK  STD_HALL_ID   INT        │
│     HALL_NAME     VARCHAR(50)│
│     HALL_CLEARENCE INT       │
└──────────────────────────────┘
```

Create Primary Key:

```sql
ALTER TABLE HALL
ADD CONSTRAINT PK_HALL_ID
PRIMARY KEY (STD_HALL_ID);
```

---

## Step 2 — COURSE Table

```text
┌──────────────────────────────┐
│            COURSE            │
├──────────────────────────────┤
│ PK  COURSE_ID     INT        │
│     COURSE_CODE   VARCHAR(10)│
│     COURSE_NAME   VARCHAR(50)│
└──────────────────────────────┘
```

Create Primary Key:

```sql
ALTER TABLE COURSE
ADD CONSTRAINT PK_COURSE_ID
PRIMARY KEY (COURSE_ID);
```

---

## Step 3 — STUDENT Table

```text
┌──────────────────────────────┐
│           STUDENT            │
├──────────────────────────────┤
│ PK  STUDENT_ID    INT        │
│     STUDENT_NAME  VARCHAR(50)│
│ FK  HALL_ID       INT        │
│ FK  COURSE_ID     INT        │
└──────────────────────────────┘
```

Create Primary Key:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_ID
PRIMARY KEY (STUDENT_ID);
```

---

## Step 4 — Add Foreign Key Columns

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT,
ADD COLUMN COURSE_ID INT;
```

---

## Step 5 — Create Hall Foreign Key

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_HALL
FOREIGN KEY (HALL_ID)
REFERENCES HALL(STD_HALL_ID);
```

---

## Step 6 — Create Course Foreign Key

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_COURSE
FOREIGN KEY (COURSE_ID)
REFERENCES COURSE(COURSE_ID);
```

---

# 🔗 Final Relationship Diagram

```text
                    ┌───────────────────────┐
                    │         HALL          │
                    ├───────────────────────┤
                    │ PK STD_HALL_ID        │
                    │    HALL_NAME          │
                    │    HALL_CLEARENCE     │
                    └───────────┬───────────┘
                                │
                                │ 1
                                │
                                │ N
                    ┌───────────▼───────────┐
                    │        STUDENT        │
                    ├───────────────────────┤
                    │ PK STUDENT_ID         │
                    │    STUDENT_NAME       │
                    │ FK HALL_ID            │
                    │ FK COURSE_ID          │
                    └───────────┬───────────┘
                                │
                                │ N
                                │
                                │ 1
                    ┌───────────▼───────────┐
                    │        COURSE         │
                    ├───────────────────────┤
                    │ PK COURSE_ID          │
                    │    COURSE_CODE        │
                    │    COURSE_NAME        │
                    └───────────────────────┘
```

---

# 🔍 Useful MySQL Commands

## Show Databases

```sql
SHOW DATABASES;
```

---

## Create Database

```sql
CREATE DATABASE LAB4;
```

---

## Select Database

```sql
USE LAB4;
```

> ❌ Incorrect:

```sql
USE DATABASE LAB4;
```

> ✅ Correct:

```sql
USE LAB4;
```

---

## Show Tables

```sql
SHOW TABLES;
```

---

## Describe Table

```sql
DESC STUDENT;
```

or:

```sql
DESCRIBE STUDENT;
```

---

## Show Complete Table Definition

```sql
SHOW CREATE TABLE STUDENT\G
```

This is especially useful for checking:

* Primary Keys
* Foreign Keys
* Constraint names
* Referenced tables
* Referenced columns
* Indexes

---

## Show Table Data

```sql
SELECT * FROM STUDENT;
```

---

# ⚠️ Common Errors

## Error 1 — Table Does Not Exist

```text
ERROR 1146:
Table 'hall.student' doesn't exist
```

### Cause

You are using:

```sql
ALTER TABLE STUDENT ...
```

but the current database does not contain a table named `STUDENT`.

### Check:

```sql
SELECT DATABASE();
```

```sql
SHOW TABLES;
```

---

# Error 2 — Foreign Key Column Does Not Exist

```text
ERROR 1072:
Key column 'HALL_ID' doesn't exist in table
```

### Cause

`HALL_ID` has not been added to the Student table.

### Solution

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT;
```

---

# Error 3 — Missing Unique Key in Referenced Table

Example:

```text
ERROR 6125:
Missing unique key for constraint
```

### Cause

The referenced column in the parent table is not a Primary Key or suitable `UNIQUE` key.

### Solution

For example:

```sql
ALTER TABLE HALL
ADD CONSTRAINT PK_HALL_ID
PRIMARY KEY (STD_HALL_ID);
```

Then create the Foreign Key:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_HALL
FOREIGN KEY (HALL_ID)
REFERENCES HALL(STD_HALL_ID);
```

---

# Error 4 — Incorrect Foreign Key Syntax

### ❌ Incorrect

```sql
REFERENCES(COURSE_ID);
```

### ✅ Correct

```sql
REFERENCES COURSE(COURSE_ID);
```

The referenced **table name must be specified**.

---

# Error 5 — Incorrect ADD COLUMN Syntax

### ❌ Incorrect

```sql
ALTER TABLE STUDENT
ADD COLUMN COURSE_ID,
ADD COLUMN HALL_ID;
```

### ✅ Correct

```sql
ALTER TABLE STUDENT
ADD COLUMN COURSE_ID INT,
ADD COLUMN HALL_ID INT;
```

A datatype is required.

---

# Error 6 — Incorrect DEFAULT Syntax

### ❌ Incorrect

```sql
ALTER TABLE HALL
ALTER COLUMN HALL_CLEARENCE
SET SET DEFAULT = 1;
```

### ✅ Correct

```sql
ALTER TABLE HALL
ALTER COLUMN HALL_CLEARENCE
SET DEFAULT 1;
```

---

# Error 7 — Wrong Column Name

Suppose the actual column is:

```text
HALL_CLEAREMCE
```

but you try:

```sql
DROP COLUMN HALL_CLEARANCE;
```

MySQL will report that the column does not exist.

Always check:

```sql
DESC HALL;
```

before modifying a column.

---

# 🧠 Constraint Dependency

Understanding dependency is essential.

```text
                 HALL
                  │
                  │
          PK STD_HALL_ID
                  │
                  │
                  ▼
              STUDENT
                  │
              FK HALL_ID
```

The Foreign Key depends on the referenced key.

Therefore:

```text
                    CREATE
                      │
                      ▼
              ┌───────────────┐
              │ PRIMARY KEY   │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ FOREIGN KEY   │
              └───────────────┘


                     DROP
                      │
                      ▼
              ┌───────────────┐
              │ FOREIGN KEY   │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │ PRIMARY KEY   │
              └───────────────┘
```

### ⭐ Golden Rule

> **Create Parent Primary Key → Create Child Foreign Key**

> **Drop Child Foreign Key → Drop Parent Primary Key**

---

# 📋 Quick Cheat Sheet

| Operation        | Syntax                               |
| ---------------- | ------------------------------------ |
| Add PK           | `ADD CONSTRAINT ... PRIMARY KEY`     |
| Add Composite PK | `PRIMARY KEY (col1, col2)`           |
| Check PK         | `DESC table_name;`                   |
| Add Column       | `ADD COLUMN column datatype`         |
| Add FK           | `FOREIGN KEY (...) REFERENCES ...`   |
| Check FK         | `SHOW CREATE TABLE table_name\G`     |
| Drop FK          | `DROP FOREIGN KEY constraint_name`   |
| Drop PK          | `DROP PRIMARY KEY`                   |
| Rename Table     | `RENAME TO new_table`                |
| Rename Column    | `RENAME COLUMN old TO new`           |
| Set Default      | `ALTER COLUMN col SET DEFAULT value` |
| Insert           | `INSERT INTO ... VALUES ...`         |
| Update           | `UPDATE ... SET ... WHERE ...`       |
| Delete           | `DELETE FROM ... WHERE ...`          |
| Show Tables      | `SHOW TABLES;`                       |
| Describe         | `DESC table_name;`                   |

---

# 📝 Complete Workflow

For a new database relationship, follow this order:

```text
              START
                │
                ▼
        Create / Select Database
                │
                ▼
           Create Tables
                │
                ▼
       Create Parent Primary Keys
                │
                ▼
       Create Child Primary Key
                │
                ▼
       Add Foreign Key Columns
                │
                ▼
         Create Foreign Keys
                │
                ▼
          Insert Parent Data
                │
                ▼
          Insert Child Data
                │
                ▼
       Check Table & Constraints
                │
                ▼
              DONE
```

When removing constraints:

```text
              START
                │
                ▼
       Check Foreign Keys
                │
                ▼
        Drop Foreign Keys
                │
                ▼
        Drop Primary Keys
                │
                ▼
              DONE
```

---

# 🎓 Lab Learning Summary

After completing this practice, the following concepts should be clear:

### ALTER TABLE

Used to modify the structure of an existing table.

### PRIMARY KEY

Used to uniquely identify records.

### COMPOSITE PRIMARY KEY

Uses multiple columns together as a Primary Key.

### FOREIGN KEY

Creates a relationship between tables.

### CONSTRAINT

Defines rules that control data integrity.

### `DESC`

Used to inspect the table structure.

### `SHOW CREATE TABLE`

Used to inspect the complete table definition, including constraints.

---

# ✅ Conclusion

The `ALTER TABLE` command provides a powerful way to modify existing database structures without recreating the tables.

Through this lab, the practical implementation of:

* Primary Key
* Composite Primary Key
* Foreign Key
* Constraint creation
* Constraint deletion
* Column addition
* Column renaming
* Table renaming
* Default values
* Data insertion
* Data updating
* Data deletion
* Table inspection
* Table relationships

has been practiced using MySQL.

The most important relationship rule learned in this lab is:

```text
PRIMARY KEY
     │
     │ referenced by
     ▼
FOREIGN KEY
```

and the most important deletion rule is:

```text
DROP FOREIGN KEY
       ↓
DROP PRIMARY KEY
```

---

<p align="center">
  <b>🗄️ Database Management System Lab</b><br>
  <i>Practice • Understand • Implement • Verify</i>
</p>
