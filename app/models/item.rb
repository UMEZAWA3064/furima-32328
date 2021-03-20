class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :item_status
  belongs_to :delivery_burden
  belongs_to :delivery_day

      #空では保存できないようにする
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :item_status_id, presence: true
  validates :delivery_burden_id, presence: true
  validates :prefecture_id, presence: true
  validates :image, presence: true
  validates :delivery_day_id, presence: true

      #ジャンルの選択が「--」の時は保存できないようにする
  validates :prefecture_id, :category_id, :item_status_id, :delivery_burden_id, :delivery_day_id, numericality: { other_than: 0 } 
end
