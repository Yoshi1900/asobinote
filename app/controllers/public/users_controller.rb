class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  

  def edit
    unless @user == current_user
      redirect_to user_path(@user) #ログインユーザー以外のページだとマイページにリダイレクト
    end
  end

  def show
  end

  def mypage
    redirect_to user_path(current_user)
  end

  def update
    @user = current_user
    @user.avatar.attach(params[:avatar_image]) if params[:avatar_image].present?
   # パスワードが入力された場合のみ更新
    if user_params[:password].present?
      if @user.update(user_params)
        flash[:notice] = "プロフィールが更新されました。"
        redirect_to user_path(current_user)
      else
        flash[:alert] = "プロフィールの更新に失敗しました。"
        render :edit
      end
    else
      # パスワードが空の場合、パスワード以外の情報のみ更新
      if @user.update(user_params.except(:password, :password_confirmation))
        flash[:notice] = "プロフィールが更新されました。"
        redirect_to user_path(current_user)
      else
        flash[:alert] = "プロフィールの更新に失敗しました。"
        render :edit
      end
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session

    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
    
  def user_params
    params.require(:user).permit(:nickname,
                                 :introduction, 
                                 :phone_number, 
                                 :email,
                                 :password, 
                                 :password_confirmation,
                                 :avatar_image)
  end

  def set_user
    if params[:id] == "my_page"
      @user = User.find(current_user.id)
    else
      @user = User.find(params[:id])
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
     redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
  
end
