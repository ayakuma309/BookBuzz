FactoryBot.define do
  factory :booktag do
    association :book
    association :tag
  end
end
