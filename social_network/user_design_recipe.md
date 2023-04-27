# Social Network Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
| Record                | Properties                            |
| --------------------- | ------------------------------------  |
| user                  | username, email
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

TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (username, email) VALUES ('JackSkates', 'jack@gmail.com');
INSERT INTO users (username, email) VALUES ('JaneDoe1', 'janedoe@gmail.com');
INSERT INTO users (username, email) VALUES ('FrankLampard', 'frank@gmail.com');


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < spec/seeds_users.sql;
```
This was created from the terminal within the directory containing the database file

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/artist.rb)

class User

  attr_accessor :id, :username, :email 
end


```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  
  def all
    
  end

  def find(id)
    
  end

  def create(user)
    
  end

  def delete(id)
    
  end

  def update(user)
    
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all users

repo = UserRepository.new #seeded from our test seed with 2 columns

users = repo.all # => 
users.length # => 3
users.first.id # => '1'
users.first.username # => 'JackSkates'
users.last.username # => 'FrankLampard'

# 2
# Get a single user with id

repo = UserRepository.new

user = repo.find(1)
expect(user.id).to eq 1
expect(user.username).to eq 'JackSkates'
expect(user.email).to eq 'jack@gmail.com'

# 3 
# Create a new user

repo = UserRepository.new

user = User.new
user.username = 'TimRoberts1'
user.email = 'tim@timtim.com'

repo.create(user)
user = repo.all
last_user = user.last

expect(last_user.id).to eq '4'
expect(last_user.username).to eq 'TimRoberts1'
expect(last_user.email).to eq 'tim@timtim.com'

# 4
# Delete a user

repo = UserRepository.new

repo.delete(1)

users = repo.all
first_user = users.first

expect(first_user.id).to eq '2'
expect(first_user.username).to eq 'JaneDoe1'
expect(first_user.email).to eq 'janedoe@gmail.com'

# 5 
# Update a User

repo = UserRepository.new

original_user = repo.find(1)

original_user.username = 'xXSkatesXx'
original_user.email = 'superskates420@coolnet.com'

repo.update(original_user)

updated_user = repo.find(1)

expect(updated_user.username).to eq 'xXSkatesXx'
expect(orignal_user.email).to eq 'superskates420@coolnet.com'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

RSpec.describe UserRepository do

  def reset_artists_table 
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
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