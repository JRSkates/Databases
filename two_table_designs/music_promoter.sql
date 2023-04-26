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