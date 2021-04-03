# frozen_string_literal: true

class GuessesController < ApplicationController
  include CableReady::Broadcaster

  before_action :authenticate_player!
  before_action :set_current_trivium, only: :create
  before_action :set_guess, only: %i[show edit update destroy]

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = Guess.all
  end

  # GET /guesses/1
  # GET /guesses/1.json
  def show; end

  # GET /guesses/new
  def new
    @guess = Guess.new
  end

  # GET /guesses/1/edit
  def edit; end

  # POST /guesses
  def create
    @current_team = current_player.current_team
    guess = current_trivium.guesses.build guess_params
    guess.player = current_player
    guess.team = @current_team
    guess.save!
    @current_question = guess.question

    # Create a voteable Message for this Guess
    message = current_player.team_messages.create! \
      team: @current_team,
      trivium: current_trivium,
      guess: guess

    # Upvoted question status
    question_status = QuestionStatusComponent.new \
      @current_question,
      num: @current_question.num_accepted_guesses,
      denom: @current_question.guesses.count,
      title: 'Accepted / Guesses'
    question_status_html = question_status.render_in view_context

    # Broadcast message to team including current_player
    @current_team.players.each do |player|
      # Update their chat
      cable_ready[player.chat_channel].insert_adjacent_html \
        selector: '#team_messages',
        position: 'beforeend',
        html: TeamMessageComponent.new(
          message: message,
          player: player,
          trivium: current_trivium
        ).render_in(view_context)

      # Update question status
      cable_ready[player.chat_channel].outer_html \
        selector: "##{question_status.id}",
        html: question_status_html

      # Trigger explicit team message event so we can scroll the chat
      cable_ready[player.chat_channel].dispatch_event(
        name: 'team-message',
        selector: '#team_messages'
      )
    end

    # Close the guess form Modal
    cable_ready[current_player.chat_channel].remove selector: '.modal'
    cable_ready[current_player.chat_channel].push_state url: close_path
    flash[:close_guess_modal] = true

    cable_ready.broadcast
  end

  # PATCH/PUT /guesses/1
  # PATCH/PUT /guesses/1.json
  def update
    respond_to do |format|
      if @guess.update(guess_params)
        format.html { redirect_to @guess, notice: 'Guess was successfully updated.' }
        format.json { render :show, status: :ok, location: @guess }
      else
        format.html { render :edit }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guesses/1
  # DELETE /guesses/1.json
  def destroy
    @guess.destroy
    respond_to do |format|
      format.html { redirect_to guesses_url, notice: 'Guess was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_guess
    @guess = Guess.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def guess_params
    params.require(:guess).permit \
      :trivum_id,
      :question_id,
      :value
  end

  def close_path
    play_team_trivium_path current_player.current_team, current_trivium
  end
end
