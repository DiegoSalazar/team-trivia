# frozen_string_literal: true

class MessagesReflex < ApplicationReflex
  delegate :current_player, to: :connection

  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  # TODO: remove mock team
  def create
    message = current_player.messages.new message_params
    message.team = current_player.current_team || Team.find(1)
    message.trivium = Trivium.active
    message.save!
  end

  private

  def message_params
    params.require(:message).permit :body
  end
end
