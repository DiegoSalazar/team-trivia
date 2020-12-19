# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_action_cable_identifier

  helper_method :current_team, :current_trivium

  protected

  def current_team
    current_player&.current_team
  end

  def current_trivium
    Trivium.active
  end

  def ensure_player_team!
    redirect_to teams_path if current_team.nil?
  end

  private

  def set_action_cable_identifier
    cookies.encrypted[:session_id] = session.id.to_s
  end
end
