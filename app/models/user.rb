class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  # 空だと保存できないバリデーション
  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :email, uniqueness: { case_sensitive: true }

    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i
    validates :password, :password_confirmation, length: { minimum: 6 },
                                                 format: { with: VALID_PASSWORD_REGEX }

    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ } do
      validates :family_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :family_name_kana
      validates :first_name_kana
    end
  end
end
