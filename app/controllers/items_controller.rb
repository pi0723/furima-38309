class ItemsController < ApplicationController

  def index
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

  private

  def article_params
    params
    .require(:item)
    .permit(:name, :explanation, :price, :user, :category_id, 
             :condition_id, :postage_id, :area_id, :delivery_time_id)
    .merge(user_id: current_user.id)
  end
end
