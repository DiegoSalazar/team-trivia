# frozen_string_literal: true

require 'rails_helper'

feature 'Play', type: :feature do
  before do
    login_player_one!
    team.players << current_player
  end
  let(:team) { create :team }
  let(:play_page) { play_team_trivium_path team, trivium }

  context "Trivia hasn't started yet" do
    let!(:trivium) { create :trivium, :far_future }
    before { visit play_team_trivium_path(team, trivium) }

    it 'redirects back to Home' do
      expect(page.current_path).to eq root_path
    end

    it 'displays a warning' do
      expect(page).to have_content "That game hasn't started yet."
    end
  end

  context 'Trivia just started' do
    let!(:trivium) { create :trivium, :active }
    let(:question) { create :question, trivium: trivium, player: team.players.last }
    before do
      trivium.questions << question
      visit play_page
    end

    it 'loads the Play page' do
      expect(page.current_path).to eq play_page
    end

    it 'displays the Trivia title' do
      expect(page).to have_content trivium.title
    end

    it 'displays the Team chat' do
      expect(page).to have_content "Team #{team.name} Chat"
    end

    it 'displays the Questions' do
      expect(page).to have_content question.body
    end
  end

  context 'Trivia ended' do
    let!(:trivium) { create :trivium, :expired }
    let(:ended_at) { I18n.l trivium.game_ends_at, format: :long }
    before { visit play_page }

    it 'displays the Trivia end date' do
      expect(page).to have_content ended_at
    end
  end
end
