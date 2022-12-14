require 'sinatra/base'
require 'sinatra/reloader'
require './lib/database_connection'
require './lib/user_repo'
require './lib/user'
require './lib/request'
require './lib/request_repository'
require './lib/space'
require './lib/space_repository'
require './lib/listing_repository'
require './lib/listing'
require './lib/request.rb'
require './lib/request_repository.rb'


DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  ############################## HOME/SIGNUP ##############################

  get '/' do
    if session[:user_id].nil?
      return erb :index, :layout => :main_layout
    else
      redirect '/spaces'
    end
  end

  post '/signup' do
    if session[:user_id].nil?
      repo = UserRepository.new
      user = User.new
      user.username = params[:username]
      user.email = params[:email]
      user.password = params[:password]
      user = repo.create(user)
      session[:user_id] = user.id
      redirect '/spaces'
    else
      redirect '/spaces'
    end
  end

  ############################## LOG IN / LOG OUT ##############################

  get '/sessions/login' do
    if session[:user_id].nil?
      return erb :login
    else
      redirect '/spaces'
    end
  end

  post '/sessions/login' do
    repo = UserRepository.new
    user = repo.find_by_email(params[:email])
    if user.password == params[:password]
      session[:user_id] = user.id
      # /spaces currently still a placeholder until it is created
      redirect '/spaces'
    else
      redirect '/sessions/login'
    end
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  ############################## SPACES ##############################
  
  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all
    if session[:user_id].nil?
      return erb :login
    else
      return erb :spaces, :layout => :main_layout
    end 
  end

  post '/spaces' do
    redirect '/spaces/new'
  end

  get '/spaces/new' do
    if session[:user_id].nil?
      return erb :login
    else
      return erb :new_space, :layout => :main_layout
    end 
  end

  post '/spaces/new' do
    repo = SpaceRepository.new
    space = Space.new 
    list_repo = ListingRepository.new
    listing = Listing.new

    space.user_id = session[:user_id]
    space.name = params[:name]
    space.description = params[:description]
    listing.price_per_night = params[:price_per_night]
    # both are date objects
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    # a range of date obejects stored in an array
    listing.availability = (start_date..end_date).to_a
    listing.space_id = repo.create(space)
 
    list_repo.create(listing)

    redirect '/spaces'
  end

  get '/spaces/:id' do
    
    if session[:user_id].nil?
      return erb :login
    else
      id = params[:id]
      @user_id = session[:user_id]
      repo = SpaceRepository.new
      @space = repo.find(id)
      listing_repo = ListingRepository.new
      @listings = listing_repo.find_by_space(@space.id)
      return erb :space, :layout => :main_layout
    end
  end
  ############################## REQUESTS ##############################

  get '/requests' do
    if session[:user_id].nil?
      redirect '/'
    else
      repo = UserRepository.new
      @requests_made = repo.requests_made(session[:user_id])
      @requests_received = repo.requests_received(session[:user_id])
      return erb :requests, :layout => :main_layout
    end
  end

  get '/requests/:id' do
    request_repo = RequestRepository.new 
    listing_repo = ListingRepository.new 
    space_repo = SpaceRepository.new 
    user_repo = UserRepository.new
    @requests = request_repo.find(params[:id])
    @users = user_repo.find(@requests.user_id)
    listing = listing_repo.find(@requests.listing_id)
    # binding.irb
    @spaces = space_repo.find(listing.space_id)
    return erb :request, :layout => :main_layout
  end

  post '/requests' do
    request = Request.new
    
    request.user_id = params[:user_id]
    request.listing_id = params[:listing_id]
    request.date = params[:date]
    request.current_status = 'pending'

    repo = RequestRepository.new
    repo.create(request)
    redirect '/requests'
  end

end
