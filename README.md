# Pharmacy Database – PL/SQL Project

## Overview
This project transforms a raw medicines dataset into a normalized Oracle database using PL/SQL. It includes tables, stored procedures, triggers, and a search function.

## Technologies
- Oracle SQL
- PL/SQL (procedures, functions, triggers)

## How to Run
1. Run all scripts in the `schema/` folder to create tables.
2. Run scripts in `procedures/` to create procedures and the search function.
3. Run scripts in `triggers/` to create triggers.
4. (Optional) Run `data/sample_data.sql` to insert test data and try out the features.

## Example
Search for medicines by active ingredient, dosage, and packaging:
```sql
SELECT Search_Medicines('Paracetamol', '500 mg', 'Blister 20') FROM dual;
-- Then check the 'results' table
SELECT * FROM results;
