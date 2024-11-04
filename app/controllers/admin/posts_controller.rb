class Admin::PostsController < ApplicationController
  def index
  end

  def edit
  end

  def update
  end

  def show
    @post = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
  end
end
