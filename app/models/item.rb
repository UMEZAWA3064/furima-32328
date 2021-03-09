class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :item_status

      #空では保存できないようにする
  validates :name, :description, :price, :category, :item_status, presence: true

      #ジャンルの選択が「--」の時は保存できないようにする
  validates :prefecture_id, :category_id, :item_status, numericality: { other_than: 0 } 
end
