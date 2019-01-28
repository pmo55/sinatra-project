class ReviewsController < ApplicationController
  
  get '/reviews/new' do
    if logged_in?
      erb :'reviews/create_review'
    else 
      redirect to '/signup'
    end
    
  end
  
  
end