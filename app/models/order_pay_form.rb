class OrderPayForm 
  include ActiveModel::Model
  attr_accessor :user_id,:item_id,:postal_code,:prefecture_id,:city,:addresses,:building,:phone_number,:token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: ". Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank"}
    validates :user_id,:item_id,:city,:addresses
    validates :phone_number,format: {with: /\A\d{10,11}\z/, message: "must be between 10 and 11 digits"},numericality: { only_integer: true, message: "is invalid. Input only number" }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id,item_id: item_id )
    PayForm.create(postal_code: postal_code,prefecture_id: prefecture_id,city: city,addresses: addresses,building: building,phone_number: phone_number,order_id: order.id)
  end

end