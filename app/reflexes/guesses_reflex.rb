# frozen_string_literal: true

class GuessesReflex < ApplicationReflex
  include CableReady::Broadcaster

  def create
    binding.pry # debug
    # Create the Guess for this QuestionTemplate
    # Create a voteable Message for this Guess
    # Broadcast this Message
    # Refresh the question and answer form input views
  end

  def vote
    guess = Guess.find(element.dataset[:id])
    guess.increment! :likes
    cable_ready["submission"].text_content(
      selector: "#guess-#{guess.id}-votes",
      text: "Vote (#{guess.likes})"
    )
    cable_ready.broadcast
  end
end
