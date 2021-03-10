# frozen_string_literal: true

class WinnerComponent < ViewComponent::Base
  PLACES = %w[1st 2nd 3rd].freeze
  STYLES = %w[primary dark info]

  def initialize(index, team_name, score = 0)
    super
    @index = index
    @place = "#{PLACES[index]} Place"
    @team_name = team_name
    @score = score
  end

  def place_style
    "text-white bg-#{STYLES[@index]}"
  end
end
