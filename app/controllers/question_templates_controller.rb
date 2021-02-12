class QuestionTemplatesController < ApplicationController
  before_action :authenticate_player!
  before_action :set_question_template, only: [:destroy, :add_answer]

  def index
    @question_templates = QuestionTemplate.paginate page: params[:page]
  end

  def show

  end

  def update

  end

  def new
    @question_template = QuestionTemplate.new
  end

  def create
    @question_template = QuestionTemplate.new(question_template_params)
    if @question_template.save
      redirect_to action: :index
    end
  end

  def destroy
    @question_template.destroy!
    redirect_to action: :index
  end

  private

  def set_question_template
    @question_template = QuestionTemplate.find(params[:id])
  end

  def question_template_params
    params.require(:question_template).permit(:body, :correct_answer, :question_type)
  end


end
