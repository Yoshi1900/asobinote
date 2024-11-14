class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tags = Tag.order(:name).page(params[:page]).per(100)
  end

   def destroy
      @tag = Tag.find(params[:id])
      if @tag.destroy
        flash[:notice] = 'タグが削除されました。'
        redirect_to admin_tags_path
      else
        flash[:alert] = 'タグの削除に失敗しました。'
        redirect_to admin_tags_path
      end
    end

end
