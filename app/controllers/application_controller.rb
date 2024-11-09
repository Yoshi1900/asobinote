class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
    def after_sign_in_path_for(resource)
      case resource
        when Admin
          admin_users_path
        when User
          mypage_path
      end
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
