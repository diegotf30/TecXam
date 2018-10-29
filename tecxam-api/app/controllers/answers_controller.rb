class AnswersController < ApplicationController
  before_action :set_answer, only: [:update, :destroy, :edit]
  after_action :render_json, except: [:index]

  def index
    @answers = Answer.where(question: question) # CHANGE
    json_response(@answers)
  end

  def create
    @answer = Answer.create(answer_params)
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end

  private

  def question
    @question ||= Pool.find(params[:question_id])
  end

  def set_answer
    @answer = answer.find(params[:id])
  end

  def answer_params
    params
      .permit(:name, :variables)
      .merge(user: User.first, question: question) # CHANGE
  end

  def render_json
    json_response(@answer)
  end
end
