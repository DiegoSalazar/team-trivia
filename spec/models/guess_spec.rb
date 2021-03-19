# frozen_string_literal: true

require 'rails_helper'

describe Guess, type: :model do
  subject! { create :guess, :with_owners, question: question }
  let(:question) { create :question, :with_trivium }
  let(:aggregated_guess) { question.grouped_guesses.first }

  after { Guess.delete_all }

  shared_context 'Similar Guesses' do
    before do
      values.each do |v|
        create :guess, :with_owners, value: v, question: question
      end
    end

    let(:values) { %w[B b C c c] }
    let(:guesses_count) { question.guesses.count }
  end

  pending 'TODO guesses_spec'
end
