# frozen_string_literal: true

class TriviumBannerComponent < ViewComponent::Base
  attr_reader :title, :body, :start_time, :end_time

  def initialize(trivium)
    @title = trivium.title
    @body = trivium.body
    @start_time = trivium.game_starts_at
    @end_time = trivium.game_ends_at
    binding.pry # debug
  end
end
