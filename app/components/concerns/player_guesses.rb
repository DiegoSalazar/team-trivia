# frozen_string_literal: true

module PlayerGuesses
  private

  def sender?
    @player.id == @message.player_id
  end

  def their_guess_accepted?
    @guess&.accepted? && !sender?
  end

  def my_guess_accepted?
    @guess&.accepted? && sender?
  end
end
