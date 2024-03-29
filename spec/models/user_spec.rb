require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録できるとき' do
        it '全てが存在する時' do
          expect(@user).to be_valid
        end

        it 'passwordが半角英数字6文字以上であれば登録できる' do
          @user.password = 'aaaa123'
          @user.password_confirmation = @user.password
          expect(@user).to be_valid
        end

        it 'family_nameが全角文字であれば登録できる' do
          @user.family_name = '山田'
          expect(@user).to be_valid
        end

        it 'first_nameが全角文字であれば登録できる' do
          @user.first_name = '太郎'
          expect(@user).to be_valid
        end

        it 'family_name_kanaが全角カナであれば登録できる' do
          @user.family_name_kana = 'ヤマダ'
          expect(@user).to be_valid
        end

        it 'first_name_kanaが全角カナであれば登録できる' do
          @user.first_name_kana = 'タロウ'
          expect(@user).to be_valid
        end
      end

      context '新規登録できないとき' do
        it 'nicknameが空だと登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'emailが空だと登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'emailに＠がないと登録できない' do
          @user.email = 'test.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end

        it 'passwordが空だと登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'passwordが存在してもencrypted_passwordが空だと登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'passwordが6文字以下だと登録できない' do
          @user.password = 'a1234'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'passwordが半角英字のみでは登録できない' do
          @user.password = 'abcdefg'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'passwordが半角数字のみでは登録できない' do
          @user.password = '1234567'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is invalid')
        end

        it 'passwordが全角では登録できない' do
          @user.password = 'ａｂ１２３４５６'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is invalid')
        end

        it 'passwordとencrypted_passwordが一致していないと登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '1234567'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'family_nameが空だと登録できない' do
          @user.family_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name can't be blank")
        end

        it 'first_nameが空だと登録できない' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it 'family_name_kanaが空だと登録できない' do
          @user.family_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name kana can't be blank")
        end

        it 'first_name_kanaが空だと登録できない' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end

        it 'family_name_kanaがカタカナでないと登録できない' do
          @user.family_name_kana = 'やまだ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name kana is invalid')
        end

        it 'first_name_kanaがカタカナでないと登録できない' do
          @user.first_name_kana = 'たろう'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana is invalid')
        end

        it 'family_nameが全角でないと登録できない' do
          @user.family_name = 'ﾔﾏﾀﾞ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name is invalid')
        end

        it 'first_nameが全角でないと登録できない' do
          @user.first_name = 'ﾀﾛｳ'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid')
        end

        it 'birth_dateが空だと登録できない' do
          @user.birth_date = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth date can't be blank")
        end
      end
    end
  end
end
