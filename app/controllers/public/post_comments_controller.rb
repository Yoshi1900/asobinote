class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.build(post_comment_params)
    @post_comment.user = current_user

    if @post_comment.save
      redirect_to post_path(@post)
    else
      flash[:alert] = 'コメントの追加に失敗しました。'
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    flash[:notice] = 'コメントが削除されました。'
    redirect_to post_path(@post_comment.post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,
                                         :user_id,
                                         :post_id
                                        )
  end

  def authorize_user!
    redirect_to post_path(@post_comment.post), alert: '削除権限がありません。' unless @post_comment.user == current_user
  end
end
  
  