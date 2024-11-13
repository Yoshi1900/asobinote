class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tags = Tag.order(:name).page(params[:page]).per(100)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
