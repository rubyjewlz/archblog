require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup'
require 'rack-flash'

configure(:development){set :database, "sqlite3:ardemo.sqlite3"}

enable :sessions

use Rack::Flash, sweep: true

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
  # if current_user
	 erb :landing
  #  flash[:notice] = "Welcome, #{@user.username}!"
  # else
  #   redirect '/login'
  # end
end

post '/landing' do
  
  # @user_post = User_post.find params[:posts] 
  
  current_user.posts.create(params[:posts])

#   begin
#   if description.length > 150
#     raise "Description too Long"
#   else
#     @user_post.update_attributes params[:user_post]
#   end
# rescue 
#   flash[:notice] ="Description too Long"
# end
end

get '/profile' do
	erb :profile
end

post '/profile' do

end

delete '/profile/:id' do
  session[:user_id]=nil
  current_user.delete
  redirect '/login'
end

def current_user
  if session[:user_id]
    User.find session[:user_id]
  end
end