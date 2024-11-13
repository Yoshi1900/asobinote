class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    flash[:notice] = 'コメントが削除されました。'
    redirect_to admin_post_path(@post_comment.post)
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,
                                         :user_id,
                                         :post_id
                                        )
  end
  
end
