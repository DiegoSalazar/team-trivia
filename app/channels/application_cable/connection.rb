# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = authenticated_player
    end

    protected

    def authenticated_player
      player = env['warden'].user
      return player if player.present?

      reject_unauthorized_connection
    end
  end
end
