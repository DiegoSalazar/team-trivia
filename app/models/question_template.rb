# frozen_string_literal: true

class QuestionTemplate < ApplicationRecord
  has_many :answer_templates
  has_many :guesses

  # attr_accessor :body
  # attr_accessor :correct_answer
  # attr_accessor :question_type
end
