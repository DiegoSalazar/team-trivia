# frozen_string_literal: true

class WinnerComponent < ViewComponent::Base
  PLACES = %w[1st 2nd 3rd].freeze
  STYLES = %w[primary dark info].freeze

  def initialize(winner_name, index = 0, score = 0)
    super
    @winner_name = winner_name
    @index = index
    @place = "#{PLACES[index]} Place"
    @score = score
  end

  def place_style
    "text-white bg-#{STYLES[@index]}"
  end
end
