class Public::PostCommentsController < ApplicationController
  
  
  
  def create
    posts = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post_id
    comment.save
    redirect_to post_path(posts)
  end

  def destroy
    posts = Post.find(params[:post_id])
    comment = Comment.find(params[:gurume_id])
    comment.destroy
    redirect_to post_path(posts)
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
