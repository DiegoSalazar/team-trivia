# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuessedByComponent, type: :component do
  subject { described_class.new message, player, trivium }
  let(:guess) { create :guess, question: question, player: player, team: team, trivium: trivium }
  let(:trivium) { create :trivium }
  let(:question) { trivium.questions.last }
  let(:message) { create :guess_message, guess: guess, question: question, player: player, trivium: trivium }
  let(:player) { create :player }
  let(:team) { create :team }

  shared_context 'They are the sender' do
    let(:other_player) { create :player }
    let(:message) { create :guess_message, question: question, player: other_player, team: team, trivium: trivium, guess: guess }
  end

  context 'question_badge' do
    it 'is a label with the question number' do
      expect(subject.question_badge).to eq 'Q #2'
    end
  end

  context 'question_title' do
    it 'has expected value' do
      expect(subject.question_title).to eq "Question #2: #{question.body}"
    end
  end

  context 'badge_class' do
    it 'has a default value' do
      expect(subject.badge_class).to start_with 'badge-danger'
    end

    context 'my guess was accepted' do
      let(:other_player) { create :player }
      before { guess.vote_by voter: other_player }

      it 'is expected value' do
        expect(subject.badge_class).to start_with 'badge-light'
      end
    end

    context 'their guess was accepted' do
      include_context 'They are the sender'
      before { player.vote_up_for guess }

      it 'is expected value' do
        expect(subject.badge_class).to eq 'badge-dark'
      end
    end

    context 'I am the sender' do
      it 'includes the expected value' do
        expect(subject.badge_class).to include 'my-guess'
      end
    end

    context 'They are the sender' do
      include_context 'They are the sender'

      it 'includes the expected value' do
        expect(subject.badge_class).to_not include 'my-guess'
      end
    end
  end
end
