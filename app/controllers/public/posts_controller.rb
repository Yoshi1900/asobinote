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
      redirect_to @post, notice: '投稿が作成されました。'
    else
      render :new, alert: '投稿の作成に失敗しました。'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to playground_path(@post.playground), notice: '投稿の削除に成功しました'
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