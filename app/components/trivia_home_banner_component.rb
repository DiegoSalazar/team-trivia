# frozen_string_literal: true

class TriviaHomeBannerComponent < ViewComponent::Base
  renders_one :footer
  delegate :current_player, to: :controller

  def initialize(trivium, team = nil)
    super
    @trivium = trivium
    @team = team
    set_title_and_hint
  end

  def set_title_and_hint
    @title = 'Create new Trivia!'
    @hint = @trivium.title

    if @trivium.upcoming?
      @title = 'Trivia starts in...'
    elsif @trivium.active?
      @title = 'Playing now! Ends in...'
    elsif @trivium.ended?
      @title = 'Trivia Ended'
    else
      @hint = 'Contribute questions to upcoming Trivia!'
    end
  end

  def edit_trivium_button
    return if @trivium.new_record? || @trivium.started?
    return unless current_player&.moderates? @trivium

    content_tag :div, class: 'mt-2 text-right' do
      link_to 'Edit', edit_trivium_path(@trivium), class: 'btn btn-sm btn-secondary'
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
