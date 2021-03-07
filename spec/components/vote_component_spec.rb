# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VoteComponent, type: :component do
  subject { described_class.new player, guess, trivium: guess.trivium }
  before { guess.liked_by player }
  let(:player) { create :player }
  let(:guess) { create :guess, :with_owners, question: question }
  let(:question) { create :question, :with_trivium }

  describe '#link_class' do
    it 'is a string' do
      expect(subject.link_class).to be_a String
    end

    it 'includes active when the player voted' do
      expect(subject.link_class).to include 'active'
    end

    context 'player did not vote' do
      before { Vote.destroy_all }

      it 'has border and shadow' do
        expect(subject.link_class).to include 'border shadow'
      end
    end
  end
end
