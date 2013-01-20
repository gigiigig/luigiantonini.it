require 'faker'

FactoryGirl.define do
  factory :work do 
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentences }
    date { Date.new }
  end
end