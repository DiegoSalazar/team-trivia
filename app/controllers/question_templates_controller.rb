class QuestionTemplatesController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_player!
  before_action :set_question_template, only: [:destroy, :add_answer]

  def index
    @pagy, @question_templates = pagy QuestionTemplate.recent.paginate page: params[:page]
  end

  def new; end

  def create
    question_template = QuestionTemplate.new(question_template_params)

    if question_template.save!
      redirect_to action: :index
    else
      render action: :new
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
