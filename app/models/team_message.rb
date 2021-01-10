class TeamMessage < ApplicationRecord
  belongs_to :player
  belongs_to :team
  belongs_to :trivium
  belongs_to :guess, optional: true

  scope :except_for, ->(messages) { where.not messages: { id: messages } }

  def sender_name
    player.username
  end

  def body
    return guess_body if guess_id?

    read_attribute :body
  end

  private

  def guess_body
    "Guess for question #{guess.question_template_id}: #{guess.value}"
  end
end
