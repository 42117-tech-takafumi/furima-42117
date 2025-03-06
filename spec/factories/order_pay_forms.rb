FactoryBot.define do
  factory :order_pay_form do
    postal_code           {'123-4567'}
    prefecture_id         {2}
    city                  {'〇〇市'}
    addresses             {'△△-××'}
    building              {'テスト'}
    phone_number          {'1234567890'}
    token                 {'token_12345'}  
  end
end
