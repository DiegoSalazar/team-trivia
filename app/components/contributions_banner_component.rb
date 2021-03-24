# frozen_string_literal: true

class ContributionsBannerComponent < ViewComponent::Base
  def initialize(trivium, team)
    super
    @trivium = trivium
    @team = team
    @current_progress = trivium.questions.count
    @progress_max = trivium.max_questions
  end

  def status_text
    return '' if @trivium.new_record?

    @trivium.full? ? "#{trivium_status} questions" : "Only #{trivium_status} questions"
  end

  def call_to_action
    return '' if @trivium.new_record? || @trivium.ended?
    return 'Ready to Play!' if @trivium.full?

    "Create up to #{badge q_count_diff, 'badge-dark'} more!"
  end

  private

  def trivium_status
    "#{badge @trivium.questions.count} out of #{badge @trivium.max_questions}"
  end

  def badge(text, klass = nil)
    content_tag :span, text, class: "badge #{klass || status_class}"
  end

  def status_class
    klass = 'badge-warning'
    klass = 'badge-success' if @trivium.full?
    klass
  end

  def q_count_diff
    @trivium.max_questions - @trivium.questions.count
  end
end
