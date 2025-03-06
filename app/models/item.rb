class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :image, presence: true
  validates :name, :info, presence: true
  validates :price, presence: true, numericality: { only_integer: true, message: "is not a number" }

  with_options if: -> { self.price_before_type_cast.to_s.match?(/\A[0-9]+\z/) } do
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :category_id,:sales_status_id,:shipping_fee_status_id,:prefecture_id,:scheduled_delivery_id, numericality: { other_than: 1, message: "can't be blank"} 

end
