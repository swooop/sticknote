# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name { Faker::Lorem.words(num = 1) }
    description { Faker::Lorem.sentences(sentence_count = 5) }
    link { Faker::Internet.domain_name }
  end
end
