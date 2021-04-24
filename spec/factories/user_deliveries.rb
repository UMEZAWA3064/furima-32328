FactoryBot.define do
  factory :user_delivery do
    post_code {'123-4567'}
    prefecture_id {6}
    city {'横浜市保土ヶ谷区'}
    address {'鶴ヶ峰1-1-1'}
    building_name {'マンション'}
    phone_number {'09011112222'}
    user_id {3}
    item_id {4}
  end
end
