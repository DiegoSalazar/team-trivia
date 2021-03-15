# frozen_string_literal: true

module Support
  module Features
    module Login
      def login_player_one!
        current_player! or raise 'Failed to create Player 1'
        login_player_one
        expect(page).to have_content current_player.username
      end

      def login_player_one
        visit new_player_session_path
        fill_in 'Email', with: ENV['TEAM_TRIVIA_TEST_EM']
        fill_in 'Password', with: ENV['TEAM_TRIVIA_TEST_PW']
        page.find('[type="submit"]').click
      end

      def current_player!
        raise KeyError, 'missing env var TEAM_TRIVIA_TEST_EM' if ENV['TEAM_TRIVIA_TEST_EM'].blank?
        raise KeyError, 'missing env var TEAM_TRIVIA_TEST_PW' if ENV['TEAM_TRIVIA_TEST_PW'].blank?

        current_player || FactoryBot.create(
          :player,
          email: ENV['TEAM_TRIVIA_TEST_EM'],
          password: ENV['TEAM_TRIVIA_TEST_PW']
        )
      end

      def current_player
        Player.first
      end
    end
  end
end
