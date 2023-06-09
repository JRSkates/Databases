# Music Library Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: artists

Columns:
id | name | genre
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('ABBA', 'Pop');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 music_library_test < music_database.sql;
```
This was created from the terminal within the directory containing the database file

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)

class Artist

  attr_accessor :id, :name, :genre
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: artists

# Repository class
# (in lib/artist_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
  end

  def find(id)
    # Performs an SQL SELECT query WHERE id = id and returns a single Artist object
    # SELECT id, name, genre FROM artist WHERE id = $1

    # Returns a single Artist object
  end

  def create(artists)
    # Executes the SQL query
    # INSERT INTO artists (name, genre) VALUES ($1, $2)

    # No return value, creates the record on database
  end

  def delete(id)
    # Executes the SQL query
    # DELETE FROM artists WHERE id = $1

    #No return value, deletes the record on database
  end

  def update(album)
    # Executes the SQL query
    # UPDATE artists SET name = $1, genre = $2 WHERE id = $3

    # No return value, updates the record on database
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all artists

repo = ArtistRepository.new #seeded from our test seed with 2 columns

artists = repo.all # => 
artists.length # => 2
artists.first.id # => '1'
artist.first.name # => 'Pixies'

# 2
# Gets a single Artist

repo = ArtistRepository.new #seeded from our test seed with

artist = repo.find(1)
artist.name # => 'Pixies'
artist.genre # => 'Rock'

# 4
# Create a new artist record on the database

repo = ArtistRepository.new

artist = Artist.new
artist.name = 'Fleetwood Mac'
artist.genre = 'Rock'

repo.create(artist) # => nil

artists = repo.all
last_artist = artists.last 

last_artist.id # => '3'
last_artist.name # => 'Fleetwood Mac'
last_artist.genre # => 'Rock'

# 5
# Delete an artist from the database

repo = ArtistRepository.new
# 'Pixies', 'Rock'
repo.delete(1)

artists = repo.all
first_artist = artists.first

first_artist.id # => '2'
first_artist.name # => 'ABBA'
first_artist.genre # => 'Pop'

# 6 
# Update an existing artist

repo = ArtistRepository.new

original_artist = repo.find(1)

original_artist.name = 'Kendrick Lamar'
original_artist.genre = 'Hip-Hop'

repo.update(original_artist)

updated_artist = repo.find(1)

updated_artist.name # => 'Kendrick Lamar'
updated_artist.genre # => 'Hip-Hop'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/artist_repository_spec.rb

RSpec.describe ArtistRepository do

  def reset_artists_table 
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_artists_table
  end
  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._