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
    leery_ips = ActiveRecord::Base.connection.execute("SELECT ip_address, count(login)  FROM posts GROUP BY ip_address HAVING count(login) > 1")
    leery_users = find_leery_users(leery_ips)
    render json: leery_users, status: 200
  end

  def create
    params[:ip_address] = request.remote_ip
    if !login_exist?
      User.new(params[:login])
    end
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
    params.require(:post).permit(:login, :title, :text, :ip_address)
  end

  def find_leery_users(leery_ips)
    hash = Hash.new
    leery_ips.each do |leery_ip|
      leery_user = ActiveRecord::Base.connection.execute("SELECT login  FROM posts WHERE ip_address = '#{leery_ip['ip_address']}'")
      @leery_user_logins = []
      leery_user.each do |n|
        @leery_user_logins.push(n['login'])
      end
      hash.merge!({leery_ip['ip_address'] => @leery_user_logins})
    end
    return hash
  end

  def login_exist?
    User.find_by(login: params[:login]).present?
  end
end
