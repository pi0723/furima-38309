class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :none_or_self, only: [:index, :create]

  def index
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_destination)
          .permit(:post_code, :city, :address, :building, :phone, :area_id)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def none_or_self
    @item = Item.find(params[:item_id])
    if @item.order.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

end
