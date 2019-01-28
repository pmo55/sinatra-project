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
      rating = params[:rating].to_i
      if params[:product_name]== "" || params[:content]== "" || rating > 10 || rating < 0 || rating == 0
        redirect to 'reviews/new'
      else
        @review = Review.create(product_name: params[:product_name], content: params[:content], rating: rating)
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