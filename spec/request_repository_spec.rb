require 'spec_helper'
require 'request_repository'
require 'request'

def reset_request_table
  seed_sql = File.read('spec/seeds/seed_requests.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe RequestRepository do
  before(:each) do
    reset_request_table
  end

  it 'should return all requests' do
    requests = RequestRepository.new
    result = requests.all
    expect(result.count).to eq 9
  end

  it 'should return a request by id' do
    requests = RequestRepository.new
    result = requests.find(1)
    expect(result.id).to eq 1
    expect(result.listing_id).to eq 1
  end

  it 'should create a new request' do
    requests = RequestRepository.new
    request = Request.new
    request.date = '2022-1-1'
    request.user_id = 1
    request.listing_id = 1
    request.current_status = 'pending'
    result = requests.create(request)
    expect(result.id).to eq 10
  end

  it 'should update a request' do
    requests = RequestRepository.new
    request = Request.new
    request.id = 1
    request.date = '2022-1-1'
    request.user_id = 1
    request.listing_id = 1
    request.current_status = 'pending'
    result = requests.update(request)
    expect(result.id).to eq 1
    expect(result.current_status).to eq 'pending'
  end

  it 'should delete a request' do
    requests = RequestRepository.new
    result = requests.delete(1)
    expect(result).to eq true
    expect(requests.all.count).to eq 8
  end

end