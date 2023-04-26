# Recipes Directory Single Table Design Recipe 

_Copy this recipe template to design and create a database table from a specification._

## 1. Extract nouns from the user stories or specification

```
As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep a list of all my recipes with their names.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep the average cooking time (in minutes) for each recipe.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to give a rating to each of the recipes (from 1 to 5).
```

```
Nouns:

recipes, name, average_cooking_time, rating

```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties                            |
| --------------------- | ------------------------------------- |
| recipe                | dish_name, average_cooking_time, rating

Name of the table (always plural): `recipes` 

Column names: `dish_name`, `average_cooking_time`, `rating`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

id: SERIAL
dish_name: text
average_cooking_time: int
rating: int
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: students_table.sql

-- Replace the table name, columm names and types.

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  dish_name text,
  average_cooking_time int,
  rating int
);
```

## 5. Create the table within your main database and your test database.

```bash
psql -h 127.0.0.1 recipes_directory < recipes_table.sql;

psql -h 127.0.0.1 recipes_directory_test < recipes_table.sql;
```
