# 🗄️ MySQL — DELETE & MODIFY Operations Complete Notes

> A practical reference for **DELETE, DROP, TRUNCATE, ALTER TABLE, ADD/DROP constraints, PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, DEFAULT, column rename, column move, column add/remove** and related MySQL operations.

---

# 📌 1. Sample Database

We will use one common database throughout this note so that every example is easy to understand.

## Create Database

```sql
CREATE DATABASE University;
```

Select the database:

```sql
USE University;
```

---

# 📌 2. Sample Tables

We will work with two related tables:

### Department Table

```sql
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
```

Insert some data:

```sql
INSERT INTO Department
VALUES
(1, 'ICE'),
(2, 'CSE'),
(3, 'EEE');
```

### Student Table

```sql
CREATE TABLE Student (
    ID INT,
    Ename VARCHAR(50),
    Email VARCHAR(100),
    Age INT,
    DeptID INT
);
```

Insert sample data:

```sql
INSERT INTO Student
VALUES
(101, 'Atia', 'atia@gmail.com', 22, 1),
(102, 'Oishi', 'oishi@gmail.com', 21, 2),
(103, 'Raisa', 'raisa@gmail.com', 23, 3),
(104, 'Mahi', 'mahi@gmail.com', 22, 1);
```

Current `Student` table:

|  ID | Ename | Email                                     | Age | DeptID |
| --: | ----- | ----------------------------------------- | --: | -----: |
| 101 | Atia  | [atia@gmail.com](mailto:atia@gmail.com)   |  22 |      1 |
| 102 | Oishi | [oishi@gmail.com](mailto:oishi@gmail.com) |  21 |      2 |
| 103 | Raisa | [raisa@gmail.com](mailto:raisa@gmail.com) |  23 |      3 |
| 104 | Mahi  | [mahi@gmail.com](mailto:mahi@gmail.com)   |  22 |      1 |

---

# 🗑️ 3. DELETE Operations

`DELETE` is mainly used to remove **rows/records** from a table.

General syntax:

```sql
DELETE FROM table_name
WHERE condition;
```

---

## 3.1 Delete a Single Row

Suppose we want to delete the student whose ID is `102`.

```sql
DELETE FROM Student
WHERE ID = 102;
```

### Before

|  ID | Ename | Age |
| --: | ----- | --: |
| 101 | Atia  |  22 |
| 102 | Oishi |  21 |
| 103 | Raisa |  23 |
| 104 | Mahi  |  22 |

### After

|  ID | Ename | Age |
| --: | ----- | --: |
| 101 | Atia  |  22 |
| 103 | Raisa |  23 |
| 104 | Mahi  |  22 |

Only the **entire row** with `ID = 102` is deleted.

---

# 3.2 Delete Multiple Rows

Suppose we want to delete all students whose age is `22`.

```sql
DELETE FROM Student
WHERE Age = 22;
```

Both Atia and Mahi will be deleted.

### Before

|  ID | Ename | Age |
| --: | ----- | --: |
| 101 | Atia  |  22 |
| 103 | Raisa |  23 |
| 104 | Mahi  |  22 |

### After

|  ID | Ename | Age |
| --: | ----- | --: |
| 103 | Raisa |  23 |

---

# 3.3 DELETE Using AND

Delete students from department `1` whose age is `22`:

```sql
DELETE FROM Student
WHERE DeptID = 1
AND Age = 22;
```

Both conditions must be true.

---

# 3.4 DELETE Using OR

```sql
DELETE FROM Student
WHERE DeptID = 1
OR Age = 23;
```

A row will be deleted if either condition is true.

---

# 3.5 DELETE Using BETWEEN

Delete students whose age is between 20 and 22:

```sql
DELETE FROM Student
WHERE Age BETWEEN 20 AND 22;
```

`BETWEEN` includes both boundary values.

---

# 3.6 DELETE Using IN

Delete students with ID 101, 103 or 104:

```sql
DELETE FROM Student
WHERE ID IN (101, 103, 104);
```

---

# 3.7 DELETE Rows Containing NULL

Suppose some student's `DeptID` is NULL.

To delete those records:

```sql
DELETE FROM Student
WHERE DeptID IS NULL;
```

### ❌ Wrong

```sql
DELETE FROM Student
WHERE DeptID = NULL;
```

### ✅ Correct

```sql
DELETE FROM Student
WHERE DeptID IS NULL;
```

---

# 3.8 DELETE All Rows

```sql
DELETE FROM Student;
```

This deletes **all records** from the table.

But the table itself remains.

