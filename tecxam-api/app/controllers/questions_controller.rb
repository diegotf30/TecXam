class QuestionsController < ApplicationController
  before_action :set_question, only: [:update, :destroy]
  before_action :require_ownership, only: [:update, :destroy]

  def index
    @questions = Question.where(user: current_user)
    json_response(@questions)
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :ok
    else
      validation_error(@question)
    end
  end

  def update
    if @question.update(question_params)
      render json: @question, status: :ok
    else
      validation_error(@question)
    end
  end

  def destroy
    if @question.destroy
      render json: @question, status: :ok
    else
      validation_error(@question)
    end
  end

  def tags
    @tags = current_user.tags
    render json: @tags, status: :ok
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params
      .require(:question)
      .permit(:name, :points, :category, tags: [])
      .merge(user: current_user)
  end

  def require_ownership
    block_unless_owner(@question)
  end
end
