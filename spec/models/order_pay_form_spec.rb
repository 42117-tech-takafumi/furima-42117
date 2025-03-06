require 'rails_helper'

RSpec.describe OrderPayForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_pay_form = FactoryBot.build(:order_pay_form,item_id: item.id,user_id: user.id)
  end

  describe '商品購入' do
    context '商品購入できるとき' do
      it 'カード情報を始めとした全てのカラムの正しいデータが存在すれば登録できる' do
        expect(@order_pay_form).to be_valid
      end
      it '建物名以外のカード情報を始めとした全てのカラムの正しいデータが存在すれば登録できる' do
        @order_pay_form.building = ""
        expect(@order_pay_form).to be_valid
      end
    end

    context '商品購入できないとき' do
      it 'トークンが空では登録できない' do
        @order_pay_form.token=""
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Token can't be blank")
      end
    

      it '郵便番号が空の場合は登録できない' do
        @order_pay_form.postal_code = ""
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が-無しの半角数字8桁の場合は登録できない' do
        @order_pay_form.postal_code = "12345678"
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code . Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号が-の位置を間違えた半角数字8桁の場合は登録できない' do
        @order_pay_form.postal_code = "1-234567"
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code . Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号が8桁未満の場合は登録できない' do
        @order_pay_form.postal_code = "123-456"
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code . Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号に半角数字と-以外の文字列が含まれている場合は登録できない' do
        @order_pay_form.postal_code = "123-aあ４5"
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code . Enter it as follows (e.g. 123-4567)")
      end
      it '都道府県が空の場合は登録できない' do
        @order_pay_form.prefecture_id = ""
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空の場合は登録できない' do
        @order_pay_form.city = ""
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空の場合は登録できない' do
        @order_pay_form.addresses = ""
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が空の場合は登録できない' do
        @order_pay_form.phone_number = ""
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が10桁未満の場合は登録できない' do
        @order_pay_form.phone_number = "12345678"
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number must be between 10 and 11 digits")
      end
      it '電話番号が12桁以上の場合は登録できない' do
        @order_pay_form.phone_number = "123456789100"
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number must be between 10 and 11 digits")
      end
      it '電話番号に半角数字以外の文字列が含まれている場合は登録できない' do
        @order_pay_form.phone_number = "aあ１2345678"
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'userが紐づいていない場合は登録できない' do
        @order_pay_form.user_id = nil
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていない場合は登録できない' do
        @order_pay_form.item_id = nil
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
