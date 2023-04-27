# Social Network Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
| Record                | Properties                            |
| --------------------- | ------------------------------------  |
| post                  | title, content, view_count, post_id
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


TRUNCATE TABLE posts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, view_count, post_id ) VALUES ('Jacks Trip to the Zoo', 'I saw a penguin it was great', 15, '1');
INSERT INTO posts (title, content, view_count, post_id ) VALUES ('Title coming soon', 'Content also coming soon', 4, '2');
INSERT INTO posts (title, content, view_count, post_id ) VALUES ('How I scored a goal', 'Just kick the ball', 5467, '3');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < spec/seeds_posts.sql;
```
This was created from the terminal within the directory containing the database file

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  attr_accessor :id, :title, :content, :view_count, :post_id
end


```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  
  def all
    
  end

  def find(id)
    
  end

  def create(post)
    
  end

  def delete(id)
    
  end

  def update(post)
    
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new 

posts = repo.all # => 
expect(posts.length).to eq 3
expect(posts.first.title).to eq 'Jacks Trip to the Zoo'
expect(posts.last.title).to eq 'How I scored a goal'
expect(posts.first.content).to eq 'I saw a penguin it was great'

# 2
# Get a single post with id

repo = PostRepository.new 


# 3 
# Create a new post

repo = PostRepository.new 

post = post.new
post. = 'TimRoberts1'
post. = 'tim@timtim.com'

repo.create(post)
posts = repo.all
last_post = post.last

expect(last_post.id).to eq '4'
expect(last_post.postname).to eq 'TimRoberts1'
expect(last_post.email).to eq 'tim@timtim.com'

# 4
# Delete a post

repo = PostRepository.new

repo.delete(1)

posts = repo.all
first_post = posts.first

expect(first_post.id).to eq '2'
expect(first_post.postname).to eq 'JaneDoe1'
expect(first_post.email).to eq 'janedoe@gmail.com'

# 5 
# Update a post

repo = PostRepository.new

original_post = repo.find(1)

original_post.postname = 'xXSkatesXx'
original_post.email = 'superskates420@coolnet.com'

repo.update(original_post)

updated_post = repo.find(1)

expect(updated_post.postname).to eq 'xXSkatesXx'
expect(orignal_post.email).to eq 'superskates420@coolnet.com'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/BLANK_repository_spec.rb

RSpec.describe PostRepository do

  def reset_artists_table 
    seed_sql = File.read('spec/seeds_posts.sql')
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