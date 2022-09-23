require_relative 'space'

class SpaceRepository
  def all
    sql = 'SELECT * FROM spaces;'
    params = []
    result_set = DatabaseConnection.exec_params(sql, params)
    result_set.map do |record|
      space = Space.new
      space.id = record['id'].to_i
      space.user_id = record['user_id'].to_i
      space.name = record['name']
      space.description = record['description']
      space
    end
  end

  def find(id)
    sql = 'SELECT * FROM spaces WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    space = Space.new
    space.id = result[0]["id"]
    space.user_id = result[0]["user_id"]
    space.name = result[0]["name"]
    space.description = result[0]["description"]
    return space
  end
  
  def create(space)
    sql = 'INSERT INTO spaces (user_id, name, description)
            VALUES ($1, $2, $3) RETURNING id;'
    params = [space.user_id, space.name, space.description]
    result = DatabaseConnection.exec_params(sql, params)
    return result.first['id']
  end

  def find(id)
    sql = 'SELECT * FROM spaces WHERE id = $1'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    space = Space.new
    space.id = result.first['id'].to_i
    space.name = result.first['name']
    space.description = result.first['description']
    space.user_id = result.first['user_id'].to_i
    return space
  end
end