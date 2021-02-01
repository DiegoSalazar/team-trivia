# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamMessageComponent, type: :component do
  subject { described_class.new message: message, player: player, trivium: trivium }
  let(:message) { create :team_message, trivium: trivium, player: player }
  let(:player) { create :player }
  let(:trivium) { create :trivium }

  shared_context 'other_player' do
    let(:message) { create :team_message, trivium: trivium, player: other_player }
    let(:other_player) { create :player }
  end

  it 'renders the message' do
    expect(render_inline(subject).to_html).to include message.body
  end

  describe '#sender' do
    context 'current_player is the sender' do
      it 'is You' do
        expect(subject.sender).to eq 'You'
      end
    end

    context 'other player is the sender' do
      include_context 'other_player'

      it "is the other player's username" do
        expect(subject.sender).to eq other_player.username
      end
    end
  end

  describe '#container_class' do
    it 'is text-right when you are the sender' do
      expect(subject.container_class).to eq 'text-right'
    end

    context 'other player is the sender' do
      include_context 'other_player'

      it 'is nil' do
        expect(subject.container_class).to eq nil
      end
    end
  end
end
