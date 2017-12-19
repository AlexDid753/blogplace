class Api::V1::RatingsController < ApplicationController
  respond_to :json, :html

  def create
    rating = Rating.new(rating_params)
    if rating.save
      Post.find(params[:post_id]).update_rating_column
      render json: rating, status: 200, location: [:api_v1_ratings]
    else
      render json: { errors: rating.errors }, status: 422
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:post_id,:rating_value)
  end
end
