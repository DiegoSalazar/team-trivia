# frozen_string_literal: true

class SubmissionsController < ApplicationController
  include CableReady::Broadcaster

  # skip_before_action :verify_authenticity_token, only: [:add_guess]

  before_action :set_submission, only: %i[show update destroy]
  before_action :authenticate_player!

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show; end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
    @trivium = Trivium.find(submission_params[:trivium_id])
    @submission = Submission.find_by(submission_params) || Submission.create(submission_params)
    # Init guesses with likes starts with 0
    if @submission.guesses.length == 0
      @trivium.questions.each do |question|
        question.answer_templates.each do |answer_template|
          guess = Guess.create!(
            submission_id: @submission.id,
            question_id: question.id,
            value: answer_template.body
          )
        end
      end
      @submission.reload
    end
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_guess
    if (params[:guess].present?)
      Guess.create!(
        submission_id: params[:submission_id],
        question_id: params[:question_id],
        value: params[:guess]
      )
      redirect_back(fallback_location: root_path)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find_by(submission_params) || Submission.create(submission_params)
  end

  # Only allow a list of trusted parameters through.
  def submission_params
    params.permit(:trivium_id, :team_id)
  end
end
