require 'sinatra/base'
require 'sinatra/reloader'
require './lib/database_connection'
require './lib/user_repo'
require './lib/user'
require './lib/request'
require './lib/request_repository'
require './lib/space'
require './lib/space_repository'


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
      return erb :login, :layout => :main_layout
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

    return erb :spaces, :layout => :main_layout
  end

  post '/spaces' do
    
    redirect '/spaces/new'
  end

  get '/spaces/new' do
    # Currently a place holder for spaces/new for testing
    return erb :index, :layout => :main_layout
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
end
