class Admin::PlaygroundsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @playgrounds = Playground.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @playground = Playground.new
  end

  def create
    @playground = Playground.new(playground_params)
    tags = parse_tags(params[:playground][:tag_id])

    if @playground.save
      @playground.update_tags(params[:playground][:tag_list])
      flash[:notice] = "新しい遊び場が作成されました。"
      redirect_to admin_playground_path(@playground)
    else
      flash[:alert] = "遊び場の作成に失敗しました。"
      render :new
    end
  end

  def show
    @playground = Playground.find(params[:id])
    @playgrounds = Playground.page(params[:page]).per(10)
  end

  def edit
    @playground = Playground.find(params[:id])
  end

  def update
    @playground = Playground.find(params[:id])
    tags = parse_tags(params[:playground][:tag_id])
    if playground_params[:playground_images].present?
      @playground.playground_images.attach(playground_params[:playground_images]) # 既存の画像を保持しつつ新しい画像を追加
    end
    if @playground.update(playground_params.except(:playground_images)) # 画像以外の属性を更新
      @playground.update_tags(tags)
      flash[:notice] = '遊び場が更新されました。'
      redirect_to admin_playground_path(@playground)
    else
      flash[:alert] = '遊び場の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @playground = Playground.find(params[:id])
    if @playground.destroy
      flash[:notice] = "遊び場が削除されました。"
      redirect_to admin_playgrounds_path
    else
      flash[:alert] = "遊び場の削除に失敗しました。"
      redirect_to admin_playground_path(@playground)
    end
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
                                       playground_images: [])
  end

end
