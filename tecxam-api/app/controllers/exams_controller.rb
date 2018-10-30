class ExamsController < ApplicationController
  before_action :set_exam, only: [:update, :destroy, :add_question]

  def index
    @exams = Exam.where(course: params[:course_id])
    json_response(@exams)
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      render json: @exam, status: :ok
    else
      validation_error(@exam)
    end
  end

  def update
    if @exam.update(exam_params)
      render json: @exam, status: :ok
    else
      validation_error(@exam)
    end
  end

  def destroy
    if @exam.destroy
      render json: @exam, status: :ok
    else
      validation_error(@exam)
    end
  end

  def add_question
    @question = Question.find(params[:question_id])

    if @exam.add_question(@question)
      render json: @question, status: :ok
    else
      validation_error(@exam)
    end
  end

  private

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params
      .require(:exam)
      .permit(:name, :is_random)
      .merge(course: params[:course_id])
  end
end
