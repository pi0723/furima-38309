require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての値が正しく存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'emailに@がないと登録できない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'パスワードは半角英数混合でないと登録できない' do
        @user.password = '1234567'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password には英字と数字の両方を含めて設定してください'
      end
      it 'パスワードが6文字以下だと登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'パスワードが129文字以上だと登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too long (maximum is 128 characters)'
      end
      it 'パスワードとパスワード(確認)が同じでないと登録できない' do
        @user.password = '123456a'
        @user.password_confirmation = '123456b'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it '名字(全角)が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it '名字(全角)が全角文字以外だと登録できない' do
        @user.last_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name 全角文字(かなカナ漢字)を使用してください'
      end
      it '名前(全角)が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it '名前(全角)が全角文字以外だと登録できない' do
        @user.first_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name 全角文字(かなカナ漢字)を使用してください'
      end
      it '名字(カナ)が空では登録できない' do
        @user.read_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Read last can't be blank"
      end
      it '名字(カナ)が全角カナ以外だと登録できない' do
        @user.read_last = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Read last 全角カナを使用してください'
      end
      it '名前(カナ)が空では登録できない' do
        @user.read_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Read first can't be blank"
      end
      it '名前(カナ)が全角カナ以外だと登録できない' do
        @user.read_first = 'あいうえお'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Read first 全角カナを使用してください'
      end
      it '誕生日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
