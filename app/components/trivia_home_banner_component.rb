# frozen_string_literal: true

class TriviaHomeBannerComponent < ViewComponent::Base
  with_content_areas :footer

  def initialize(trivium, team = nil)
    super
    @trivium = trivium
    @team = team
    set_title_and_hint
  end

  def set_title_and_hint
    if @trivium.upcoming?
      @title = 'Trivia starts in...'
      @hint = @trivium.title
    elsif @trivium.started?
      @title = 'Playing now! Ends in...'
      @hint = @trivium.title
    else
      @title = 'Create new Trivia!'
      @hint = 'Contribute questions to upcoming Trivia!'
    end
  end

  def start_time
    @trivium.started? ? @trivium.game_ends_at : @trivium.game_starts_at
  end

  def redirect_msg
    @trivium.started? ? 'Go see the Reveal' : 'Ready to play!'
  end

  def redirect_to
    return if @trivium.new_record?
    return helpers.reveal_trivium_path @trivium if @trivium.started?
    return helpers.play_team_trivium_path @team, @trivium if @team

    helpers.teams_path
  end

  def countdown
    component = CountdownComponent.new \
      start_time,
      @trivium.game_ends_at,
      show: @trivium.persisted?,
      redirect_to: redirect_to,
      redirect_msg: redirect_msg

    render component
  end
end