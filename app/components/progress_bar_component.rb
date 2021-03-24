# frozen_string_literal: true

class ProgressBarComponent < ViewComponent::Base
  def initialize(current = 0, total = 1, show: true, css_class: 'w-75')
    super
    @current = current
    @total = total
    @show = show
    @css_class = css_class
  end

  def render?
    @show
  end

  def percent
    return 0 unless @total.positive?

    (@current / @total.to_f) * 100
  end
end
