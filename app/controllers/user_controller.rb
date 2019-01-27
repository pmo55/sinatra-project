class UserController < ApplicationController

get '/signup' do
  if !logged_in?
    erb:'user/create_reviewer'
  end
end

post '/signup' do
  if params[:username] == "" || params[:email]== "" || params[:password]==""
    redirect to '/signup'
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

get '/logout' do
if logged_in?
  session.clear
  redirect to '/login'
else
  redirect to '/'
end

end


end