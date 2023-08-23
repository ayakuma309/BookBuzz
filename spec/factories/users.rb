# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  name             :string           not null
#  role             :integer          default("general"), not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role{ :general}
  end
end
