require 'user'

class UserRepository
  def create(user)
    sql = 'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id;'
    params = [user.username, user.email, user.password]
    results = DatabaseConnection.exec_params(sql, params)
    # sets user ID for returning full user object
    user.id = results.first['id'].to_i # convert to integer
    return user
  end

  def find(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    result = result_set[0]
    user = User.new
    user.username = result['username']
    user.email = result['email']
    user.password = result['password']
    return user
  end

  def find_by_email(email)
    sql = 'SELECT id, email, username, password FROM users WHERE email = $1;'
    params = [email]
    result = DatabaseConnection.exec_params(sql, params)
    result = result.first
    user = User.new
    user.id = result['id'].to_i # convert to integer
    user.username = result['username']
    user.email = result['email']
    user.password = result['password']
    return user
  end
end
