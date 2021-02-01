# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TriviumBannerComponent, type: :component do
  subject { described_class.new trivium }
  let(:trivium) { create :trivium }

  it 'renders the trivium body' do
    expect(render_inline(subject).to_html).to include trivium.body
  end

  describe '#starts_at' do
    it 'is a string' do
      expect(subject.starts_at).to be_a String
    end

    it 'displays the trivium start time' do
      expect(subject.starts_at).to eq I18n.l(trivium.game_starts_at, format: :short)
    end
  end
end
