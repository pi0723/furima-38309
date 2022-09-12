class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to action: :index unless current_user.id == @item.user_id
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    redirect_to action: :index unless current_user.id == item.user_id
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params
      .require(:item)
      .permit(:name, :explanation, :price, :user, :image, :category_id,
              :condition_id, :postage_id, :area_id, :delivery_time_id)
      .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
