# frozen_string_literal: true

class TriviumBannerComponent < ViewComponent::Base
  def initialize(trivium)
    @title = trivium.title
    @body = trivium.body
    @start_time = l trivium.game_starts_at, format: :iso8601
    @end_time = l trivium.game_ends_at, format: :iso8601
  end
end