require 'sinatra'
require 'sinatra/activerecord'
require './models'


set :database, "sqlite3:archblog.sqlite3"

get '/' do
 erb :login
end

get '/signup' do
	erb :signup
end

post '/login' do
 confirmation = params[:confirm_password]

 if confirmation == params[:password]
   username = params[:username]
   password = params[:password]
   @user = User.create(username: username, password: password)
   "SIGNED UP #{@user.username}"
 else
   "Your password & confirmation did not match, try again"
 end
end

get '/landing' do
	erb :landing
end

get '/profile' do
	erb :profile
end