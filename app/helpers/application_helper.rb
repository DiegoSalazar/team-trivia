# frozen_string_literal: true

module ApplicationHelper
  def icon(icon, options = {})
    file = File.read "node_modules/bootstrap-icons/icons/#{icon}.svg"
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'

    options.each_pair { |key, val| svg[key] = val }

    doc.to_html.html_safe
  end
end
