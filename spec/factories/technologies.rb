# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :technology do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentences }
    type { "Language" }
  end
end
