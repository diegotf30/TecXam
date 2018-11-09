module Exams
  class QuestionsController < ApplicationController
    before_action :set_question, only: [:update, :destroy]
    before_action :require_ownership, only: [:update, :destroy]

    def index
      json_response(exam.questions)
    end

    def create
      @question = Question.new(question_params)

      if @question.save
        exam.add_question(@question)
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
      if exam.remove_question(@question)
        render json: @question, status: :ok
      else
        validation_error(@question)
      end
    end

    private

    def exam
      @exam ||= Exam.find(params[:exam_id])
    end

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
end