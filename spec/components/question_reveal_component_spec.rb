# frozen_string_literal: true

require 'rails_helper'

describe QuestionRevealComponent, type: :component do
  subject { described_class.new question, question_index }
  let(:question) { create :question, trivium: trivium }
  let(:trivium) { create :trivium, :populated }
  let(:question_index) { 0 }

  it 'renders guesses' do
    expect(render_inline(subject).to_html).to eq ''
  end
end
