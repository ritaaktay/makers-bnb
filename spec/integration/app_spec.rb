require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

def session_tracker
  last_request.env['rack.session']
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<label for="username">Username</label>')
      expect(response.body).to include('<input type="submit" value="Sign up">')
    end
  end

  context 'POST /signup' do
    it 'should create a new user' do
      response = post('/signup', 
                params = {username: 'test', 
                          email: 'test@test.com', 
                          password: 'test'})
      repo = UserRepository.new
      user = repo.find(5)

      expect(response.status).to eq 302
      expect(user.username).to eq 'test'

      response = get('/')
      expect(response.body).to include('<a href="/sessions/logout">Logout</a>')
    end
  end

  describe 'GET /sessions/login' do
    it 'should GET the login page' do
      response = get('/sessions/login')

      expect(response.status).to eq(200)
      expect(response.body).to include('<label for="email">Email</label>')
      expect(response.body).to include('<input type="submit" value="Login">')
    end
  end

  describe 'POST /sessions/login' do
    it 'on successful login should POST to /sessions/login' do
      response = post('/sessions/login', 
                params = {email: 'thomas@gmail.com', password: 'coffee'})
      expect(response.status).to eq 302
      response = get('/')
      expect(response.status).to eq 200
      expect(response.body).to include('<a href="/sessions/logout">Logout</a>')
      expect(session_tracker[:user_id]).to eq 2
    end

    it 'should send to login on wrong password' do
      response = post('/sessions/login', 
                params = {email: 'thomas@gmail.com', password: 'no coffee'})
      expect(response.status).to eq 302
      response = get('/sessions/login')
      expect(response.status).to eq 200
      expect(response.body).to include('<a href="/sessions/login">Login</a>')
      expect(response.body).to include('<form action="/sessions/login"')
      expect(session_tracker[:user_id]).to eq nil
    end
  end

  describe 'GET /sessions/logout' do
    it 'should log out the user' do
      response = post('/sessions/login', 
                params = {email: 'thomas@gmail.com', password: 'coffee'})
      expect(response.status).to eq 302
      expect(session_tracker[:user_id]).to eq 2
      response = get('/sessions/logout')
      expect(response.status).to eq 302
      expect(session_tracker[:user_id]).to eq nil
      end
    end
    
  context 'GET /spaces' do 
    it 'should list the spaces' do
      response  =  get('/spaces')

      expect(response.status).to eq 200
      expect(response.body).to include ('<input type="submit" value="List a Space">')
    end
  end
  
 
  context 'POST /spaces' do
    it 'should redirect to spaces new' do
      response = post('/spaces')

      expect(response.status).to eq 302
    end
  end
end

