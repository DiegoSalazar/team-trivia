# frozen_string_literal: true

class CountdownComponent < ViewComponent::Base
  def initialize(start_time, end_time, redirect_to:, show: true)
    super
    @start_time = start_time
    @end_time = end_time
    @redirect_to = redirect_to
    @show = show
  end

  def render?
    @show
  end

  def countdown_data
    {
      controller: 'countdown',
      'redirect-to': @redirect_to,
      'start-time': l(@start_time, format: :iso8601),
      'end-time': l(@end_time, format: :iso8601)
    }
  end

  def starts_at
    l @start_time, format: :short
  end
end
