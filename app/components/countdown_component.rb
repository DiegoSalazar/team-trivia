# frozen_string_literal: true

class CountdownComponent < ViewComponent::Base
  def initialize(start_time, end_time, redirect_to: new_trivium_path, redirect_msg: '', show: true)
    super
    @start_time = start_time
    @end_time = end_time
    @redirect_to = redirect_to
    @redirect_msg = redirect_msg
    @show = show
  end

  def render?
    @show
  end

  def countdown_data
    {
      controller: 'countdown',
      'redirect-to': @redirect_to,
      'redirect-msg': @redirect_msg,
      'start-time': l(@start_time, format: :iso8601),
      'end-time': l(@end_time, format: :iso8601)
    }
  end

  def starts_at
    l @start_time, format: :long
  end
end
