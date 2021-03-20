class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :item_status
  belongs_to :delivery_burden
  belongs_to :delivery_day

  # 空では保存できないようにする
  with_options presence: true do
    validates :name
    validates :description
    validates :price, inclusion: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/ }
    validates :category_id
    validates :item_status_id
    validates :delivery_burden_id
    validates :prefecture_id
    validates :delivery_day_id
    validates :image
  end
  # ジャンルの選択が「--」の時は保存できないようにする
  validates :prefecture_id, :category_id, :item_status_id, :delivery_burden_id, :delivery_day_id, numericality: { other_than: 0 }
end
