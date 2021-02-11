# frozen_string_literal: true

class ChatComponent < ViewComponent::Base
  include ViewComponent::SlotableV2

  renders_many :messages, :TeamMessageComponent

  def initialize(title, messages, player, trivium)
    super
    @title = title
    @messages = messages
    @player = player
    @trivium = trivium
  end
end
