require 'sinatra/base'
require 'sinatra/reloader'
require './lib/database_connection'
require './lib/user_repo'
require './lib/user'
require './lib/space'
require './lib/space_repository'


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
    # Currently a place holder for spaces/new for testing
    return erb :index, :layout => :main_layout
  end
end