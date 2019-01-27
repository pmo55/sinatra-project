class UserController < ApplicationController

get '/signup' do
  if !logged_in?
    erb:'user/create_reviewer'
  end
end

end
