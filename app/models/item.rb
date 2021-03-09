class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category

      #空では保存できないようにする
  validates :name, :description, :price, :category, presence: true

      #ジャンルの選択が「--」の時は保存できないようにする
  validates :prefecture_id, numericality: { other_than: 0 } 
end
