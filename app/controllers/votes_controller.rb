class VotesController < ApplicationController
  include CableReady::Broadcaster

  before_action :authenticate_player!
  before_action :set_current_trivium

  def create
    @current_guess = current_trivium.guesses.find params[:id]
    @current_question = @current_guess.question
    @current_team = current_player.current_team
    @title = @current_team.chat_title
    @team_messages = @current_team.team_messages
    @message = @current_guess.team_message

    @current_guess.vote_by voter: current_player

    # Upvoted question status
    question_status = QuestionStatusComponent.new \
      @current_question,
      num: @current_question.num_accepted_guesses,
      denom: @current_question.guesses.count,
      title: 'Accepted / Guesses'
    question_status_html = render_to_string question_status

    # Broadcast message to team and current_player
    @current_team.players.each do |player|
      # Update their chat
      cable_ready[player.chat_channel].outer_html \
        selector: dom_id(@message),
        html: render_to_string(TeamMessageComponent.new(
          message: @message,
          player: player,
          trivium: current_trivium
        ))

      # Update question status
      cable_ready[player.chat_channel].outer_html \
        selector: "##{question_status.id}",
        html: question_status_html
    end

    cable_ready.broadcast
    render nothing: true
  end
end
