class OrderDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :city, :address, :building, :phone, :area_id, :token


  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :phone, format: {with: /\A\d{10,11}+\z/, message: 'is invalid. Input only number'}
  end
  validates :area_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, city: city, address: address, building: building, phone: phone, area_id: area_id, order_id: order.id)
  end
end




  

