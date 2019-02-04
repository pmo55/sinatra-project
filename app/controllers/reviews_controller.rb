require 'rack-flash'
class ReviewsController < ApplicationController
  use Rack::Flash
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
      if params[:product_name] == "" || params[:content] == "" || rating > 10 || rating < 0 || rating == 0
        flash[:message] = "Error, please fill out all fields properly."
        redirect to 'reviews/new'
      else
        @review = Review.create(product_name: params[:product_name], content: params[:content], rating: rating)
        @review.user_id = session[:user_id]
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

  get '/reviews/:id' do
    @review = Review.find_by_id(params[:id])
    erb :'reviews/show_review'
  end

  get '/reviews/:id/edit' do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      if @review && @review.user == current_user
      erb :'reviews/edit_review'
      else
        flash[:message] = "You can not edit another author's post!"
        redirect to '/'
      end
    else
      redirect to '/'
    end
  end

  patch '/reviews/:id' do
    if logged_in?
      if params[:product_name] == "" || params[:content] == "" || params[:rating].to_i > 10 || params[:rating].to_i < 0 || params[:rating].to_i == 0
        flash[:message] = "Error, please fill out all fields properly."
        redirect to "/reviews/#{params[:id]}/edit"
      else
        @review = Review.find_by_id(params[:id])
        if @review && @review.user == current_user
          if @review.update(product_name: params[:product_name], content: params[:content], rating: params[:rating])
            redirect to "/reviews/#{params[:id]}"
          else
            redirect to "/"
          end
        else
          redirect to "/"
         end
        end
      else
       redirect to "/login"
      end
    end

  delete '/reviews/:id/delete' do
    if logged_in?
      @review = Review.find_by_id(params[:id])
        if @review && @review.user == current_user
          @review.delete
          flash[:message] = "Successfully Deleted!"
          redirect to '/'
        else
          flash[:message] = "You can not delete another author's post!"
          redirect to '/'
        end
    else
     redirect to '/login'
    end
   end
  end
