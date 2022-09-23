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

  def requests_made(id)
    sql = 'SELECT requests.id, requests.listing_id, requests.date, requests.current_status,
                listings.space_id, spaces.name
            FROM requests 
            JOIN listings ON requests.listing_id = listings.id
            JOIN spaces ON listings.space_id = spaces.id
            WHERE requests.user_id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    requests = []
    result.each do |row|
      request = Request.new
      request.id = row['id'].to_i
      request.user_id = id
      request.listing_id = row['listing_id'].to_i
      request.date = row['date']
      request.current_status = row['current_status']
      requests << {request: request, space_id: row['space_id'].to_i, space_name: row['name']}
    end
    return requests
  end

  def requests_received(id)
    sql = 'SELECT requests.id, requests.listing_id, requests.date, requests.current_status,
              listings.space_id, spaces.name
          FROM spaces
          JOIN listings ON listings.space_id = spaces.id
          JOIN requests ON listings.id = requests.listing_id
          WHERE spaces.user_id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    requests = []
    result.each do |row|
      request = Request.new
      request.id = row['id'].to_i
      request.user_id = id
      request.listing_id = row['listing_id'].to_i
      request.date = row['date']
      request.current_status = row['current_status']
      requests << {request: request, space_id: row['space_id'].to_i, space_name: row['name']}
    end
    return requests
  end
end