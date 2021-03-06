# frozen_string_literal: true

require 'rails_helper'

describe Guess, type: :model do
  subject! { create :guess, :with_owners, question_template: question }
  let(:question) { create :question_template }
  let(:aggregated_guess) { question.aggregated_guesses.first }

  shared_context 'Similar Guesses' do
    before do
      values.each do |v|
        create :guess, :with_owners, value: v, question_template: question
      end
    end

    let(:values) { %w[B b C c c] }
    let(:guesses_count) { question.guesses.count }
  end

  describe '#similarity_ratio' do
    include_context 'Similar Guesses'

    it 'is the rounded up ratio of 2 to 6' do
      expect(aggregated_guess.similarity_ratio).to be 4
    end
  end

  describe '#same_count_percent_of' do
    it 'raises error when called on a non-aggregated guess' do
      expect { subject.same_count_percent_of 0 }.to raise_error 'Can only use this method on an aggregated_guess'
    end

    it 'is the percent of the 1 to 10' do
      expect(aggregated_guess.same_count_percent_of(10)).to be 10
    end

    context 'many guesses' do
      include_context 'Similar Guesses'

      context '1st guess' do
        it 'is the percent of 2 to 6' do
          expect(aggregated_guess.same_count_percent_of(guesses_count)).to eq 33
        end
      end

      context '2nd guess' do
        let(:aggregated_guess) { question.aggregated_guesses[1] }

        it 'is the percent of 3 to 6' do
          expect(aggregated_guess.same_count_percent_of(guesses_count)).to eq 50
        end
      end

      context '3rd guess' do
        let(:aggregated_guess) { question.aggregated_guesses[2] }

        it 'is the percent of 1 to 6' do
          expect(aggregated_guess.same_count_percent_of(guesses_count)).to eq 16
        end
      end
    end
  end
end
