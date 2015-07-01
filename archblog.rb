require 'sinatra'
require 'sinatra/activerecord'
require './models'


set :database, "sqlite3:archblog.sqlite3"

get '/signup' do
 erb :signup
end

post '/signup' do
 confirmation = params[:confirm_password]

 if confirmation == params[:user][:password]
   @user = User.create(params[:user])
   "SIGNED UP #{@user.username}"
 else
   "Your password & confirmation did not match, try again"
 end

 
end