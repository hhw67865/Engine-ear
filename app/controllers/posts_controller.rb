class PostsController < ApplicationController
  
  skip_before_action :authorize, only: [:index,:create]

  def index
    render json: Post.all.order(created_at: :desc), status: :ok
  end
  
  def show
    post = Post.find(params[:id])
    render json: post, status: :ok
  end

  def create
    post = Post.create!(post_params)
    render json: post, status: :created
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    render json: post, status: :accepted
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: {}, status: :no_content
  end

  private

  def post_params
    params.permit(:title, :post_body, :user_id, :picture_url)
  end

end
