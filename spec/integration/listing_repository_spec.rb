require 'listing'
require 'listing_repository'

RSpec.describe ListingRepository do
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

  let(:repo) {ListingRepository.new}

  it 'gets all listings' do
    listings = repo.all 
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
    listing = Listing.new
    listing.price_per_night = 100
    listing.availability = [Date.parse('2022-09-21'), Date.parse('2022-09-22')]
    listing.space_id = 1
    repo.create(listing)
    listings = repo.all
    expect(listings.length).to eq 5
    expect(listings.last.price_per_night).to eq 100
    expect(listings.last.availability).to eq [Date.parse('2022-09-21'), Date.parse('2022-09-22')]
    expect(listings.last.space_id).to eq 1
  end

  it 'marks a date as unavailable' do
    listing = repo.all[0]
    date = '2022-09-10'
    repo.mark_unavailable(listing, date)
    # second entry becomes the first element in the array
    listing = repo.all.last
    expect(listing.availability.length).to eq 4
    expect(listing.availability.select {|x| x == Date.parse(date)}).to eq []
  end
end