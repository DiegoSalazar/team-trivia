# frozen_string_literal: true

require 'application_system_test_case'

class TriviaTest < ApplicationSystemTestCase
  setup do
    @trivium = trivia(:one)
  end

  test 'visiting the index' do
    visit trivia_url
    assert_selector 'h1', text: 'Trivia'
  end

  test 'creating a Trivium' do
    visit trivia_url
    click_on 'New Trivium'

    fill_in 'Body', with: @trivium.body
    fill_in 'Game ends at', with: @trivium.game_ends_at
    fill_in 'Game starts at', with: @trivium.game_starts_at
    fill_in 'Likes count', with: @trivium.likes_count
    fill_in 'Questions count', with: @trivium.questions_count
    fill_in 'Title', with: @trivium.title
    click_on 'Create Trivium'

    assert_text 'Trivium was successfully created'
    click_on 'Back'
  end

  test 'updating a Trivium' do
    visit trivia_url
    click_on 'Edit', match: :first

    fill_in 'Body', with: @trivium.body
    fill_in 'Game ends at', with: @trivium.game_ends_at
    fill_in 'Game starts at', with: @trivium.game_starts_at
    fill_in 'Likes count', with: @trivium.likes_count
    fill_in 'Questions count', with: @trivium.questions_count
    fill_in 'Title', with: @trivium.title
    click_on 'Update Trivium'

    assert_text 'Trivium was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Trivium' do
    visit trivia_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Trivium was successfully destroyed'
  end
end
