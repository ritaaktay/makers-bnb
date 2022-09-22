require 'request'

class RequestRepository

  # Find all requests
  def all
    sql = "SELECT * FROM requests"
    requests = []
    results = DatabaseConnection.exec_params(sql, [])
    results.each do |row|

      request = Request.new
      request.id = row['id'].to_i # convert to integer
      request.date = row['date']
      request.user_id = row['user_id'].to_i # convert to integer
      request.listing_id = row['listing_id'].to_i # convert to integer
      request.current_status = row['current_status']

      requests << request
    end
    return requests
  end

  # Find a request by id
  def find(id)
    sql = "SELECT * FROM requests WHERE id = $1"
    results = DatabaseConnection.exec_params(sql, [id])
    row = results.first

    request = Request.new
    request.id = row['id'].to_i # convert to integer
    request.date = row['date']
    request.user_id = row['user_id'].to_i # convert to integer
    request.listing_id = row['listing_id'].to_i # convert to integer
    request.current_status = row['current_status']

    return request
  end

  # Create a new request
  def create(request)
    sql = "INSERT INTO requests (date, user_id, listing_id, current_status) VALUES ($1, $2, $3, $4) RETURNING id"
    params = [request.date, request.user_id, request.listing_id, request.current_status]
    results = DatabaseConnection.exec_params(sql, params)
    request.id = results.first['id'].to_i # convert to integer
    return request
  end

  # Update a request
  def update(request)
    sql = "UPDATE requests SET date = $1, user_id = $2, listing_id = $3, current_status = $4 WHERE id = $5"
    params = [request.date, request.user_id, request.listing_id, request.current_status, request.id]
    DatabaseConnection.exec_params(sql, params)
    return request
  end

  # Delete a request
  def delete(id)
    sql = "DELETE FROM requests WHERE id = $1"
    DatabaseConnection.exec_params(sql, [id])
    return true
  end

end