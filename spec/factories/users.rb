FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { SecureRandom.hex(8) }
  end

  factory :invalid_user , parent: :user do
    username nil
    email nil
  end

end