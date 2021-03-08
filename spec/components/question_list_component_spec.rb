# frozen_string_literal: true

require 'rails_helper'

describe QuestionListComponent, type: :component do
  subject { described_class.new questions, question, trivium }
  let(:questions) { create_list :question, 2, trivium: trivium }
  let(:question) { questions.last }
  let(:trivium) { create :trivium }

  it 'renders questions' do
    expect(render_inline(subject).to_html).to include question.body
  end

  context '#button_class' do
    it 'starts with list classes' do
      expect(subject.button_class(questions.first)).to start_with 'list-group-item'
    end

    it 'appends active' do
      expect(subject.button_class(question)).to end_with 'active'
    end
  end
end
