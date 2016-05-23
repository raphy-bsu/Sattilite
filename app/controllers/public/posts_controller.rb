class Public::PostsController < ApplicationController
  def index
    @posts = Post.paginate(:page => params[:page], per_page: 5)
  end

  def show
    @post = Post.find(params[:id])
  end
end
