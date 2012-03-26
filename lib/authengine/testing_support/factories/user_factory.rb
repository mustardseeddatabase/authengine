require 'faker'

FactoryGirl.define do
  factory :user do
    login {Faker::Name.last_name}
    email {Faker::Internet.email}
    activated_at {Date.new!(2430000+ rand(25000))}
    enabled 1
    firstName {Faker::Name.first_name}
    lastName {Faker::Name.last_name}
  end
end

