# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuessedByComponent, type: :component do
  subject { described_class.new message, player, trivium }
  let(:trivium) { create :trivium }
  let(:question_template) { trivium.question_templates.last }
  let(:guess) { create :guess, question_template: question_template }
  let(:message) { create :guess_message, player: player, trivium: trivium, guess: guess }
  let(:player) { create :player }

  shared_context 'They are the sender' do
    let(:other_player) { create :player }
    let(:message) { create :guess_message, player: other_player, trivium: trivium, guess: guess }
  end

  it 'renders the message text' do
    expect(render_inline(subject).to_html).to include message.body
  end

  context 'question_badge' do
    it 'is a label with the question number' do
      expect(subject.question_badge).to eq 'Guess for Q #2'
    end
  end

  context 'question_title' do
    it 'has expected value' do
      expect(subject.question_title).to eq "Question #2: MyText"
    end
  end

  context 'badge_class' do
    it 'has a default value' do
      expect(subject.badge_class).to start_with 'badge-warning'
    end

    context 'my guess was accepted' do
      let(:other_player) { create :player }
      before { other_player.vote_up_for guess }

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
