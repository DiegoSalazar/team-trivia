# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_player!
  before_action :set_current_trivium, only: :index
  before_action :set_question, only: %i[destroy add_answer]

  def index
    @pagy, @questions = pagy Question.recent
  end

  def new; end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to action: :index
    else
      @pagy, @questions = pagy Question.recent
      @errors = @question.errors.full_messages
      render action: :new
    end
  end

  def destroy
    @question.destroy!
    redirect_to action: :index
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body, :correct_answer, :question_type)
  end


end
