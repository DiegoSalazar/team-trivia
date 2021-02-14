# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def current_play_path
    return teams_path if current_team.nil?

    play_team_path current_team
  end

  def icon(icon, options = {})
    file = File.read "node_modules/bootstrap-icons/icons/#{icon}.svg"
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'

    options.each_pair { |key, val| svg[key] = val }

    doc.to_html.html_safe
  end
end
