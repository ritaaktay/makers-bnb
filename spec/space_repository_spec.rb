require 'space_repository'

def reset_request_table
  seed_sql = File.read('spec/seeds/test_seeds.sql')
  if ENV['PGPASSWORD'].nil?
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  else
    connection = PG.connect({
      host: '127.0.0.1', dbname: 'makersbnb_test',
      user: ENV['PGUSERNAME'], password: ENV['PGPASSWORD'] })
  end
  connection.exec(seed_sql)
end

describe SpaceRepository do
  before(:each) do
    reset_request_table
  end
  let(:repo) {SpaceRepository.new}

  it 'returns all spaces' do

    spaces = repo.all

    expect(spaces.length).to eq 5
    expect(spaces.first.id).to eq 1
    expect(spaces.first.user_id).to eq 1
    expect(spaces.first.name).to eq 'Super fancy awesome apartment'
    expect(spaces.first.description).to eq (
      'The best in the neighbourhood, large fridge and awesome view.')  
  end

  describe '#create' do
    it 'creates a record from Space class' do
      space = Space.new
      space.user_id = 1
      space.name = 'Space name'
      space.description = 'The best space ever'
      repo.create(space)
      
      expect(repo.all.length).to eq 6
      last_space = repo.all.last

      expect(last_space.id).to eq 6
      expect(last_space.user_id).to eq 1
      expect(last_space.name).to eq 'Space name'
      expect(last_space.description).to eq 'The best space ever'
    end
  end

  context '#find(id)' do
    it 'finds the space with the id given' do
      space = repo.find(1)
      expect(space.name).to eq 'Super fancy awesome apartment'
      expect(space.description).to eq 'The best in the neighbourhood, large fridge and awesome view.'
    end
  end
end