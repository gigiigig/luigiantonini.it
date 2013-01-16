require 'faker'

FactoryGirl.define do
  factory :work do |w|
    w.name { Faker::Lorem.sentence }
    w.description { Faker::Lorem.sentences }
    w.date { Date.new }
  end
end