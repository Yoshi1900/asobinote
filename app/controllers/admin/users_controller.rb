class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.avatar.attach(params[:avatar_image]) if params[:avatar_image].present?
  
    if @user.update(user_params)
      bypass_sign_in(@user)
      flash[:notice] = "プロフィールが更新されました。"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "プロフィールの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
  @user = User.find(params[:id])
  if @user.destroy
    flash[:notice] = "ユーザーが削除されました。"
    redirect_to admin_users_path
  else
    flash[:alert] = "ユーザーの削除に失敗しました。"
    redirect_to admin_user_path(@user)
  end
end
end
