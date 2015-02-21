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
    @review = @restaurant.reviews.create(review_params)
    @review.update(:user_id => current_user.id)
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
    p @restaurant
    p @review
    if @review.user_id == current_user.id
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
