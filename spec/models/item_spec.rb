require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品登録' do
    context '商品が登録できるとき' do
      it 'nameを始めとした全てのカラムの正しいデータが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が登録できないとき' do
      it 'nameが空では登録できない' do
        @item.name=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'infoが空では登録できない' do
        @item.info=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'category_idが空では登録できない' do
        @item.category_id=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'category_idが1では登録できない' do
        @item.category_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'sales_status_idが空では登録できない' do
        @item.sales_status_id=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end
      it 'sales_status_idが1では登録できない' do
        @item.sales_status_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end
      it 'shipping_fee_status_idが空では登録できない' do
        @item.shipping_fee_status_id=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end
      it 'shipping_fee_status_idが1は登録できない' do
        @item.shipping_fee_status_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end
      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが1では登録できない' do
        @item.prefecture_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'scheduled_delivery_idが空では登録できない' do
        @item.scheduled_delivery_id=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
      it 'scheduled_delivery_idが1では登録できない' do
        @item.scheduled_delivery_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price=""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが半角数字以外（半角文字列）では登録できない' do
        @item.price="aaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが半角数字以外（全角文字列）では登録できない' do
        @item.price="あああ"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが半角数字以外（全角数字）では登録できない' do
        @item.price="１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが300未満の場合は登録できない' do
        @item.price=200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが9,999,999より大きい場合は登録できない' do
        @item.price=10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
