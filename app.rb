require 'sinatra/base'
require 'sinatra/reloader'
require './lib/database_connection'
require './lib/user_repo'
require './lib/user'
require './lib/space'
require './lib/space_repository'
require './lib/listing_repository'
require './lib/listing'


DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    return erb :index, :layout => :main_layout
  end

  post '/signup' do
    repo = UserRepository.new
    user = User.new
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    user = repo.create(user)
    session[:user_id] = user.id
    redirect '/spaces'
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all

    return erb :spaces, :layout => :main_layout
  end

  post '/spaces' do
    
    redirect '/spaces/new'
  end

  get '/spaces/new' do
    return erb :new_space, :layout => :main_layout
  end

  post '/spaces/new' do
    repo = SpaceRepository.new
    space = Space.new 
    list_repo = ListingRepository.new
    listing = Listing.new

    space.name = params[:name]
    space.description = params[:description]
    listing.price_per_night = params[:price_per_night]
    # both are date objects
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    # a range of date obejects stored in an array
    listing.availability = (start_date..end_date).to_a
    listing.space_id = space.id

    repo.create(space)
    list_repo.create(listing)

    redirect '/spaces'
  end
end