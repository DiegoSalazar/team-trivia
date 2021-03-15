# frozen_string_literal: true

require 'rails_helper'

describe Question, type: :model do
  subject { create :question, trivium: trivium }
  let(:trivium) { create :trivium }

  describe '#aggregated_guesses' do
    before do
      values.each { |v| create :guess, :with_owners, value: v, question: subject }
    end
    let(:values) { %w[a B b C c c] }

    it 'adds same_count attribute to each instance' do
      expect(subject.aggregated_guesses.first.same_count).to be_an Integer
    end

    it 'counts 1 similar guess for the "a" value' do
      expect(subject.aggregated_guesses[0].same_count).to be 1
    end

    it 'counts 2 similar guesses for the "b" value' do
      expect(subject.aggregated_guesses[1].same_count).to be 2
    end

    it 'counts 3 similar guesses for the "c" value' do
      expect(subject.aggregated_guesses[2].same_count).to be 3
    end
  end
end
