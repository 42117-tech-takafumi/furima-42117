FactoryBot.define do
  factory :item do
    name                   {'テスト商品'}
    info                   {Faker::Lorem.sentence}
    price                  {1000}
    category_id            {2}
    sales_status_id        {2}
    shipping_fee_status_id {2}
    prefecture_id          {2}
    scheduled_delivery_id  {2}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    association :user 
  end
end
