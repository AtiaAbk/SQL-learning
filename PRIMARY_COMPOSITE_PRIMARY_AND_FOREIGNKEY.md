# 🗄️ DBMS Lab — Primary Key & Foreign Key Practice

> **A practical MySQL guide for creating, checking, and dropping Primary Keys, Composite Primary Keys, and Foreign Keys.**

---

## 📌 Table of Contents

* [1. Primary Key](#1-primary-key)
* [2. Create a Primary Key](#2-create-a-primary-key)
* [3. Check Primary Key](#3-check-primary-key)
* [4. Drop Primary Key](#4-drop-primary-key)
* [5. Composite Primary Key](#5-composite-primary-key)
* [6. Foreign Key](#6-foreign-key)
* [7. Requirements for Foreign Key](#7-requirements-for-foreign-key)
* [8. Add Foreign Key Columns](#8-add-foreign-key-columns)
* [9. Create a Foreign Key](#9-create-a-foreign-key)
* [10. Create Course Foreign Key](#10-create-course-foreign-key)
* [11. Check Foreign Key](#11-check-foreign-key)
* [12. Drop Foreign Key](#12-drop-foreign-key)
* [13. Primary Key vs Foreign Key Drop Order](#13-primary-key-vs-foreign-key-drop-order)
* [14. Complete Example](#14-complete-example)
* [15. Composite Primary Key — Complete Process](#15-composite-primary-key--complete-process)
* [16. Quick Syntax Cheat Sheet](#16-quick-syntax-cheat-sheet)

---

# 1. Primary Key

A **Primary Key** is a column or a combination of columns that uniquely identifies each record in a table.

### Main Properties

* Duplicate values are not allowed.
* `NULL` values are not allowed.
* A table can have only one Primary Key constraint.
* A Primary Key can contain one column or multiple columns.

### Example

```text
STUDENT
----------------
STUDENT_ID
STUDENT_NAME
```

Here, `STUDENT_ID` can be used as the Primary Key.

---

# 2. Create a Primary Key

Suppose `STUDENT_ID` is not currently a Primary Key.

Use:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_ID
PRIMARY KEY (STUDENT_ID);
```

### General Syntax

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
PRIMARY KEY (column_name);
```

### Examples

#### Student

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_ID
PRIMARY KEY (STUDENT_ID);
```

#### Course

```sql
ALTER TABLE COURSE
ADD CONSTRAINT PK_COURSE_ID
PRIMARY KEY (COURSE_ID);
```

#### Hall

```sql
ALTER TABLE HALL
ADD CONSTRAINT PK_HALL_ID
PRIMARY KEY (HALL_ID);
```

---

# 3. Check Primary Key

There are several ways to check whether a column is a Primary Key.

### Method 1 — `DESC`

```sql
DESC STUDENT;
```

If you see:

```text
+-------------+------+------+-----+---------+-------+
| Field       | Type | Null | Key | Default | Extra |
+-------------+------+------+-----+---------+-------+
| STUDENT_ID  | int  | NO   | PRI | NULL    |       |
+-------------+------+------+-----+---------+-------+
```

`PRI` means the column is a **Primary Key**.

---

### Method 2 — `SHOW CREATE TABLE`

```sql
SHOW CREATE TABLE STUDENT\G
```

Look for:

```text
PRIMARY KEY (`STUDENT_ID`)
```

---

# 4. Drop Primary Key

To remove the Primary Key:

```sql
ALTER TABLE STUDENT
DROP PRIMARY KEY;
```

### Course

```sql
ALTER TABLE COURSE
DROP PRIMARY KEY;
```

### Hall

```sql
ALTER TABLE HALL
DROP PRIMARY KEY;
```

> ⚠️ **Important:** If the Primary Key is being referenced by a Foreign Key from another table, the Foreign Key must be removed first.

---

# 5. Composite Primary Key

A **Composite Primary Key** is a Primary Key made from **two or more columns**.

Suppose:

```text
STUDENT
----------------
STUDENT_ID
STUDENT_NAME
```

We can create a Composite Primary Key using both columns:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_COMPOSITE
PRIMARY KEY (STUDENT_ID, STUDENT_NAME);
```

Here:

```text
(STUDENT_ID, STUDENT_NAME)
```

together form the Primary Key.

### Course

```sql
ALTER TABLE COURSE
ADD CONSTRAINT PK_COURSE_COMPOSITE
PRIMARY KEY (COURSE_ID, COURSE_NAME);
```

### Hall

```sql
ALTER TABLE HALL
ADD CONSTRAINT PK_HALL_COMPOSITE
PRIMARY KEY (STD_HALL_ID, HALL_NAME);
```

---

# 6. Foreign Key

A **Foreign Key** is a column that establishes a relationship between two tables by referencing a Primary Key or suitable `UNIQUE` key in another table.

### Example

Parent table:

```text
HALL
----------------
STD_HALL_ID  ← PRIMARY KEY
HALL_NAME
```

Child table:

```text
STUDENT
----------------
STUDENT_ID
STUDENT_NAME
HALL_ID       ← FOREIGN KEY
```

### Relationship

```text
STUDENT.HALL_ID
       │
       │ FOREIGN KEY
       ↓
HALL.STD_HALL_ID
       ↑
       │ PRIMARY KEY
```

---

# 7. Requirements for Foreign Key

Before creating a Foreign Key, make sure:

### Requirement 1 — Child column exists

```sql
HALL_ID INT
```

### Requirement 2 — Parent column exists

```sql
STD_HALL_ID INT
```

### Requirement 3 — Parent column is a Primary Key or suitable `UNIQUE` key

For example:

```sql
ALTER TABLE HALL
ADD CONSTRAINT PK_HALL_ID
PRIMARY KEY (STD_HALL_ID);
```

### Requirement 4 — Compatible data types

The Foreign Key column and referenced column should have compatible data types.

---

# 8. Add Foreign Key Columns

If `HALL_ID` does not exist in the Student table:

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT;
```

For Course:

```sql
ALTER TABLE STUDENT
ADD COLUMN COURSE_ID INT;
```

Or add both together:

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT,
ADD COLUMN COURSE_ID INT;
```

---

# 9. Create a Foreign Key

Suppose:

```text
STUDENT.HALL_ID
        ↓
HALL.STD_HALL_ID
```

Use:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_HALL
FOREIGN KEY (HALL_ID)
REFERENCES HALL(STD_HALL_ID);
```

### General Syntax

```sql
ALTER TABLE child_table
ADD CONSTRAINT constraint_name
FOREIGN KEY (child_column)
REFERENCES parent_table(parent_column);
```

### Breakdown

```text
ALTER TABLE STUDENT
        ↓
Select child table

ADD CONSTRAINT FK_STUDENT_HALL
        ↓
Give the Foreign Key a name

FOREIGN KEY (HALL_ID)
        ↓
Select child column

REFERENCES HALL(STD_HALL_ID)
        ↓
Select parent table and referenced column
```

---

# 10. Create Course Foreign Key

Suppose:

```text
STUDENT.COURSE_ID
        ↓
COURSE.COURSE_ID
```

Use:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_COURSE
FOREIGN KEY (COURSE_ID)
REFERENCES COURSE(COURSE_ID);
```

---

# 11. Check Foreign Key

## Method 1 — Recommended

Use:

```sql
SHOW CREATE TABLE STUDENT\G
```

If the output contains:

```text
CONSTRAINT `FK_STUDENT_HALL`
FOREIGN KEY (`HALL_ID`)
REFERENCES `HALL` (`STD_HALL_ID`)
```

then the Foreign Key exists.

---

## Method 2 — Query Foreign Keys

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

If a result is returned, the table has a Foreign Key.

If you get:

```text
Empty set
```

then there is no Foreign Key in that table.

---

# 12. Drop Foreign Key

First, find the **Foreign Key constraint name**.

For example:

```text
FK_STUDENT_HALL
```

Then:

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

Dropping a Foreign Key does **not** delete the column.

For example:

```sql
ALTER TABLE STUDENT
DROP FOREIGN KEY FK_STUDENT_HALL;
```

removes the **relationship/constraint**, but `HALL_ID` remains in the table.

---

# 13. Primary Key vs Foreign Key Drop Order

This is one of the most important concepts.

Suppose:

```text
STUDENT.HALL_ID
       ↓
       ↓ FOREIGN KEY
       ↓
HALL.STD_HALL_ID
       ↑
       │ PRIMARY KEY
```

If you want to remove the Primary Key from `HALL`, you should first remove the Foreign Key that depends on it.

### ❌ Wrong approach

```sql
ALTER TABLE HALL
DROP PRIMARY KEY;
```

while `STUDENT.HALL_ID` is still referencing it.

### ✅ Correct approach

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

### Remember

```text
CREATE:
Primary Key
     ↓
Foreign Key

DROP:
Foreign Key
     ↓
Primary Key
```

---

# 14. Complete Example

Suppose we have three tables:

```text
HALL
----------------
HALL_ID
HALL_NAME

COURSE
----------------
COURSE_ID
COURSE_NAME

STUDENT
----------------
STUDENT_ID
STUDENT_NAME
```

---

## Step 1 — Create Primary Keys

### HALL

```sql
ALTER TABLE HALL
ADD CONSTRAINT PK_HALL_ID
PRIMARY KEY (HALL_ID);
```

### COURSE

```sql
ALTER TABLE COURSE
ADD CONSTRAINT PK_COURSE_ID
PRIMARY KEY (COURSE_ID);
```

### STUDENT

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_ID
PRIMARY KEY (STUDENT_ID);
```

---

## Step 2 — Add Foreign Key Columns

```sql
ALTER TABLE STUDENT
ADD COLUMN HALL_ID INT,
ADD COLUMN COURSE_ID INT;
```

Now:

```text
STUDENT
-------------------------
STUDENT_ID
STUDENT_NAME
HALL_ID
COURSE_ID
```

---

## Step 3 — Create Foreign Keys

### Student → Hall

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_HALL
FOREIGN KEY (HALL_ID)
REFERENCES HALL(HALL_ID);
```

### Student → Course

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_COURSE
FOREIGN KEY (COURSE_ID)
REFERENCES COURSE(COURSE_ID);
```

---

## Step 4 — Check the Structure

```sql
DESC STUDENT;
```

Then:

```sql
SHOW CREATE TABLE STUDENT\G
```

---

## Step 5 — Drop Foreign Keys

```sql
ALTER TABLE STUDENT
DROP FOREIGN KEY FK_STUDENT_HALL;
```

```sql
ALTER TABLE STUDENT
DROP FOREIGN KEY FK_STUDENT_COURSE;
```

---

## Step 6 — Drop Primary Keys

Now the Foreign Keys are removed, so Primary Keys can be dropped:

```sql
ALTER TABLE STUDENT
DROP PRIMARY KEY;
```

```sql
ALTER TABLE COURSE
DROP PRIMARY KEY;
```

```sql
ALTER TABLE HALL
DROP PRIMARY KEY;
```

---

# 15. Composite Primary Key — Complete Process

Suppose `STUDENT_ID` is already a Primary Key.

First remove the existing Primary Key:

```sql
ALTER TABLE STUDENT
DROP PRIMARY KEY;
```

Then create the Composite Primary Key:

```sql
ALTER TABLE STUDENT
ADD CONSTRAINT PK_STUDENT_COMPOSITE
PRIMARY KEY (STUDENT_ID, STUDENT_NAME);
```

Check:

```sql
DESC STUDENT;
```

Both columns participating in the Composite Primary Key will normally show:

```text
PRI
```

---

# 16. Quick Syntax Cheat Sheet

## 🔑 Create Primary Key

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
PRIMARY KEY (column_name);
```

---

## 🔐 Create Composite Primary Key

```sql
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
PRIMARY KEY (column1, column2);
```

---

## ❌ Drop Primary Key

```sql
ALTER TABLE table_name
DROP PRIMARY KEY;
```

---

## ➕ Add Foreign Key Column

```sql
ALTER TABLE table_name
ADD COLUMN column_name INT;
```

---

## 🔗 Create Foreign Key

```sql
ALTER TABLE child_table
ADD CONSTRAINT constraint_name
FOREIGN KEY (child_column)
REFERENCES parent_table(parent_column);
```

---

## 🔍 Check Foreign Key

```sql
SHOW CREATE TABLE table_name\G
```

---

## ❌ Drop Foreign Key

```sql
ALTER TABLE table_name
DROP FOREIGN KEY constraint_name;
```

---

# ⭐ Final Rule to Remember

```text
                 CREATE
                   │
          ┌────────┴────────┐
          ↓                 ↓
    PRIMARY KEY        FOREIGN KEY
          │                 │
          └───────┬─────────┘
                  │
              Relationship
                  
                  
                 DROP
                   │
          ┌────────┴────────┐
          ↓                 ↓
   FOREIGN KEY FIRST    PRIMARY KEY SECOND
```

### 🧠 One-Line Memory Trick

> **Create PK → Create FK → Drop FK → Drop PK**

---

## 💻 MySQL Environment

```text
DBMS      : MySQL
Environment: MySQL Monitor
Commands  : SQL / ALTER TABLE
```

---

## 📚 Lab Practice Summary

| Operation           | Command                          |
| ------------------- | -------------------------------- |
| Create Primary Key  | `ADD CONSTRAINT ... PRIMARY KEY` |
| Create Composite PK | `PRIMARY KEY (col1, col2)`       |
| Check PK            | `DESC table_name`                |
| Drop PK             | `DROP PRIMARY KEY`               |
| Add FK Column       | `ADD COLUMN ...`                 |
| Create FK           | `FOREIGN KEY ... REFERENCES`     |
| Check FK            | `SHOW CREATE TABLE ...`          |
| Drop FK             | `DROP FOREIGN KEY ...`           |

---

> **Practice Tip:** Always check the current table structure with `DESC table_name;` and check relationships with `SHOW CREATE TABLE table_name\G` before modifying constraints.
