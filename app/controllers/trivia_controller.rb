# frozen_string_literal: true

class TriviaController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_player!, except: :index
  before_action :set_current_trivium, only: %i[index reveal]
  before_action :set_trivium, only: %i[play reveal]
  before_action :set_my_trivium, only: %i[edit update destroy]

  def play
    if @trivium.upcoming? && !current_player.moderates?(@trivium)
      redirect_to root_path, alert: "That game hasn't started yet."
      return
    end

    if params[:question_id].present?
      flash.now[:guess_modal] = !flash[:close_guess_modal]
      @current_question = @trivium.questions.find params[:question_id]
    end

    @current_question ||= @trivium.questions.first
    @current_guess = @current_question.guesses.new trivium: @trivium if @current_question
    @current_guess ||= :guess
    @team_messages = current_team.team_messages_from @trivium
    @title = current_team.chat_title

    render layout: 'side_chat'
  end

  def reveal
    unless @trivium.ended?
      redirect_to play_team_trivium_path current_team, @trivium
      return
    end

    TriviumSubmitter.ensure_submissions! @trivium
  end

  # GET /trivia
  # GET /trivia.json
  def index
    @past_trivia_pagy, @past_trivia = pagy Trivium.past, page_param: 'p-page'
    @upcoming_trivia_pagy, @upcoming_trivia = pagy @current_trivium.following_trivia, page_param: 'u-page'
  end

  # GET /trivia/new
  def new
    @trivium = Trivium.new
  end

  # GET /trivia/1/edit
  def edit; end

  # POST /trivia
  # POST /trivia.json
  def create
    @trivium = current_player.trivia.build trivium_params

    if @trivium.save
      redirect_to new_trivium_question_path(@trivium), notice: 'Trivium was successfully created.'
    else
      @errors = @trivium.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /trivia/1
  # PATCH/PUT /trivia/1.json
  def update
    if @trivium.update(trivium_params)
      redirect_to new_trivium_question_path(@trivium), notice: 'Trivium was successfully updated.'
    else
      @errors = @trivium.errors.full_messages
      render :edit
    end
  end

  # DELETE /trivia/1
  # DELETE /trivia/1.json
  def destroy
    @trivium.destroy!

    respond_to do |format|
      format.html { redirect_to trivia_url, notice: 'Trivium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_trivium
    @trivium ||= Trivium.find params[:id]
  end

  def set_my_trivium
    @trivium = current_player.trivia.find params[:id]
  end

  def trivium_params
    params.require(:trivium).permit :title, :body, :game_starts_at, :game_ends_at
  end
end
