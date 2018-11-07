class ExamsController < ApplicationController
  before_action :set_exam, only: [:update, :destroy, :add_question, :export]
  before_action :require_ownership, only: [:update, :destroy, :export]

  def index
    @exams = Exam.where(course: course)
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

  def export
    if @exam.export
      send_file 'tmp/exam.pdf'
    else
      validation_error(@exam)
    end
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def set_exam
    @exam = Exam.find(params[:id] || params[:exam_id])
  end

  def exam_params
    params
      .require(:exam)
      .permit(:name, random_questions: {})
      .merge(course: course)
  end

  def require_ownership
    block_unless_owner(@exam)
  end
end