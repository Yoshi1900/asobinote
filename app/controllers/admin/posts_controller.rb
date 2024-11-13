class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
    @posts = Post.page(params[:page]).per(5)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿が更新されました。"
      redirect_to admin_post_path(@post)
    else
      flash[:alert] = "投稿の更新に失敗しました。"
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿が削除されました。"
      redirect_to admin_playground_path(@post.playground) 
    else
      flash[:alert] = "投稿の削除に失敗しました。"
      redirect_to admin_playground_path(@post.playground) 
    end
  end

  private

  def post_params
    params.require(:post).permit(:playground_id, 
                                 :title, 
                                 :body,
                                 :tag_list,
                                 :star, 
                                 :is_displayed, 
                                 post_images: [])
  end

end
