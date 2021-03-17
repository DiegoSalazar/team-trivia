# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_player!
  before_action :set_current_trivium, only: :index
  before_action :set_trivium, only: :new
  before_action :set_question, only: :destroy
  before_action :set_questions, only: :index

  def index; end

  def new
    @current_trivium = @trivium || Trivium.new
    @questions_pagy, @player_questions = pagy @trivium.questions_by(current_player).recent
    @trivia_pagy, @upcoming_trivia = pagy @trivium.following_trivia
    @notice = flash[:notice]
  end

  def create
    @question = current_player.questions.build question_params
    @question.save!

    flash[:notice] = 'Thank you for contributing a Question!'
    redirect_to action: :new
  end

  def update
    @question = current_player.questions.find params[:id]
    @question.update! question_params

    flash[:notice] = "Question #{@question.question_number} updated."
    redirect_to action: :new
  end

  def destroy
    @question.destroy!
    redirect_to action: :new
  end

  private

  def set_trivium
    @trivium ||= Trivium.find params[:trivium_id]
  end

  def set_question
    @question = Question.find params[:id]
  end

  def set_questions
    @pagy, @questions = pagy Question.recent
  end

  def question_params
    params.require(:question).permit \
      :body,
      :trivium_id,
      :question_type,
      :max_questions,
      answers_attributes: %i[id value points _destroy]
  end
end
