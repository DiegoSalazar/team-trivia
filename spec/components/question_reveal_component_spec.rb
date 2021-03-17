# frozen_string_literal: true

require 'rails_helper'

describe QuestionRevealComponent, type: :component do
  subject { described_class.new question, question_number }
  let(:question) { create :question, trivium: trivium }
  let(:guess) { create :guess, player: player, team: team, trivium: trivium, question: question }
  let(:player) { team.players.first }
  let(:team) { create :team, :with_players, player_count: 1 }
  let(:trivium) { create :trivium, :populated }
  let(:question_number) { 0 }
  let(:component) { render_inline(subject).to_html }
  before { player.vote_up_for guess }

  it 'displays the Question body' do
    expect(component).to include question.body
  end

  it 'displays Guesses' do
    expect(component).to include guess.value
  end

  it 'displays correct Guesses over total Guesses' do
    expect(component).to include '0 / 1'
  end
end
