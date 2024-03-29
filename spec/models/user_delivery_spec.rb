require 'rails_helper'

RSpec.describe UserDelivery, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @user_delivery = FactoryBot.build(:user_delivery, user_id: @user.id, item_id: @item.id)
      sleep 0.1 # 0.1秒待機
    end

    describe '商品出品' do
      context '商品が購入できるとき' do
        it '全てが存在するとき' do
          expect(@user_delivery).to be_valid
        end

        it 'post_codeが半角数字であれば購入できる' do
          @user_delivery.post_code = '123-4567'
          expect(@user_delivery).to be_valid
        end

        it 'phone_numberが半角数字であれば登録できる' do
          @user_delivery.phone_number = '09011112222'
          expect(@user_delivery).to be_valid
        end

        it 'tokenがあれば保存ができること' do
          expect(@user_delivery).to be_valid
        end

        it '建物名がなくても購入できる' do
         @user_delivery.building_name = ''
         expect(@user_delivery).to be_valid
        end

        context '商品が購入できないとき' do
          it 'post_codeが空だと購入できない' do
            @user_delivery.post_code = ''
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include("Post code can't be blank")
          end

          it 'post_codeが半角数字でないと購入できない' do
            @user_delivery.post_code = '１２３-４５６７'
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Post code is invalid')
          end

          it 'post_codeにハイフンがなければ購入できない' do
            @user_delivery.post_code = '1234567'
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Post code is invalid')
          end

          it 'prefecture_idが空だと購入できない' do
            @user_delivery.prefecture_id = 0
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Prefecture must be other than 0')
          end

          it 'cityが空だと購入できない' do
            @user_delivery.city = ''
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include("City can't be blank")
          end

          it 'addressが空だと購入できない' do
            @user_delivery.address = ''
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include("Address can't be blank")
          end

          it 'phone_numberが空だと購入できない' do
            @user_delivery.phone_number = ''
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include("Phone number can't be blank")
          end

          it 'phone_numberにハイフンがあると購入できない' do
            @user_delivery.phone_number = '090-1111-2222'
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Phone number is invalid')
          end

          it 'phone_numberが12桁だと購入できない' do
            @user_delivery.phone_number = '090111122222'
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Phone number is invalid')
          end

          it 'phone_numberが9桁以下だと購入できない' do
            @user_delivery.phone_number = '04811122'
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Phone number is invalid')
          end

          it 'phnoe_numberが数字のみでないと購入できない' do
            @user_delivery.phone_number = 'o901111o0o0'
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Phone number is invalid')
          end

          it 'phnoe_numberが全角数字だと購入できない' do
            @user_delivery.phone_number = '０９０１１１１２２２２'
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include('Phone number is invalid')
          end

          it 'tokenが空では登録できないこと' do
            @user_delivery.token = nil
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include("Token can't be blank")
          end

          it 'user_idが空だ登録できない' do
            @user_delivery.user_id = nil
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include("User can't be blank")
          end

          it 'item_idが空だと登録できない' do
            @user_delivery.item_id = nil
            @user_delivery.valid?
            expect(@user_delivery.errors.full_messages).to include("Item can't be blank") 
          end
        end
      end
    end
  end
end
