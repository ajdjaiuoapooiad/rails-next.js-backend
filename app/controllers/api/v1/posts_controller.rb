class Api::V1::PostsController < ApplicationController
  def index
    # @posts = Post.all 
    # render json: @posts
    if params[:title] == nil ;
      @posts = Post.all  # if no title is provided, return all posts
    else
      @title = params[:title] 
      @posts = Post.where(title: @title)  # if title is provided, filter posts by title
    end
    
    render json: @posts 

  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :category, :income)
  end

  
end
