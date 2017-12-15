class Api::V1::PostsController < ApplicationController
  respond_to :json, :html
  #curl -X POST -H 'Accept: application/json'  --data 'login=xyzwdawdawd' http://localhost:3000/api/v1/users
  #curl -X POST -H 'Accept: application/vnd.blogplace.v1' -H 'Content-Type: application/json'  -d 'user[login]=xyzwdawdawd' http://localhost:3000/api/v1/users

# #curl -H 'Accept: application/vnd.blogplace.v1' http://localhost:3000/api/v1/users/1
# curl -v -H "Accept: application/vnd.blogplace.v1" -H "Content-type: application/json" -X POST -d ' {"user_id": 1 ,"title":"title_curl","text":"text_curl","ip_address":1555151}' http://localhost:3000/api/v1/posts
  def index
    posts = Post.all
    render json: posts, status: 200
  end

  def show
    post = Post.find(params[:id])
    render json: post, status: 200
  end

  def top
    rating = params[:rating]
    limit = params[:limit]
    post = Post.find_by_sql ["SELECT title,text,rating FROM posts WHERE rating <= ? ORDER BY rating DESC LIMIT ?", rating, limit]
    #todo убрать rating из массива вызываемых данных. нужна для отладки. оставить только title,text
    render json: post, status: 200
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: 200, location: [:api_v1_user_posts]
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
    params.require(:post).permit(:user_id,:title, :text, :ip_address)
  end
end
