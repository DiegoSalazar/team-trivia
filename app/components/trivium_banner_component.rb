# frozen_string_literal: true

class TriviumBannerComponent < ViewComponent::Base
  def initialize(trivium)
    super
    @trivium = trivium
    @title = trivium.title
    @body = trivium.body

    # TODO: remove after testing
    # @start_time = l trivium.game_starts_at, format: :iso8601
    # @end_time = l trivium.game_ends_at, format: :iso8601
    @test_start_time = 1.hour + 22.minutes
    @start_time = l @test_start_time.from_now, format: :iso8601
    @end_time = l (@test_start_time + 15.minutes).from_now, format: :iso8601

  end

  def starts_at
    # TODO: remove after testing
    # l @trivium.game_starts_at, format: :short
    l @test_start_time.from_now, format: :short
  end
end
