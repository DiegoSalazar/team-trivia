# frozen_string_literal: true

require 'rails_helper'

feature 'Reveal', type: :feature do
  before do
    login_player_one!
    visit reveal_trivium_path trivium
  end
  let(:trivium) { create :trivium, :populated, :expired }
  let(:ended_at) { I18n.l trivium.game_ends_at, format: :long }

  it 'displays the Trivia title' do
    expect(page).to have_content trivium.title
  end

  it 'displays the Trivia end date' do
    expect(page).to have_content ended_at
  end

  it 'has a Next Question button' do
    expect(page).to have_button 'Next Question'
  end

  context 'When Questions revealed' do
    before do
      trivium.questions.each(&:question_revealed!)
      trivium.questions.last.active!
      visit reveal_trivium_path trivium
    end

    it 'displays the Questions' do
      expect(page).to have_content trivium.questions.first.body
      expect(page).to have_content trivium.questions.last.body
    end

    it 'displays a Reveal Answer button' do
      expect(page).to have_button 'Reveal Answer'
    end
  end

  context 'When Answers revealed' do
    before do
      trivium.questions.each(&:answer_revealed!)
      trivium.questions.last.active!
      visit reveal_trivium_path trivium
    end

    it 'displays winners' do
      expect(page).to have_content '1st Place'
    end

    it 'displays winning team name' do
      expect(page).to have_content Team.last.name
    end
  end
end
