require 'database_connection'
require 'listing'

class ListingRepository 
  def all
    sql = 'SELECT * FROM listings'
    results = DatabaseConnection.exec_params(sql, [])
    listings = []
    results.each do |record|
      listing = Listing.new
      listing.id = record['id'].to_i
      listing.price_per_night = record['price_per_night'].to_i
      # converts string into an array of Date obejects
      dates = record['availability']
      array = dates[1...dates.length-1].split(",")
      listing.availability = array.map!{ |date| Date.parse(date)}
      listing.space_id = record['space_id'].to_i
      listings << listing
    end
    return listings
  end

  def create
  end

  def mark_unavailabel(date) #string or Date object?
  end
end