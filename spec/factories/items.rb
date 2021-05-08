FactoryBot.define do
  factory :item do
    name                 { 'おにぎり' }
    description          { '塩味' }
    price                { 500 }
    category_id          { 1 }
    item_status_id       { 1 }
    delivery_burden_id   { 1 }
    prefecture_id        { 1 }
    delivery_day_id      { 1 }
    
    association :user
    
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
