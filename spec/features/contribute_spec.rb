# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
feature 'Contribute', type: :feature do
  before do
    login_player_one!
    within('main') { click_link 'Contribute' }
  end

  let(:trivia_title) { "Trivia Title #{rand}" }
  let(:trivia_hint) { "Trivia Hint #{rand}" }
  let(:starts_at) { Time.now }
  let(:ends_at) { starts_at + 1.minute }
  let(:trivium) { Trivium.first }

  context 'When no Trivia exist yet' do
    context 'Contribute link in Nav' do
      it 'takes you to the New Trivia page' do
        expect(page).to have_content 'Create a New Trivia Game'
      end
    end

    context 'Creating Trivia' do
      it 'displays a success notice' do
        create_trivium
        expect(page).to have_content 'Trivium was successfully created.'
      end

      it "takes you to the Trivia's Contribute page on success" do
        create_trivium
        expect(page.current_path).to eq new_trivium_question_path(Trivium.last)
      end

      context 'Invalid' do
        it 'shows errors' do
          click_on 'Create Trivia'
          expect(page).to have_content [
            "Title can't be blank",
            'Body should include a hint',
            'Game starts at is invalid',
            'Game ends at is invalid',
            'and game must end at least a minute after it starts'
          ].join(', ')
        end
      end
    end
  end

  context 'When Upcoming Trivia exist' do
    before do
      create_trivium
      upcoming_trivium
      visit new_trivium_question_path trivium
    end
    let(:starts_at) { 1.minute.from_now }
    let(:upcoming_trivium) { create_list :trivium, 2, :far_future }

    it 'displays the Trivia title in the Banner' do
      within '.jumbotron' do
        expect(page).to have_content trivium.title
      end
    end

    it 'displays a list called Upcoming Trivia' do
      expect(page).to have_content 'Upcoming Trivia'
    end

    it 'lists the upcoming Trivia' do
      upcoming_trivium.each do |t|
        expect(page).to have_content t.title
      end
    end
  end

  context 'When I have contributed Questions to the Upcoming Trivia' do
    let!(:questions) do
      create_list :question, 2, trivium: trivium, player: current_player
    end
    let(:trivium) { create :trivium, :far_future }
    before { visit new_trivium_question_path trivium }

    it 'shows list of My Questions' do
      expect(page).to have_content 'My Questions'
    end

    it 'displays my questions' do
      current_player.questions.each do |question|
        expect(page).to have_content question.body
      end
    end
  end

  def create_trivium
    fill_in 'Title', with: trivia_title
    fill_in 'Hint', with: trivia_hint
    fill_in 'Game starts at', with: starts_at
    fill_in 'Game ends at', with: ends_at
    click_on 'Create Trivia'
  end
end
# rubocop:enable Metrics/BlockLength
