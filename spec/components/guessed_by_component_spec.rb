# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuessedByComponent, type: :component do
  subject { described_class.new message, player, trivium }
  let(:message) { create :guess_message, trivium_id: trivium.id }
  let(:player) { create :player }
  let(:trivium) { create :trivium }
  let(:component_html) { render_inline(subject).to_html }

  it 'renders the message text' do
    expect(component_html).to include message.body
  end

  context 'question_badge' do
    it 'has expected value' do
      expect(subject.question_badge).to eq ''
    end
  end

  context 'question_title' do

  end

  context 'badge_class' do

  end
end
