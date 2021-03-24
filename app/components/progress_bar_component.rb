# frozen_string_literal: true

class ProgressBarComponent < ViewComponent::Base
  def initialize(current = 0, total = 1, show: true, height: '1rem')
    super
    @current = current
    @total = total
    @show = show
    @height = height
  end

  def render?
    @show
  end

  def percent
    return 0 unless @total.positive?

    (@current / @total.to_f) * 100
  end

  def style
    "width: #{percent}%; height: #{@height};"
  end
end
