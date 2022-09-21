require 'listing'
require 'listing_repository'

RSpec.describe ListingRepository do
  before(:each) do
    sql = File.read('spec/seeds/test_seeds.sql')
    connection = PG.connect({ host:'127.0.0.1', dbname:'makersbnb_test' })
    connection.exec(sql)
  end

  let(:repo) {ListingRepository.new}

  it 'gets all listings' do
    listings = repo.all #Array of Listing objects
    expect(listings.length).to eq 4
    expect(listings[0].price_per_night).to eq 25
    expect(listings[0].availability).to eq [Date.parse("2022-09-10"), 
      Date.parse("2022-09-11"),
      Date.parse("2022-09-12"),
      Date.parse("2022-09-20"), 
      Date.parse("2022-09-21")]
    expect(listings[0].space_id).to eq 1
  end

  it 'creates a new listing' do
  end

  it 'marks a date as unavailable' do
  end
end