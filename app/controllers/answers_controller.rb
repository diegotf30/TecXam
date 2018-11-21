class AnswersController < ApplicationController
  before_action :set_answer, only: [:update, :destroy, :edit]
  before_action :require_ownership, only: [:update, :destroy]

  def index
    @answers = Answer.where(question: question)
    json_response(@answers)
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render json: @answer, status: :ok
    else
      validation_error(@answer)
    end
  end

  def update
    if @answer.update(answer_params)
      render json: @answer, status: :ok
    else
      validation_error(@answer)
    end
  end

  def destroy
    if @answer.destroy
      render json: @answer, status: :ok
    else
      validation_error(@answer)
    end
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params
      .require(:answer)
      .permit(:name, :correct)
      .merge(question: question)
  end

  def require_ownership
    block_unless_owner(@answer)
  end
end
