# frozen_string_literal: true

require 'rails_helper'

feature 'Home', type: :feature do
  before { visit root_path }

  context 'No Trivia exist yet' do
    it 'displays call to action to create Trivia' do
      expect(page).to have_content 'Create new Trivia!'
    end

    it 'shows a Contribute button' do
      within 'main' do
        expect(page).to have_link 'Contribute'
      end
    end

    it 'warns that there are no Trivia yet' do
      expect(page).to have_content 'No Trivia have been played yet.'
    end
  end

  context 'Upcoming Trivia exist' do
    let!(:trivium) { create :trivium, :far_future }
    before { visit root_path }

    it 'displays message about Upcoming Trivia' do
      expect(page).to have_content 'Trivia starts in...'
    end

    it 'displays the Upcoming Trivia title' do
      expect(page).to have_content trivium.title
    end
  end

  context 'An Active Trivia exists' do
    let!(:trivium) { create :trivium, :active }
    before { visit root_path }

    it 'displays a message about the active Trivia' do
      expect(page).to have_content 'Playing now! Ends in...'
    end
  end

  context 'Past Games' do
    let!(:trivia) { create_list :trivium, 3, game_starts_at: 1.day.ago }
    before { visit root_path }

    it 'displays past Trivia' do
      trivia.each do |trivium|
        expect(page).to have_content trivium.title
      end
    end
  end
end