```text
Student Table
     ↓
All Rows → Deleted
Table Structure → Remains
```

⚠️ No `WHERE` means every row is affected.

---

# 🧹 4. TRUNCATE TABLE

`TRUNCATE` removes **all rows** from a table.

```sql
TRUNCATE TABLE Student;
```

After execution:

```text
Rows             → Deleted
Table             → Remains
Table Structure   → Remains
```

### Difference from DELETE

```sql
DELETE FROM Student;
```

and

```sql
TRUNCATE TABLE Student;
```

both remove all rows, but they are different SQL operations with different behavior.

For basic exam understanding:

| Operation          | Selected Rows | All Rows | Table Remains |
| ------------------ | ------------: | -------: | ------------: |
| `DELETE ... WHERE` |             ✅ |        ❌ |             ✅ |
| `DELETE FROM`      |             ❌ |        ✅ |             ✅ |
| `TRUNCATE TABLE`   |             ❌ |        ✅ |             ✅ |

---

# 💥 5. DROP TABLE

To completely remove a table:

```sql
DROP TABLE Student;
```

This removes:

```text
Student Table
├── Structure ❌
├── Columns ❌
└── Data ❌
```

Unlike `DELETE` and `TRUNCATE`, the table itself no longer exists.

---

# 💥 6. DROP DATABASE

To remove the entire database:

```sql
DROP DATABASE University;
```

This removes the database and everything inside it.

```text
University
   ├── Student ❌
   ├── Department ❌
   └── All Data ❌
```

---

# 🛠️ 7. ALTER TABLE

`ALTER TABLE` is used to **modify the structure of an existing table**.

General syntax:

```sql
ALTER TABLE table_name
operation;
```

Common operations we use:

```text
ADD
DROP
MODIFY
RENAME
```

---

# ➕ 8. ADD COLUMN Externally

Suppose the existing `Student` table does not have a `Phone` column.

Add it:

```sql
ALTER TABLE Student
ADD Phone VARCHAR(15);
```

Before:

```text
ID | Ename | Email | Age | DeptID
```

After:

```text
ID | Ename | Email | Age | DeptID | Phone
```

---

# ➕ 9. ADD Multiple Columns

```sql
ALTER TABLE Student
ADD Address VARCHAR(100),
ADD Gender VARCHAR(10);
```

Multiple columns can be added in one `ALTER TABLE` statement.

---

# ❌ 10. DROP COLUMN

Suppose we no longer need the `Phone` column.

```sql
ALTER TABLE Student
DROP COLUMN Phone;
```

This removes:

```text
Phone column
+
All values stored in Phone
```

### Important

`DROP COLUMN` ≠ `DELETE`

```text
DELETE
  ↓
Removes rows

DROP COLUMN
  ↓
Removes a column
```

---

# ✏️ 11. MODIFY COLUMN

`MODIFY` changes the definition of an existing column.

Suppose:

```sql
Name VARCHAR(50)
```

We want to increase the size to 100 characters:

```sql
ALTER TABLE Student
MODIFY Ename VARCHAR(100);
```

The column remains the same column, but its definition changes.

---

# 🔒 12. Add NOT NULL Using MODIFY

Suppose `Ename` should never be NULL:

```sql
ALTER TABLE Student
MODIFY Ename VARCHAR(50) NOT NULL;
```

Now:

```text
Ename = NULL
```

is not allowed.

---

# 🔓 13. Remove NOT NULL

To allow NULL again:

```sql
ALTER TABLE Student
MODIFY Ename VARCHAR(50) NULL;
```

So:

```text
NOT NULL → NULL
```

---

# ✏️ 14. Rename Column

Suppose the current column is:

```text
Ename
```

and we want:

```text
Name
```

Use:

```sql
ALTER TABLE Student
RENAME COLUMN Ename TO Name;
```

### Before

```text
ID | Ename | Email | Age
```

### After

```text
ID | Name | Email | Age
```

### Important

The data is **not deleted**.

Only:

```text
Ename → Name
```

The values remain.

---

# 🔄 15. Move Column

MySQL allows changing a column's position.

Suppose:

```text
ID | Name | Email | Age | DeptID
```

We want `Age` immediately after `Name`.

```sql
ALTER TABLE Student
MODIFY Age INT AFTER Name;
```

Result:

```text
ID | Name | Age | Email | DeptID
```

---

## Move Column to First Position

```sql
ALTER TABLE Student
MODIFY Age INT FIRST;
```

Result:

```text
Age | ID | Name | Email | DeptID
```

### Important

Moving a column changes its **position**, not its data.

---

