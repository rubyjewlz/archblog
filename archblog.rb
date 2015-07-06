require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup'
require 'rack-flash'

configure(:development){set :database, "sqlite3:ardemo.sqlite3"}

set :sessions, true

use Rack::Flash, sweep: true

def current_user
  if session[:user_id]
    User.find session[:user_id]
  end
end

get '/' do
 erb :login
end

post '/login' do
  @user = User.find_by_username(params[:username])
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    params = nil
    redirect "/landing"
  else
    flash[:notice] = "Incorrect Password!"
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do

   @user = User.create(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password]) 
   flash[:notice] = "#{@user.username} you are signed up!"
   redirect '/'
 
end

get '/landing' do
#   # if current_user
  @posts = Post.all
	erb :landing
#   #  flash[:notice] = "Welcome, #{@user.username}!"
#   # else
#   #   redirect '/login'
#   # end
end

post '/landing' do
  current_user.posts.create(params[:post])
  redirect "/landing"
end

#   begin
#   if description.length > 150
#     raise "Description too Long"
#   else
#     @user_post.update_attributes params[:user_post]
#   end
# rescue 
#   flash[:notice] ="Description too Long"
# end


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