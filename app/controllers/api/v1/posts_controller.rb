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
    post = Post.find_by_sql ["SELECT title,text FROM posts WHERE rating <= ? ORDER BY rating DESC LIMIT ?", params[:rating], params[:limit]]
    render json: post, status: 200
  end

  def ips
    leery_ips = ActiveRecord::Base.connection.execute("SELECT ip_address, count(user_id)  FROM posts GROUP BY ip_address HAVING count(user_id) > 1")
    leery_users = find_leery_users(leery_ips)
    render json: leery_users, status: 200
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: 200, location: [:api_v1_user_posts]
    else
      render json: {errors: post.errors}, status: 422
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    head 204
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :text, :ip_address)
  end

  def find_leery_users(leery_ips)
    hash = Hash.new
    leery_ips.each do |leery_ip|
      leery_user = ActiveRecord::Base.connection.execute("SELECT user_id  FROM posts WHERE ip_address = '#{leery_ip['ip_address']}'")
      @leery_user_ids = []
      leery_user.each do |n|
        @leery_user_ids.push(n['user_id'])
      end
      hash.merge!({leery_ip['ip_address'] => @leery_user_ids})
    end
    return hash
  end
end
