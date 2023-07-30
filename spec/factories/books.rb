FactoryBot.define do
  factory :book do
    isbn { Faker::Lorem.characters(number: 10) }
    author { Faker::Lorem.characters(number: 10) }
    item_caption  { Faker::Lorem.characters(number: 30) }
    item_url { Faker::Lorem.characters(number: 10) }
    large_image_url { Faker::Lorem.characters(number: 10) }
    sales_date { Faker::Lorem.characters(number: 10) }
    title { Faker::Lorem.characters(number: 10) }
  end
end
