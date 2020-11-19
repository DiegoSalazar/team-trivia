# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :trivium, counter_cache: true
end
