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

TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');

INSERT INTO albums (title, release_year, artist_id) VALUES ('Bossanova', '1999', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', '2001', '1');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
 psql -h 127.0.0.1 music_library_test < music_library/spec/seeds_albums.sql;
```
This was created from the terminal within the directory containing the database file

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)

class Album

  attr_accessor :id, :title, :release_year, :artist_id
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
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
  end

  def find(id)
    # Performs an SQL SELECT query WHERE id = id and returns a single Album object
    # SELECT id, title, release_year FROM albums WHERE id = $1

    # Returns a single Album object
  end

  def create(album)
    # Executes the SQL query
    # INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3)

    # No return value, creates the record on database
  end

  def delete(id)
    # Executes the SQL query
    # DELETE FROM albums WHERE id = $1

    #No return value, deletes the record on database
  end

  def update(album)
    # Executes the SQL query
    # UPDATE albums SET title = $1, release_year = $2 WHERE id = $3

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
# Get all albums

repo = AlbumRepository.new #seeded from our test seed with 2 columns

albums = repo.all # => 
albums.length # => 2
albums.first.release_year # => '1999'
albums.first.title # => 'Bossanova'
albums.first.artist_id # => '1'

# 2
# Get the a single album

repo = AlbumRepository.new

album = repo.find(4)
album.title # => 'Super Trooper'
album.release_year # => 1980
album.id # => 4

# 3 
# Create a new album record on the database

repo = AlbumRepository.new

album = Album.new
album.title = 'Rumours'
album.release_year = 1977
album.artist_id = '2'

repo.create(album) # => nil

albums = repo.all
last_album = albums.last 

last_album.title # => 'Rumours'
last_album.release_year # => 1977
last_album.artist_id # => '2'

# 4 
# Delete a album from the database

repo = AlbumRepository.new
# 'Bossanova', '1999', '1');
repo.delete(1)

albums = repo.all
first_album = albums.first

first_album.title # => 'Surfer Rosa'
first_album.release_year # => '2001'

# 5
# Update a album from the database

repo = AlbumRepository.new

orginal_album = albums.find(1)

orginal_album.title = 'DAMN'
orginal_album.release_year = '2017'

repo.update(orginal_album)

updated_album = repo.find(1)

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/artist_repository_spec.rb

RSpec.describe AlbumRepository do

  def reset_artists_table 
    seed_sql = File.read('spec/seeds_albums.sql')
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