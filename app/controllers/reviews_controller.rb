class ReviewsController < ApplicationController
  
  get '/reviews/new' do
    if logged_in?
      erb :'reviews/create_review'
    else 
      redirect to '/'
    end
    
  end
  
  post '/reviews' do
    if logged_in?
      if params[:product_name]== "" || params[:content]=="" || params[:rating].to_i > 10 || params[:rating].to_i < 0
        redirect to '/reviews/create_review'
      else
        @review.product_name = params[:product_name]
        @review.content = params[:content]
        @review.rating = params[:rating]
        if @review.save
          redirect to "/reviews/#{@review.id}"
        else 
          redirect to "/reviews/create_review"
        end
      end
    else
      redirect to '/'
    end
  end
  
  
end