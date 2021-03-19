# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_player!
  before_action :set_current_trivium, only: :index
  before_action :set_trivium, only: %i[new create]
  before_action :set_question, only: :destroy
  before_action :set_questions, only: :index

  def index; end

  def new
    @current_trivium = @trivium || Trivium.new

    @questions = @trivium.questions_by current_player
    @questions = @trivium.questions if current_player.moderates? @trivium
    @questions_pagy, @questions = pagy @questions, page_param: 'q-page'
    @trivia_pagy, @upcoming_trivia = pagy @trivium.following_trivia, page_param: 't-page'

    @notice = flash[:notice]
    @new_question = current_player.questions.build trivium_id: @trivium.id
    @new_question.answers.build
  end

  def create
    @question = current_player.questions.build question_params
    @question.save!

    flash[:commit] = params[:commit]
    flash[:notice] = "Question #{@question.question_number} created"
    redirect_to action: :new
  end

  def update
    @question = current_player.questions.find params[:id]
    @question.update! question_params

    flash[:notice] = "Question #{@question.question_number} updated"
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
    @pagy, @questions = pagy Question.all
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
