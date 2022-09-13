FactoryBot.define do
  factory :order_destination do
    user_id   { Faker::Number }
    item_id   { Faker::Number }
    post_code { '123-4567' }
    city      { '静岡市' }
    address   { '静岡123' }
    building  { '静岡ABC' }
    phone     { '09012345678' }
    area_id   { Faker::Number.between(from: 2, to: 48) }
    token     { 'tok_abcdefghijk00000000000000000' }
  end
end
