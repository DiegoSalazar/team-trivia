# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :authenticate_player!
  before_action :set_current_trivium, only: :play
  before_action :ensure_player_team!, only: %i[play update]
  before_action :set_team, only: %i[show edit update destroy]

  def play
    @current_question ||= current_trivium.questions.first
    @current_guess = @current_question.guesses.new trivium: current_trivium
    @team_messages = current_team.team_messages_from current_trivium
    @title = current_team.chat_title

    render layout: 'side_chat'
  end

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    @team_count = @teams.count
  end

  # GET /teams/1
  # GET /teams/1.json
  def show; end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit; end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if current_team.update(team_params)
        format.html { redirect_to current_team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: current_team }
      else
        format.html { render :edit }
        format.json { render json: current_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    current_team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = Team.find params[:id]
  end
end
