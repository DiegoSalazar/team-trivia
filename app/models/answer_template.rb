# frozen_string_literal: true

class AnswerTemplate < ApplicationRecord
  belongs_to :question_template
  attr_accessor :body
end
