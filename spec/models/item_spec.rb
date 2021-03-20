require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('app/assets/images/search.png')
    end

    describe '商品出品' do
      context '商品が出品できる時' do
        it '全てが存在する時' do
          expect(@item).to be_valid
        end

        it 'priceが半角数字であれば出品できる' do
          @item.price = '500'
          expect(@item).to be_valid
        end
      end

      context '商品が出品できない場合' do
        it 'nameが空だと出品できない' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it 'descriptionが空だと出品できない' do
          @item.description = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end

        it 'priceが空だと出品できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end

        it 'priceが全角数字だと出品できない' do
          @item.price = '５００'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not included in the list')
        end

        it 'priceが300円以下では出品できない' do
          @item.price = '299'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not included in the list')
        end

        it 'priceが9999999円以上では出品できない' do
          @item.price = '10000000'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not included in the list')
        end

        it 'category_idが空だと出品できない' do
          @item.category_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end

        it 'item_status_idが空だと出品できない' do
          @item.item_status_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Item status can't be blank")
        end

        it 'delivery_burden_idが空だと出品できない' do
          @item.delivery_burden_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Delivery burden can't be blank")
        end

        it 'prefecture_idが空だと出品できない' do
          @item.prefecture_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end

        it 'delivery_day_idが空だと出品できない' do
          @item.delivery_day_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Delivery day can't be blank")
        end

        it 'imageが空だと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
      end
    end
  end
end
