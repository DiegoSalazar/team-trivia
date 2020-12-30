# frozen_string_literal: true

require 'rails_helper'

describe 'TeamMessages', type: :request do
  describe 'POST /create' do
    it 'redirects when not authenticated' do
      post '/team_messages'
      expect(response).to redirect_to new_player_session_path
    end

    context 'authenticated' do

    end
  end
end
