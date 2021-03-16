# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    team
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
