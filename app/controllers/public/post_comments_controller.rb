class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.build(post_comment_params)
    @post_comment.user = current_user

    if @post_comment.save
      redirect_to request.referer
    else
      flash[:alert] = 'コメントの追加に失敗しました。'
      redirect_to request.referer
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    if @post_comment.user == current_user
       @post_comment.destroy
       redirect_to post_path(@post_comment.post)
    else
       flash[:alert] = '削除権限がありません。'
       redirect_to post_path(@post_comment.post)
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,
                                         :user_id,
                                         :post_id
                                        )
  end

end
  
  