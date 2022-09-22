require 'sinatra/base'
require 'sinatra/reloader'
require './lib/database_connection'
require './lib/user_repo'
require './lib/user'

DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  ############################## HOME/SIGNUP ##############################

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

  ############################## LOG IN / LOG OUT ##############################

  get '/sessions/login' do
    return erb :login, :layout => :main_layout
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
    # Currently a place holder for spaces for testing
    return erb :index, :layout => :main_layout
  end
end