# 🔑 16. PRIMARY KEY — Add Externally

Suppose `Student` was created without a Primary Key:

```sql
CREATE TABLE Student (
    ID INT,
    Name VARCHAR(50),
    Age INT
);
```

Now add Primary Key:

```sql
ALTER TABLE Student
ADD CONSTRAINT pk_student
PRIMARY KEY (ID);
```

Here:

```text
pk_student
     ↓
Name of the constraint

ID
     ↓
Primary Key column
```

### Important

`pk_student` is **NOT a column**.

It is the name given to the constraint.

---

# ❌ 17. Remove PRIMARY KEY

```sql
ALTER TABLE Student
DROP PRIMARY KEY;
```

This removes the Primary Key constraint.

The `ID` column itself remains.

```text
DROP PRIMARY KEY
        ↓
Primary Key Rule → Removed
ID Column        → Remains
```

---

# 🔗 18. FOREIGN KEY — Add Externally

We have:

### Parent Table

```text
Department
----------------
DeptID
DeptName
```

### Child Table

```text
Student
----------------
ID
Name
DeptID
```

We want:

```text
Student.DeptID
       ↓
Department.DeptID
```

Add the Foreign Key:

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

---

## Understand Every Part

```sql
ALTER TABLE Student
```

Modify the `Student` table.

```sql
ADD CONSTRAINT
```

Add a database rule.

```sql
fk_student_department
```

Name of the constraint.

```sql
FOREIGN KEY (DeptID)
```

`Student.DeptID` is the Foreign Key column.

```sql
REFERENCES Department(DeptID)
```

It references `Department.DeptID`.

Relationship:

```text
Department                 Student
-----------                -----------
DeptID  <---------------- DeptID
  PK                         FK
```

---

# ❌ 19. Remove FOREIGN KEY

Suppose the Foreign Key constraint is named:

```text
fk_student_department
```

Remove it:

```sql
ALTER TABLE Student
DROP FOREIGN KEY fk_student_department;
```

### Important

This removes only the **Foreign Key constraint**.

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

# 🔐 20. UNIQUE Constraint — Add Externally

Suppose every student's email must be unique.

```sql
ALTER TABLE Student
ADD CONSTRAINT uq_student_email
UNIQUE (Email);
```

Now:

```text
atia@gmail.com
atia@gmail.com
```

cannot appear for two different records.

---

# ❌ 21. Remove UNIQUE Constraint

First check the table definition:

```sql
SHOW CREATE TABLE Student;
```

Suppose the unique index/constraint is:

```text
uq_student_email
```

Then:

```sql
ALTER TABLE Student
DROP INDEX uq_student_email;
```

---

# ✅ 22. CHECK Constraint — Add Externally

Suppose students must be at least 18 years old.

```sql
ALTER TABLE Student
ADD CONSTRAINT chk_student_age
CHECK (Age >= 18);
```

Now:

```text
Age = 20 → Allowed
Age = 18 → Allowed
Age = 17 → Not allowed
```

---

# ❌ 23. Remove CHECK Constraint

```sql
ALTER TABLE Student
DROP CHECK chk_student_age;
```

Depending on MySQL version, the equivalent constraint-removal syntax may also be:

```sql
ALTER TABLE Student
DROP CONSTRAINT chk_student_age;
```

---

# ⭐ 24. DEFAULT Constraint — Add Externally

Suppose if no department is supplied, the default should be `ICE`.

```sql
ALTER TABLE Student
ALTER DeptID SET DEFAULT 1;
```

Here:

```text
1 → ICE
```

assuming `Department.DeptID = 1` represents ICE.

---

# ❌ 25. Remove DEFAULT

```sql
ALTER TABLE Student
ALTER DeptID DROP DEFAULT;
```

The automatic default value is removed.

---

# 🧩 26. Clear Only One Value

This is different from deleting a row.

Suppose:

```text
ID | Name | Department | Age
101 | Atia | ICE | 22
```

We want to remove only Atia's Department value but keep the student record.

Use:

```sql
UPDATE Student
SET DeptID = NULL
WHERE ID = 101;
```

Result:

```text
ID | Name | Department | Age
101 | Atia | NULL | 22
```

### Remember

```text
DELETE
   ↓
Whole Row removed

UPDATE ... SET NULL
   ↓
Only selected value cleared
```

---

# 🔥 27. Foreign Key DELETE Actions

Foreign Keys can control what happens when a parent record is deleted.

---

## ON DELETE CASCADE

```sql
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID)
ON DELETE CASCADE;
```

Meaning:

```text
Parent deleted
      ↓
Related child records
      ↓
Automatically deleted
```

