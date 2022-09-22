require 'user'
require 'user_repo'

RSpec.describe UserRepository do
  let(:repo) {UserRepository.new}

  before(:each) do
    sql = File.read('spec/seeds/test_seeds.sql')
    if ENV['PGPASSWORD'].nil?
      connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    else
      connection = PG.connect({
        host: '127.0.0.1', dbname: 'makersbnb_test',
        user: ENV['PGUSERNAME'], password: ENV['PGPASSWORD'] })
    end
    connection.exec(sql)
  end

  it 'creates a user' do
    user = User.new
    user.username = "Moses Osho"
    user.password = "beanbags"
    user.email = "moses@gmail.com"
    repo.create(user)
    new_user = repo.find(5)
    expect(new_user.username).to eq "Moses Osho"
    expect(new_user.password).to eq "beanbags"
    expect(new_user.email).to eq "moses@gmail.com"
  end

  it 'finds a user by id' do
    user = repo.find(2)
    expect(user.username).to eq 'Thomas Mannion'
    expect(user.password).to eq 'coffee'
    expect(user.email).to eq 'thomas@gmail.com'
  end

  it 'finds a user by email' do
    user = repo.find_by_email('thomas@gmail.com')
    expect(user.username).to eq 'Thomas Mannion'
    expect(user.password).to eq 'coffee'
    expect(user.email).to eq 'thomas@gmail.com'
  end
end
