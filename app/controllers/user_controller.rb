require 'rack-flash'
class UserController < ApplicationController
  use Rack::Flash
get '/signup' do
  if !logged_in?
    erb:'user/create_reviewer'
  end
end

post '/signup' do
  if params[:username] == "" || params[:email]== "" || params[:password] == ""
    flash[:message] = "Error, please complete all fields"
    erb:'user/create_reviewer'
  else
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect to '/'
  end
end

get '/login' do
  if !logged_in?
    erb:'user/login'
  end
end

post '/login' do
  @user = User.find_by(:email => params[:email])
   if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
    redirect to '/'
  else
    flash[:message] = "Login unsuccessful"
    erb :'/user/login'
  end

end


get '/logout' do
if logged_in?
  session.clear
  redirect to '/'
else
  redirect to '/'
end

end


end
