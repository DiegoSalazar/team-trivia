# frozen_string_literal: true

class TriviumBannerComponent < ViewComponent::Base
  def initialize(trivium, title: trivium.title, hint: trivium.body)
    super
    @trivium = trivium
    @title = title
    @body = hint
    @start_time = trivium.game_starts_at
    @end_time = trivium.game_ends_at
  end
end
