class Admin::PlaygroundsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @playgrounds = Playground.all
    @playgrounds = Playground.page(params[:page]).per(10)
  end

  def new
    @playground = Playground.new
  end

  def create
    @playground = Playground.new(playground_params)
    @playground.user_id = nil
    if @playground.save
      flash[:notice] = "新しいプレイグラウンドが作成されました。"
      redirect_to admin_playground_path(@playground)
    else
      flash[:alert] = "プレイグラウンドの作成に失敗しました。"
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
    if @playground.update(playground_params)
      flash[:notice] = "プレイグラウンドが更新されました。"
      redirect_to admin_playground_path(@playground)
    else
      flash[:alert] = "プレイグラウンドの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @playground = Playground.find(params[:id])
    if @playground.destroy
      flash[:notice] = "プレイグラウンドが削除されました。"
      redirect_to admin_playgrounds_path
    else
      flash[:alert] = "プレイグラウンドの削除に失敗しました。"
      redirect_to admin_playground_path(@playground)
    end
  end
end
