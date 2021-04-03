# frozen_string_literal: true

require 'rails_helper'

feature 'Profile', type: :feature do
  before do
    login_player_one!
    visit player_path current_player
  end

  context 'Show' do
    it 'displays my Username' do
      expect(page).to have_content current_player.username
    end

    it 'displays my Email' do
      expect(page).to have_content current_player.email
    end

    it 'displays my Team name' do
      expect(page).to have_content current_player.current_team.name
    end
  end

  context 'Edit' do
    let!(:new_team) { create :team }
    let(:new_email) { "some-#{rand}@email.com" }
    let(:new_username) { "user-#{rand}" }
    before { click_on 'Edit' }

    it 'displays the Edit Player form' do
      expect(page).to have_content 'Edit Player'
    end

    it 'lets me update my email' do
      fill_in 'Email', with: new_email

      expect { click_on 'Update Player' }
        .to change { current_player.email }
        .to new_email
    end

    it 'lets me update my username' do
      fill_in 'Username', with: new_username

      expect { click_on 'Update Player' }
        .to change { current_player.username }
        .to new_username
    end

    it 'lets me update my team' do
      select new_team.name, from: 'Team'

      expect { click_on 'Update Player' }
        .to change { current_player.current_team.name }
        .to new_team.name
    end
  end
end
