# frozen_string_literal: true

require 'rails_helper'

describe QuestionRevealComponent, type: :component do
  subject { described_class.new question, question_index, reveal_status, current_question_revealed }
  let(:question) { create :question, trivium: trivium }
  let(:trivium) { create :trivium, :populated }
  let(:question_index) { 0 }
  let(:reveal_status) { {} }
  let(:current_question_revealed) { }

  it 'renders guesses' do
    expect(render_inline(subject).to_html).to eq ''
  end
end
