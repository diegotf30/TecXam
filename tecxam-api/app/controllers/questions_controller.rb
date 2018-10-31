class QuestionsController < ApplicationController
  before_action :set_question, only: [:update, :destroy]
  before_action :require_permission, only: [:update, :destroy]

  def index
    @questions = Question.where(user: current_user) # CHANGE
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
    @tags = User.first.tags
    json_response(@tags)
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params
      .require(:question)
      .permit(:name, :tags)
      .merge(user: User.first) # CHANGE
  end

  def require_permission
    block_unless_owner(@question)
  end
end
