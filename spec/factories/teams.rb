# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Superhero.name.pluralize }
  end
end
