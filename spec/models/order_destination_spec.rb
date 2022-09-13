require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '配送先情報の保存' do
    before do
      @order_destination = FactoryBot.build(:order_destination)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_destination).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @order_destination.post_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号は半角のハイフンを含んでいないと保存できないこと' do
        @order_destination.post_code = 1_234_567
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '郵便番号が半角の数字でないと保存できないこと' do
        @order_destination.post_code = '１２３−４５６７'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県を選択していないと保存できないこと' do
        @order_destination.area_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Area can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_destination.address = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_destination.phone = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone can't be blank")
      end
      it '電話番号が10か11桁でないと保存できないこと' do
        @order_destination.phone = '01234'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone is invalid. Input only number')
      end
      it '電話番号が全角数字だと保存できないこと' do
        @order_destination.phone = '０１２３４５６７８９'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone is invalid. Input only number')
      end
      it '電話番号が半角の-を含んでいると保存できないこと' do
        @order_destination.phone = '080-1234-1234'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone is invalid. Input only number')
      end
      it 'tokenが空では登録できないこと' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idがないと保存できないこと' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがないと保存できないこと' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
