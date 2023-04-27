require_relative './user'

class UserRepository

  def all
    sql = ' SELECT id, username, email FROM users;'
    result = DatabaseConnection.exec_params(sql, [])

    users_array = []

    result.each do |row|
      user = User.new
      user.id = row['id']
      user.username = row['username']
      user.email = row['email']

      users_array << user
    end
    
    return users_array
  end
  
  def find(id)
    sql = 'SELECT id, username, email FROM users WHERE id = $1;'
    param = [id]

    result = DatabaseConnection.exec_params(sql, param)
    record = result.first

    user = User.new
    user.id = record['id']
    user.username = record['username']
    user.email = record['email']
    
    return user
  end
  
  def create(user)
    sql = 'INSERT INTO users (username, email) VALUES ($1, $2)'
    params = [user.username, user.email]

    DatabaseConnection.exec_params(sql, params)

    return nil
  end
  
  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1'
    params = [id]

    DatabaseConnection.exec_params(sql, params)
  end
  
  def update(user)
    sql = 'UPDATE users SET username = $1, email = $2 WHERE id = $3'
    param = [user.username, user.email, user.id]

    DatabaseConnection.exec_params(sql, param)
  end

end