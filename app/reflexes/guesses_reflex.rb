# frozen_string_literal: true

class GuessesReflex < ApplicationReflex
  include CableReady::Broadcaster

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
