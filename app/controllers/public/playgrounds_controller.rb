class Public::PlaygroundsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :update]
  def new
    @playground = Playground.new
  end

  def index
    # @playgrounds = Playground.order(created_at: :desc).page(params[:page]).per(5)

    # respond_to do |format|
    #   format.html do
    #     @playgrounds = Playground.page(params[:page])
    #   end
    #   format.json do
    #     @playgrounds = Playground.all
    #   end
    # end
    @playgrounds = Playground.all
    @playrounds_json = @playgrounds.map { |o| playground_to_hash(o) }.to_json

  end
  
  def tagged
    # パラメータからタグを見つけ、そのタグに紐づいたPlaygroundを取得
    @tag = Tag.find(params[:tag_id])
    @playgrounds = @tag.playgrounds
  end

  def show
    # respond_to do |format|
    #   format.html do
         @playground = Playground.find(params[:id])  
         @playgrounds_pages = @playground.posts.page(params[:page]).per(5)
         @post = Post.new
         @tags = @playground.tags.pluck(:name).join(',')
    #   end
    #   format.json do
    #     @playgrounds = Playground.where(id: params[:id])  
    #     # render json: { data: { playground: @playgrounds }}
    #   end
    # end
    @playground_json = playground_to_hash(@playground).to_json
  end

  def edit
    @playground = Playground.find(params[:id])
    @tags = @playground.tags.pluck(:name).join(',')
  end
  
  def update
    @playground = Playground.find(params[:id])
    tags = parse_tags(params[:playground][:tag_id])

    if playground_params[:playground_images].present?
      combined_images = @playground.combined_images(params[:playground][:playground_images]) # 既存の画像と新しい画像を合わせて追加
      if combined_images.present?
        params[:playground][:playground_images].each do |new_image|
          @playground.playground_images.attach(new_image)
        end
      else
        render :edit and return
      end
    end

    if @playground.update(playground_params.except(:playground_images)) # 画像以外の属性を更新
      @playground.update_tags(tags)
      flash[:notice] = '遊び場が更新されました。'
      redirect_to @playground
    else
      flash[:alert] = '遊び場の更新に失敗しました。'
      render :edit
    end
  end

  def create
    @playground = Playground.new(playground_params)
    @user = current_user
    tags = parse_tags(params[:playground][:tag_id])

    if @playground.save
      @playground.update_tags(tags)
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
    else
      flash[:alert] = '画像が見つかりませんでした。'
    end
    redirect_to edit_playground_path(@playground)
  end  

  private
  
  def playground_params
    params.require(:playground).permit(:name, 
                                       :description,
                                       :tag_list,
                                       :post_code, 
                                       :address, 
                                       :phone_number, 
                                       :is_active, 
                                       :user_id,
                                       :latitude,
                                       :longitude,
                                       playground_images: []).tap do |playground_params|
                                        playground_params[:user_id] = current_user.id if current_user.present?
                                      end
  end
  def playground_to_hash(playground)
    { id: playground.id,
      name: playground.name,
      lat: playground.latitude,
      lng: playground.longitude }
  end

end