---

## ON DELETE SET NULL

```sql
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID)
ON DELETE SET NULL;
```

Meaning:

```text
Parent deleted
      ↓
Child row remains
      ↓
DeptID becomes NULL
```

The Foreign Key column must allow `NULL`.

---

## ON DELETE RESTRICT

```sql
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID)
ON DELETE RESTRICT;
```

Meaning:

```text
Related child exists
       ↓
Parent cannot be deleted
```

This protects referential integrity.

---

# 🔐 28. Composite PRIMARY KEY

A Primary Key can contain more than one column.

Example:

```sql
ALTER TABLE Student
ADD CONSTRAINT pk_student
PRIMARY KEY (ID, DeptID);
```

Here:

```text
ID + DeptID
     ↓
Composite Primary Key
```

The combination is used to uniquely identify the record.

---

# 🔐 29. Composite UNIQUE Constraint

Multiple columns can also be combined in a UNIQUE constraint:

```sql
ALTER TABLE Student
ADD CONSTRAINT uq_student
UNIQUE (Name, DeptID);
```

The combination:

```text
Name + DeptID
```

must be unique.

---

# 🔍 30. Check Constraint Names

When you need to remove a constraint, first inspect the table:

```sql
SHOW CREATE TABLE Student;
```

This can show things such as:

```text
PRIMARY KEY
FOREIGN KEY
UNIQUE
CHECK
DEFAULT
```

This is especially useful when you don't remember the exact constraint name.

---

# 📊 31. What Exactly Are You Removing?

This is the most important concept of the entire topic.

```text
DATABASE
   │
   └── TABLE
         │
         ├── COLUMNS
         │      └── VALUES
         │
         └── ROWS
```

Different commands operate at different levels.

### Remove Database

```sql
DROP DATABASE University;
```

### Remove Table

```sql
DROP TABLE Student;
```

### Remove Column

```sql
ALTER TABLE Student
DROP COLUMN Email;
```

### Remove Row

```sql
DELETE FROM Student
WHERE ID = 101;
```

### Remove All Rows

```sql
TRUNCATE TABLE Student;
```

### Clear One Value

```sql
UPDATE Student
SET Email = NULL
WHERE ID = 101;
```

### Remove Primary Key Rule

```sql
ALTER TABLE Student
DROP PRIMARY KEY;
```

### Remove Foreign Key Rule

```sql
ALTER TABLE Student
DROP FOREIGN KEY fk_student_department;
```

### Remove UNIQUE Rule

```sql
ALTER TABLE Student
DROP INDEX uq_student_email;
```

### Remove CHECK Rule

```sql
ALTER TABLE Student
DROP CHECK chk_student_age;
```

---

# 🧠 32. DELETE vs MODIFY vs DROP

| Operation          | What changes?     | Example                            |
| ------------------ | ----------------- | ---------------------------------- |
| `DELETE`           | Rows              | `DELETE FROM Student WHERE ID=101` |
| `TRUNCATE`         | All rows          | `TRUNCATE TABLE Student`           |
| `DROP COLUMN`      | Column            | `DROP COLUMN Email`                |
| `DROP TABLE`       | Complete table    | `DROP TABLE Student`               |
| `DROP DATABASE`    | Complete database | `DROP DATABASE University`         |
| `UPDATE`           | Existing values   | `UPDATE Student SET Age=23`        |
| `MODIFY`           | Column definition | `MODIFY Age INT`                   |
| `RENAME COLUMN`    | Column name       | `Ename → Name`                     |
| `DROP PRIMARY KEY` | Primary Key rule  | `DROP PRIMARY KEY`                 |
| `DROP FOREIGN KEY` | Foreign Key rule  | `DROP FOREIGN KEY fk_name`         |
| `DROP INDEX`       | UNIQUE index      | `DROP INDEX uq_name`               |
| `DROP CHECK`       | CHECK rule        | `DROP CHECK chk_name`              |

---

# ⚠️ 33. Most Important Exam Confusions

## `DELETE` vs `DROP`

```text
DELETE → Row/Data
DROP   → Object/Structure
```

---

## `DELETE` vs `TRUNCATE`

```text
DELETE
→ Can use WHERE
→ Selected rows can be removed

TRUNCATE
→ Removes all rows
→ Cannot select individual rows using WHERE
```

---

## `DROP FOREIGN KEY` vs `DROP COLUMN`

```text
DROP FOREIGN KEY
→ Foreign Key rule removed
→ Column remains

DROP COLUMN
→ Column itself removed
```

---

