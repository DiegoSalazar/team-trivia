# frozen_string_literal: true

class GuessesController < ApplicationController
  before_action :set_guess, only: %i[show edit update destroy]

  skip_before_action :verify_authenticity_token, only: [:vote]

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
  # POST /guesses.json
  def create
    @guess = Guess.new(guess_params)

    respond_to do |format|
      if @guess.save
        format.html { redirect_to @guess, notice: 'Guess was successfully created.' }
        format.json { render :show, status: :created, location: @guess }
      else
        format.html { render :new }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
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
    params.require(:guess).permit(:submission_id, :question_id, :user_id, :value)
  end
end
