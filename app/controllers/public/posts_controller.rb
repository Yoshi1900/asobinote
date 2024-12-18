class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :update]
  before_action :authorize_user, only: [:destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.where(is_displayed: true).order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    tags = parse_tags(params[:post][:tag_list]) # parse_tagsを使用してタグを分割
    if @post.save
      @post.update_tags(tags) # Postモデルで定義したメソッドでPostにタグを関連付け
      @post.playground.post_update_tags(tags) # Playgroundモデルで定義したメソッドでPlaygroundにも同じタグを関連付け
      redirect_to @post
    else
      flash[:alert] = '投稿の作成に失敗しました。'
      redirect_to playground_path(@post.playground)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.post_comments.destroy_all
    @post.destroy
    flash[:notice] = '投稿の削除に成功しました'
    redirect_to playground_path(@post.playground) 
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
  
  def authorize_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:alert] = '権限がありません。'
      redirect_to playground_path(@post.playground)
    end
  end
end