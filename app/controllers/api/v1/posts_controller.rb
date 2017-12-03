class Api::V1::PostsController < ApplicationController
  respond_to :json, :html
#curl -H 'Accept: application/vnd.blogplace.v1' http://localhost:3000/api/v1/users/1
  def index
    posts = Post.all
    render json: posts, status: 200
  end

  def show
    post = Post.find(params[:id])
    render json: post, status: 200
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: 200, location: [:api, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    head 204
  end

  private

  def post_params
    params.require(:post).permit(:user_id,:title, :text, :ip_address, :rating)
  end
end
