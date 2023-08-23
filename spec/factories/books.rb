# == Schema Information
#
# Table name: books
#
#  author          :string
#  isbn            :bigint           not null, primary key
#  item_caption    :text
#  item_url        :text
#  large_image_url :text
#  sales_date      :text
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
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
