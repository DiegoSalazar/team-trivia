# frozen_string_literal: true

class TriviumStatsComponent < ViewComponent::Base
  def initialize(trivium)
    super
    @trivium = trivium
    @submissions = @trivium.submissions
  end

  def stats
    [
      { label: 'Teams', value: team_count },
      { label: 'Questions', value: question_count },
      { label: 'Guesses', value: guess_count },
      { label: 'Votes', value: vote_count },
      { label: 'Correct', value: correct_count },
      { label: 'Average Score', value: average_score },
      { label: 'Top Score', value: top_score }
    ]
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

  def vote_count
    Vote.where(votable_id: @trivium.guess_ids).count
  end

  def correct_count
    @trivium.guesses.select(&:correct?).count
  end

  def top_score
    @submissions.max_by(&:score).score
  end

  def average_score
    (@submissions.sum(&:score) / @submissions.count.to_f).round 1
  end
end
