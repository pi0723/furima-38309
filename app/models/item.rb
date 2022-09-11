class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :area
  belongs_to :delivery_time

  validates :name,        presence: true
  validates :explanation, presence: true
  validates :price,       presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image,       presence: true
  validates :category_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id,     numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_id,       numericality: { other_than: 1, message: "can't be blank" }
  validates :area_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_time_id, numericality: { other_than: 1, message: "can't be blank" }
end
