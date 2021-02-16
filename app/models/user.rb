class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
         
   #空だと保存できないバリデーション      
    validates :name, presence: true
    validates :email, presence: true
    validates :encrypted_password, presence: true
    validates :family_name, presence: true
    validates :first_name, presence: true
    validates :family_name_kana, presence: true
    validates :first_name_kana, presence: true
    validates :birth_date, presence: true
end