## `RENAME COLUMN` vs `DROP COLUMN`

```text
RENAME
→ Name changes
→ Data remains

DROP
→ Column disappears
→ Its stored values disappear
```

---

## Constraint Name vs Column Name

Example:

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

Here:

```text
fk_student_department
        ↓
Constraint Name

DeptID
        ↓
Column Name
```

---

# 📝 34. One-Page Cheat Sheet

## DELETE

```sql
DELETE FROM Student
WHERE ID = 101;
```

## DELETE Multiple

```sql
DELETE FROM Student
WHERE Age = 22;
```

## DELETE ALL

```sql
DELETE FROM Student;
```

## TRUNCATE

```sql
TRUNCATE TABLE Student;
```

## DROP TABLE

```sql
DROP TABLE Student;
```

## DROP DATABASE

```sql
DROP DATABASE University;
```

---

## ADD COLUMN

```sql
ALTER TABLE Student
ADD Phone VARCHAR(15);
```

## DROP COLUMN

```sql
ALTER TABLE Student
DROP COLUMN Phone;
```

## MODIFY COLUMN

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(100);
```

## RENAME COLUMN

```sql
ALTER TABLE Student
RENAME COLUMN Ename TO Name;
```

## MOVE COLUMN

```sql
ALTER TABLE Student
MODIFY Age INT AFTER Name;
```

## MOVE TO FIRST

```sql
ALTER TABLE Student
MODIFY Age INT FIRST;
```

---

## ADD PRIMARY KEY

```sql
ALTER TABLE Student
ADD CONSTRAINT pk_student
PRIMARY KEY (ID);
```

## DROP PRIMARY KEY

```sql
ALTER TABLE Student
DROP PRIMARY KEY;
```

---

## ADD FOREIGN KEY

```sql
ALTER TABLE Student
ADD CONSTRAINT fk_student_department
FOREIGN KEY (DeptID)
REFERENCES Department(DeptID);
```

## DROP FOREIGN KEY

```sql
ALTER TABLE Student
DROP FOREIGN KEY fk_student_department;
```

---

## ADD UNIQUE

```sql
ALTER TABLE Student
ADD CONSTRAINT uq_student_email
UNIQUE (Email);
```

## DROP UNIQUE

```sql
ALTER TABLE Student
DROP INDEX uq_student_email;
```

---

## ADD NOT NULL

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(50) NOT NULL;
```

## REMOVE NOT NULL

```sql
ALTER TABLE Student
MODIFY Name VARCHAR(50) NULL;
```

---

## ADD CHECK

```sql
ALTER TABLE Student
ADD CONSTRAINT chk_student_age
CHECK (Age >= 18);
```

## DROP CHECK

```sql
ALTER TABLE Student
DROP CHECK chk_student_age;
```

---

## ADD DEFAULT

```sql
ALTER TABLE Student
ALTER DeptID SET DEFAULT 1;
```

## DROP DEFAULT

```sql
ALTER TABLE Student
ALTER DeptID DROP DEFAULT;
```

---

# 🎯 35. Final Memory Trick

Whenever you get a SQL question, first identify **what is being changed**.

```text
                    WHAT DO I WANT TO CHANGE?
                              │
          ┌───────────────────┼───────────────────┐
          ↓                   ↓                   ↓
        DATA               COLUMN              CONSTRAINT
          │                   │                   │
      ┌───┴───┐          ┌────┴────┐       ┌──────┴──────┐
      ↓       ↓          ↓         ↓       ↓      ↓      ↓
   UPDATE   DELETE      ADD      DROP    ADD    MODIFY   DROP
                                  │
                               RENAME
                               MOVE
```

### The Golden Rules

```text
DATABASE  → DROP DATABASE

TABLE     → DROP TABLE

ALL ROWS  → TRUNCATE

ROW       → DELETE

VALUE     → UPDATE ... SET

COLUMN    → DROP COLUMN

COLUMN NAME → RENAME COLUMN

COLUMN POSITION → MODIFY ... FIRST / AFTER

PRIMARY KEY → ADD / DROP PRIMARY KEY

FOREIGN KEY → ADD CONSTRAINT / DROP FOREIGN KEY

UNIQUE → ADD CONSTRAINT / DROP INDEX

NOT NULL → MODIFY ... NOT NULL / NULL

CHECK → ADD CONSTRAINT / DROP CHECK

DEFAULT → SET DEFAULT / DROP DEFAULT
```

> **The key to mastering these commands is not memorizing every syntax separately. First identify whether you are modifying a database, table, column, row, value, or constraint. Then choose the corresponding command.**
