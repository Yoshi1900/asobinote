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
    # アップデートがうまくいけば、マイページに戻り、
    # うまくいかなければ、もう一度編集ページを表示する
   if current_user.update(user_params)
     redirect_to user_path(current_user)
    else
     redirect_to edit_user_path(current_user)
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
