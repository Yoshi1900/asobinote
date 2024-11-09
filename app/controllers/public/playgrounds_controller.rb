class Public::PlaygroundsController < ApplicationController
  def new
    @playground = Playground.new
  end

  def index
    @playgrounds = @playgrounds = Playground.where(is_active: true).order(created_at: :desc)
    @playgrounds_pages = Playground.page(params[:page]).per(5)
  end
  
  def tagged
    # パラメータからタグを見つけ、そのタグに紐づいたPlaygroundを取得
    @tag = Tag.find(params[:tag_id])
    @playgrounds = @tag.playgrounds
  end

  def show
    @playground = Playground.find(params[:id])  
    @playgrounds_pages =@playground.posts.page(params[:page]).per(5)
    @post = Post.new
    @tags = @playground.tags.pluck(:name).join(',')

  end

  def edit
    @playground = Playground.find(params[:id])
    @tags = @playground.tags.pluck(:name).join(',')
  end
  
  def update
    @playground = Playground.find(params[:id])
    tags = params[:playground][:tag_id].present? ? params[:playground][:tag_id].split(/[,\s;:#\u3000\uFF1A\uFF0C\uFF03]+/).map(&:strip) : []
    if playground_params[:images].present?
      @playground.images.attach(playground_params[:images]) # 既存の画像を保持しつつ新しい画像を追加
    end
    if @playground.update(playground_params.except(:images)) # 画像以外の属性を更新
      @playground.update_tags(tags)
      flash[:notice] = '遊び場が更新されました。'
      redirect_to @playground
    else
      render :edit
    end
  end

  def create
    @playground = Playground.new(playground_params)
    @user = current_user
    tags = params[:playground][:tag_id].present? ? params[:playground][:tag_id].split(/[,\s;:#\u3000\uFF1A\uFF0C\uFF03]+/).map(&:strip) : []
    if @playground.save
      flash[:notice] = '遊び場が作成されました。'
      redirect_to @playground
    else
      render :new
    end
  end
  
  def remove_image
    @playground = Playground.find(params[:id])
    image = @playground.playground_images.find(params[:image_id]) if params[:image_id].present?
  
    if image
      image.purge
       flash[:notice] = '画像が削除されました。'
      redirect_to edit_playground_path(@playground)
    else
      flash[:alert] = '画像が見つかりませんでした。'
      redirect_to edit_playground_path(@playground)
    end
  end  



  private
  
  def playground_params
    params.require(:playground).permit( :name, 
                                        :description,
                                        :post_code, 
                                        :address, 
                                        :phone_number, 
                                        :is_active, 
                                        :user_id,
                                        :tag_list, 
                                         playground_images: [])
  end

end
