# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
VIDEO DEMO USER CASE
```

```
Nouns:

scheduled concerts, artist name, concert date, venue, venue name, venue capacity
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties                  |
| --------------------- | --------------------------- |
| concert               | artist_name, scheduled_date |
| venue                 | name, capacity              |

1. Name of the first table (always plural): `concerts` 

    Column names: `artist_name`, `scheduled_date`, 

2. Name of the second table (always plural): `venues` 

    Column names: `name`, `capacity`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: concert
id: SERIAL
artist_name: text
scheduled_date: date

Table: venue
id: SERIAL
name: text
capacity: int

```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one venue have many concerts? YES
2. Can one concerts have many venue? NO

-> Therefore,
-> An venue HAS MANY concerts
-> A concert BELONGS TO a venue

-> Therefore, the foreign key is on the concerts table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE venues (
  id SERIAL PRIMARY KEY,
  name text,
  capacity int
);

-- Then the table with the foreign key first.
CREATE TABLE concerts (
  id SERIAL PRIMARY KEY,
  artist_name text,
  scheduled_date date,
-- The foreign key name is always {other_table_singular}_id
  venue_id int,
  constraint fk_venue foreign key(venue_id)
    references venues(id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 music_promoter < music_promoter.sql;
```