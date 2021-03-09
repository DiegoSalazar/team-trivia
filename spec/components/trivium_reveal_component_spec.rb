# frozen_string_literal: true

require 'rails_helper'

describe TriviumRevealComponent, type: :component do
  subject { described_class.new trivium }
  let(:trivium) { create :trivium, :populated }
  let(:question) { trivium.questions.sample }

  it 'renders the questions' do
    expect(render_inline(subject).to_html).to include question.body
  end
end
