class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = Post.where(is_displayed: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user # 現在ログインしているユーザーを割り当てる想定
    if @post.save
      flash[:notice] = '投稿が作成されました。'
      redirect_to @post
    else
      flash[:alert] = '投稿の作成に失敗しました。'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿の削除に成功しました'
    redirect_to playground_path(@post.playground) 
  end

  private

  def post_params
    params.require(:post).permit(:playground_id, 
                                 :title, 
                                 :body, 
                                 :star, 
                                 :is_displayed, 
                                 post_images: [])
  end
  
end