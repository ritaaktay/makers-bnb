require 'request_repository'
require 'spec_helper'

def reset_requests_table
  seed_sql = File.read('spec/seed_requests.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe RequestRepository do

  before(:each) do
    reset_requests_table
  end

  it 'should return all requests' do
    requests = RequestRepository.new
    expect(requests.count).to eq 3
  end

end