class Public::TagsController < ApplicationController

  def index
    @tags = Tag.order(:name).page(params[:page]).per(80)
  end

end
