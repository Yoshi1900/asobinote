class Public::PlaygroundsController < ApplicationController
  def new
    @playground = Playground.new
  end

  def index
    @playgrounds = Playground.all
    @playgrounds_pages = Playground.page(params[:page]).per(5)
  end

  def show
    @playground = Playground.find(params[:id])
    @playground_posts = @playground.posts
    @playgrounds_pages = @playground_posts.page(params[:page]).per(5)
    @post = Post.new
  end

  def edit
    @playground = Playground.find(params[:id])
  end
  
  def update
    @playground = Playground.find(params[:id])
    if @playground.update(playground_params)
      redirect_to @playground, notice: 'Playground was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @playground = Playground.new(playground_params)
    @user = current_user
    if @playground.save
      redirect_to @playground, notice: 'Playground was successfully created.'
    else
      render :new
    end
  end
  
  def remove_image
    @playground = Playground.find(params[:id])
    image = @playground.playground_images.find(params[:image_id]) if params[:image_id].present?
  
    if image
      image.purge
      redirect_to edit_playground_path(@playground), notice: '画像が削除されました。'
    else
      redirect_to edit_playground_path(@playground), alert: '画像が見つかりませんでした。'
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
                                         playground_images: [])
  end

end
