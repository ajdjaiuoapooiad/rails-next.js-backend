class Api::V1::PostsController < ApplicationController
  def index
    # @posts = Post.all 
    # render json: @posts

    if  params[:category] == 'all'
      params[:category] = nil
    end
    if params[:income] == 'all'
        params[:income] = nil
    end
    if  params[:search] == ''
        params[:search] = nil
    end

    
    if params[:category] == nil && params[:income] == nil       # if no title is provided, return all posts;
      @posts = Post.all  # if no title is provided, return all posts
    else
      if params[:search] == nil  
        @title = params[:search] 
      end
      if params[:category] != nil 
        @category = params[:category] 
      end
      if params[:income] != nil 
        @income = params[:income] 
      end
      # @posts = Post.where( income: @income)
      @posts = Post.where('title LIKE ?', "%#{params[:search]}%").where(category: @category).where(income: @income)  # if title is provided, filter posts by title
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
