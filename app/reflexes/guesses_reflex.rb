# frozen_string_literal: true

class GuessesReflex < ApplicationReflex
  include CableReady::Broadcaster

  def create
    current_trivium = Trivium.active
    @current_guess = Guess.create! guess_params
    @current_question = @current_guess.question_template
    # Create the Guess for this QuestionTemplate
    
    # Create a voteable Message for this Guess
    message = current_player.team_messages.create! \
      team: current_player.current_team,
      trivium: current_trivium,
      guess: @current_guess

    # Broadcast this Message
    current_player.current_team.players.each do |player|
      message_html = controller.render TeamMessageComponent.new(
        message: message,
        player: player
      )
      cable_ready[player.chat_channel].insert_adjacent_html(
        selector: '#team_messages',
        position: 'beforeend',
        html: message_html
      )
    end

    cable_ready[current_player.chat_channel].insert_adjacent_html(
      selector: '#team_messages',
      position: 'beforeend',
      html: controller.render(TeamMessageComponent.new(message: message, player: current_player))
    )
    
    # Refresh the question and answer form input views
    cable_ready[current_player.chat_channel].inner_html(
      selector: '#guess_form',
      focus_selector: '#guess_value',
      html: controller.render_to_string(partial: 'teams/guess_form', locals: { guess: Guess.new, reflex_root: '#guess_form' })
    )
    cable_ready.broadcast
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

  private

  def guess_params
    params.require(:guess).permit :value, :question_template_id
  end
end
