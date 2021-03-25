# frozen_string_literal: true

class GuessesReflex < ApplicationReflex
  def create
    @current_team = current_player.current_team
    guess = Guess.new guess_params
    trivium = guess.trivium
    guess.player = current_player
    guess.team = @current_team
    guess.save!
    @current_question = guess.question
    # Create the Guess for this Question

    # Create a voteable Message for this Guess
    message = current_player.team_messages.create! \
      team: @current_team,
      trivium: trivium,
      guess: guess

    # Upvoted question status
    question_status = QuestionStatusComponent.new \
      @current_question,
      num: @current_question.num_accepted_guesses,
      denom: @current_question.guesses.count,
      title: 'Accepted / Guesses'
    question_status_html = controller.render question_status

    # Broadcast to team
    @current_team.players.each do |player|
      next if player.id == current_player.id

      # Update their chat
      cable_ready[player.chat_channel].insert_adjacent_html \
        selector: '#team_messages',
        position: 'beforeend',
        html: controller.render(TeamMessageComponent.new(
          message: message,
          player: player,
          trivium: trivium
        ))

      # Update question status
      cable_ready[player.chat_channel].outer_html \
        selector: "##{question_status.id}",
        html: question_status_html
    end

    # Update the current_player's chat
    cable_ready.insert_adjacent_html \
      focus_selector: '#team_message_body',
      selector: '#team_messages',
      position: 'beforeend',
      html: controller.render(TeamMessageComponent.new(
        message: message,
        player: current_player,
        trivium: trivium
      ))

    # Close the guess form Modal
    cable_ready.remove \
      selector: '.modal'

    # Update current_player's question status
    cable_ready.outer_html \
      selector: "##{question_status.id}",
      html: question_status_html

    # Trigger explicit team message event so we can scroll the chat
    cable_ready.dispatch_event(
      name: 'team-message',
      selector: '#team_messages'
    )

    cable_ready.broadcast
    morph :nothing
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
    params.require(:guess).permit :value, :question_id, :trivium_id
  end
end
