class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    tags = parse_tags(params[:post][:tag_id])
    if post_params[:post_images].present?
      @post.post_images.attach(playground_params[:post_images]) # 既存の画像を保持しつつ新しい画像を追加
    end
    if @post.update(post_params.except(:post_images))
      # @post.update_tags(tags)
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
    @post.post_comments.destroy_all
    if @post.destroy
      flash[:notice] = "投稿が削除されました。"
      redirect_to admin_playground_path(@post.playground) 
    else
      flash[:alert] = "投稿の削除に失敗しました。"
      redirect_to admin_playground_path(@post.playground) 
    end
  end

  def remove_image
    @post = Post.find(params[:id])
    image = @post.post_images.find(params[:image_id])
    image.purge # ActiveStorage の画像を削除するメソッド
  
    redirect_to edit_admin_post_path(@post), notice: '画像が削除されました。'
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
