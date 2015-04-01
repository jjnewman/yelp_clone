class ReviewsController < ApplicationController

def new
  @restaurant = Restaurant.find(params[:restaurant_id])
  @review = Review.new
  #add if current_user_has_reviewd ----> notice: you have already reviewed
end

def create
  @restaurant = Restaurant.find(params[:restaurant_id])
  @restaurant.reviews.create(review_params)
  redirect_to restaurants_path
end

# if current_user_has_reviewed

#   end

def review_params
  params.require(:review).permit(:thoughts, :rating)
end


end
