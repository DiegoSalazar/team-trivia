# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_action_cable_identifier
  helper_method :current_team, :current_trivium
  attr_reader :current_trivium

  protected

  def current_team
    current_player&.current_team
  end

  def ensure_player_team!
    redirect_to teams_path if current_team.nil?
  end

  def set_current_trivium
    @current_trivium = Trivium.active
    @current_trivium ||= Trivium.upcoming.first
    @current_trivium ||= Trivium.new title: 'Create the next Trivia!'
  end

  private

  def set_action_cable_identifier
    cookies.encrypted[:session_id] = session.id.to_s
  end
end
