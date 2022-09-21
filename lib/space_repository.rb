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
  
  def create(space)
    sql = 'INSERT INTO spaces (user_id, name, description)
            VALUES ($1, $2, $3);'
    params = [space.user_id, space.name, space.description]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end