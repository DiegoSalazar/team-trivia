# frozen_string_literal: true

class TriviumBannerComponent < ViewComponent::Base
  def initialize(trivium, title: trivium.title, hint: trivium.body, show_countdown: true)
    super
    @trivium = trivium
    @title = title
    @body = hint
    @show_countdown = show_countdown
    @start_time = trivium.game_starts_at
    @end_time = trivium.game_ends_at
  end

  def countdown
    return if @trivium.new_record?

    render CountdownComponent.new \
      @start_time,
      @end_time,
      redirect_to: reveal_trivium_path(@trivium),
      show: @show_countdown
  end
end
