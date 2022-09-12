class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new, :edit

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
    @item = Item.find(params[:id])
  end

  def edit
  end

  private

  def item_params
    params
      .require(:item)
      .permit(:name, :explanation, :price, :user, :image, :category_id,
              :condition_id, :postage_id, :area_id, :delivery_time_id)
      .merge(user_id: current_user.id)
  end
end
