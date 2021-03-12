# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def current_play_path
    return teams_path if current_team.nil?
    return new_trivium_path unless @current_trivium&.persisted?

    play_team_trivium_path current_team, @current_trivium
  end

  def trivium_contribution_path
    if @current_trivium.nil? || @current_trivium.new_record?
      new_trivium_path
    elsif @current_trivium.started? && @current_trivium.next_trivium.present?
      new_contribution_path @current_trivium.next_trivium
    else
      new_contribution_path @current_trivium
    end
  end

  def icon(icon, options = {})
    file = File.read "node_modules/bootstrap-icons/icons/#{icon}.svg"
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'

    options.each_pair { |key, val| svg[key] = val }

    doc.to_html.html_safe
  end
end
