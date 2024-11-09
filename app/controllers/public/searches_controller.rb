class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @search_word = params[:word]
    @range = params[:range]
    @search_type = params[:search] 

    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "遊び場"
      @playgrounds = Playground.looks(params[:search], params[:word])
    elsif @range == "投稿"
      @posts = Post.looks(params[:search], params[:word])
    elsif @range == "タグ"
      @tags = Tag.looks(params[:search], params[:word])
    elsif @range == "コメント"
      @post_comments = PostComment.looks(params[:search], params[:word])
    else
    end
  end
end

