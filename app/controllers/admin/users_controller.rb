class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.order(created_at: :desc)
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.avatar.attach(params[:avatar_image]) if params[:avatar_image].present?
  
    if @user.update(user_params)
      flash[:notice] = "プロフィールが更新されました。"
      redirect_to admin_user_path(@user)
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

private


def user_params
  params.require(:user).permit(:nickname,
                               :introduction, 
                               :phone_number, 
                               :email,
                               :is_active,
                               :password, 
                               :password_confirmation,
                               :avatar_image)
end

end
