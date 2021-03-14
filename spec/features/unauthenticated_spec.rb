require 'rails_helper'

feature 'Unauthenticated', type: :feature do
  before { visit root_path }

  context 'Nav' do
    it 'shows a Join link' do
      expect(page).to have_text 'Join'
    end

    it 'shows a Contribute link' do
      expect(page).to have_text 'Contribute'
    end
  end

  context 'First Run' do
    it 'displays call to action message' do
      expect(page).to have_text 'Contribute questions to upcoming Trivia'
    end
  end

  context 'Upcoming Trivia' do
    let!(:trivia) { create :trivium, :far_future }
    let(:starts_at) { I18n.l trivia.game_starts_at, format: :long }
    before { visit root_path }

    it 'displays a message that the trivia will start' do
      expect(page).to have_text 'Trivia starts in'
    end

    it 'displays the trivia title' do
      expect(page).to have_text trivia.title
    end

    it 'displays the time the trivia starts' do
      expect(page).to have_text starts_at
    end
  end

  context 'Past Trivia' do
    before do
      create_list :trivium, 3, :expired
      visit root_path
    end

    it 'displays a table of past games' do
      expect(page).to have_text 'Past Games'
    end

    it 'lists the past games' do
      Trivium.find_each do |trivium|
        expect(page).to have_text trivium.title
      end
    end
  end
end
