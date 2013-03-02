FactoryGirl.define  do
  factory :organization do
    name { Faker::Company.name }
    street  { Faker::Address.street_address }
    city  { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip  { Faker::Address.zip_code }
    phone  {Faker::PhoneNumber.phone_number}
    email  {Faker::Internet.email}

    trait :pantry do
      pantry true
    end

    trait :referrer do
      referrer true
    end

    trait :active do
      active true
    end

    trait :inactive do
      active false
    end

    trait :with_users do
      after(:build) do |o|
        o.users << FactoryGirl.build(:user)
      end
    end
  end
end
