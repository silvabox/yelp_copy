class ReviewsController < ApplicationController

  before_action :authenticate_user!


  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed?(@restaurant)
      flash[:notice] = "You have already reviewed this restaurant"
      redirect_to '/'
    else
       @review = @restaurant.reviews.new
       render 'new'
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)
    if @review.save 
      redirect_to '/' 
    else
      render 'new'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user == current_user
      @review.destroy
      flash[:notice] = "Review deleted successfully"
    else
      flash[:notice] = "You cannot delete this review"
    end
    redirect_to '/'
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
