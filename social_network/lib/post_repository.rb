require_relative './post'

class PostRepository

  def all
    sql = 'SELECT id, title, content, view_count, user_id FROM posts'
    result = DatabaseConnection.exec_params(sql, [])

    posts_array = []

    result.each do |row|
      post = Post.new
      post.id = row['id']
      post.title = row['title']
      post.content = row['content']
      post.view_count = row['view_count']
      post.user_id = row['user_id']

      posts_array << post
    end

    return posts_array
  end
  
  def find(id)
    sql = 'SELECT id, title, content, view_count, user_id FROM posts WHERE id = $1'
    param = [id]

    result = DatabaseConnection.exec_params(sql, param)

    record = result.first
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.view_count = record['view_count']
    post.user_id = record['user_id']

    return post
  end
  
  def create(post)
    sql = 'INSERT INTO posts (title, content, view_count, user_id) VALUES ($1, $2, $3, $4)'
    params = [post.title, post.content, post.view_count, post.user_id]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end
  
  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1'
    param = [id]

    DatabaseConnection.exec_params(sql, param)
    
    return nil
  end
  
  def update(post)
    sql = 'UPDATE posts SET title = $1, content = $2, view_count = $3 WHERE id = $4'
    params = [post.title, post.content, post.view_count, post.id]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end

end