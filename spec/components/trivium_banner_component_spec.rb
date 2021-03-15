# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TriviumBannerComponent, type: :component do
  subject { described_class.new trivium }
  let(:trivium) { create :trivium }

  it 'renders the trivium title' do
    expect(render_inline(subject).to_html).to include trivium.title
  end

  it 'renders the trivium body' do
    expect(render_inline(subject).to_html).to include trivium.body
  end

  it 'allows to not render a countdown' do
    subject = described_class.new trivium
    expect(render_inline(subject).to_html).to_not include 'countdown'
  end
end
