# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    sequence(:username) { |i| "genius#{i}" }
    sequence(:email) { |i| "genius#{i}@trivia.com" }
    password { 'a surprisingly secure password' }
  end
end
