FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.email}
    password              {'testpass12'}
    password_confirmation {password}
    last_name             {'佐藤'}
    first_name            {'健太郎'}
    last_name_kana        {'サトウ'}
    first_name_kana       {'ケンタロウ'}
    birth_date            {20090415}
  end
end