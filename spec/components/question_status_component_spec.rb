# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionStatusComponent, type: :component do
  subject { described_class.new guess.question, active }
  let(:guess) { create :guess, :with_owners, question: question }
  let(:question) { create :question, :with_trivium }
  let(:active) { true }

  it 'renders guess and vote counts' do
    expect(render_inline(subject).to_html).to include '1 / 1'
  end

  describe '#id' do
    it 'is the question dom_id' do
      expect(subject.id).to eq 'question_1-status'
    end
  end

  describe '#css_class' do
    context 'when the question has accepted guesses' do
      it 'is the success style' do
        expect(subject.css_class).to eq 'badge-success'
      end
    end

    context 'when the question has no accepted guesses but is active' do
      let(:guess) { create :guess, :with_owners, question: question, cached_votes_up: 0 }

      it 'is the primary style' do
        expect(subject.css_class).to eq 'badge-light'
      end
    end

    context 'question has no votes and is not active' do
      let(:active){ false }
      let(:guess) { create :guess, :with_owners, question: question, cached_votes_up: 0 }

      it 'is the primary style' do
        expect(subject.css_class).to eq 'badge-primary'
      end
    end
  end

  describe '#status' do
    it 'is the number of guesses over the number of guesses with votes' do
      expect(subject.status).to eq '1 / 1'
    end

    context '1 guess and no votes' do
      let(:guess) { create :guess, :with_owners, question: question, cached_votes_up: 0 }
      subject { described_class.new guess.question, active }

      it 'is the number of accepted guesses over the total guesses' do
        expect(subject.status).to eq '0 / 1'
      end
    end

    context 'no guesses or votes' do
      subject { described_class.new Question.new, active }

      it 'is the number of guesses over the number of guesses with votes' do
        expect(subject.status).to eq '0 / 0'
      end
    end
  end
end
