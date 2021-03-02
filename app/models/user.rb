class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 空だと保存できないバリデーション
  with_options presence: true do
    
    validates :nickname
    validates :email, uniqueness: { case_sensitive: true }
    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i
    validates :password, :password_confirmation, length: { minimum: 6 },
    format: { with: VALID_PASSWORD_REGEX }
    
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ }
    validates :family_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :birth_date
  end
end
