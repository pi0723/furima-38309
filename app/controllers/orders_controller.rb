class OrdersController < ApplicationController

  def index
    @order_destination = OrderDestination.new
  end

  def create
    binfing.pry
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:donation_address)
          .permit( :post_code, :city, :address, :building, :phone, :area_id, :order_id)
          .merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
