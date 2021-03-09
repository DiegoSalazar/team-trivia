# frozen_string_literal: true

class TriviumStatsComponent < ViewComponent::Base
  def initialize(trivium)
    @trivium = trivium
    @submissions = @trivium.submissions
  end

  def team_count
    @submissions.count
  end

  def question_count
    @trivium.questions.count
  end

  def guess_count
    @trivium.guesses.count
  end

  def correct_count
    @trivium.guesses.select(&:correct?).count
  end

  def top_score
    @submissions.max_by(&:score).score
  end

  def average_score
    @submissions.sum(&:score) / @submissions.count
  end
end
