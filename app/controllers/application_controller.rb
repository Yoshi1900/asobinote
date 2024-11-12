class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 管理者の認証用メソッド
  def authenticate_admin!
    unless admin_signed_in?
      flash[:alert] ="管理者としてログインしてください。"
      redirect_to new_admin_session_path
    end
  end

  # 通常ユーザーの認証用メソッド
  def authenticate_user!
    unless user_signed_in?
      flash[:alert] = "ログインしてください。"
      redirect_to new_user_session_path
    end
  end
    def after_sign_in_path_for(resource)
      case resource
        when Admin
          admin_users_path
        when User
          mypage_path
      end
    end
  

    def after_sign_out_path_for(resource_or_scope)
      about_path # サインアウト後に遷移するページを指定
    end


    def search
      @range = params[:range]
  
      if @range == "ユーザー"
        @users = User.looks(params[:search], params[:word])
      elsif @range == "遊び場"
        @playgrounds = Playground.looks(params[:search], params[:word])
      elsif @range == "投稿"
        @posts = Post.looks(params[:search], params[:word])
      elsif @range == "タグ"
        @tags = Tag.looks(params[:search], params[:word])
      elsif @range == "コメント"
        @post_comments = Post_comment.looks(params[:search], params[:word])
      else
      end
    end
  
  # タグ文字列を空白や記号で分割し、クリーンな配列に変換するヘルパーメソッド
  def parse_tags(tag_string)
    tag_string.present? ? tag_string.split(/[,\s;:#\u3000\uFF1A\uFF0C\uFF03]+/).map(&:strip) : []
  end

  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email,  
                                                         :password,
                                                         :nickname, 
                                                         :phone_number, 
                                                         :introduction, 
                                                         :avatar_image,
                                                         :is_active
                                                         ])
    end
end
