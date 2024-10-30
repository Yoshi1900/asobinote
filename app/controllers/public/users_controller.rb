class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def mypage
    
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
  
    private
    
    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.email == "guest@example.com"
       redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
  
end
