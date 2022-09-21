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

  def create(listing)
    sql = 'INSERT INTO listings (price_per_night, availability, space_id) VALUES ($1, $2, $3) RETURNING id;'
    params = [listing.price_per_night, '{}', listing.space_id]
    result = DatabaseConnection.exec_params(sql, params)
    # the id of newly created listing in database
    id = result[0]["id"]
    # Date objects converted into strings in array
    date_strings = listing.availability.map { |date| "#{date.strftime("%Y-%m-%d")}"} 
    # Need array_append query per date to add dates to array
    date_strings.each do |date|
      sql = 'UPDATE listings SET availability = array_append(availability, $1) WHERE id = $2;'
      params = [date, id]
      DatabaseConnection.exec_params(sql, params)
    end
  end

  def mark_unavailable(listing, date) #date is a string "2022-10-09" from request.date
    #need an SQL query to remove item from array 
    #or overwrite the whole array if not possible
    date = Date.parse(date)
    # assuming order in listing.availability matches order in SQL array
    index = listing.availability.find_index(date)
    # fix query
    sql = 'UPDATE listings SET availability = ARRAY_DELETE ( availability, $1 ) WHERE id = $2;'
    params = [index, listing.id]
    DatabaseConnection.exec_params(sql,params)
  end
end