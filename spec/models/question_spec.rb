# frozen_string_literal: true

require 'rails_helper'

describe Question, type: :model do
  subject { create :question, :multiple_choice, trivium: trivium }
  let(:trivium) { create :trivium }

  describe '#grouped_guesses' do
    before do
      values.each { |v| create :guess, :with_owners, value: v, question: subject }
    end
    let(:values) { %w[a B b C c c] }

    it 'is a hash' do
      expect(subject.grouped_guesses).to be_a Hash
    end

    it 'counts 1 similar guess for the "a" value' do
      expect(subject.grouped_guesses['a'].size).to be 1
    end

    it 'counts 2 similar guesses for the "b" value' do
      expect(subject.grouped_guesses['b'].size).to be 2
    end

    it 'counts 3 similar guesses for the "c" value' do
      expect(subject.grouped_guesses['c'].size).to be 3
    end
  end
end
