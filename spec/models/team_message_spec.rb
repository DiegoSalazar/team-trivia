# frozen_string_literal: true

require 'rails_helper'

describe TeamMessage, type: :model do
  subject { create :team_message, :with_trivium }

  context '#sender_name' do
    it 'is the player username' do
      expect(subject.sender_name).to eq subject.player.username
    end
  end

  context '#body' do
    it 'is the body attribute' do
      expect(subject.body).to be subject.read_attribute(:body)
    end

    context 'is a guess' do
      subject { create :guess_message, trivium: trivium, question: question }
      let(:trivium) { create :trivium }
      let(:question) { create :question, trivium: trivium }

      it 'is the guess value' do
        expect(subject.body).to be subject.guess.value
      end
    end
  end
end
