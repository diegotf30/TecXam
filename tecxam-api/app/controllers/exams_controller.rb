class ExamsController < ApplicationController
  before_action :set_exam, only: [:update, :destroy, :show, :export, :add, :answer_key, :present, :hand_out, :close, :is_open]
  before_action :require_ownership, only: [:update, :destroy, :export, :present, :hand_out, :close, :is_open]

  def index
    @exams = Exam.where(course: course)
    json_response(@exams)
  end

  def show
    json_response(@exam)
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

  def add
    if @exam.add_question(question)
      render json: question, status: :ok
    else
      validation_error(question)
    end
  end

  def export
    if @exam.export
      send_file 'tmp/exam.pdf'
    else
      validation_error(@exam)
    end
  end

  def answer_key
    if @exam.export(answer_key: true)
      send_file 'tmp/exam.pdf'
    else
      validation_error(@exam)
    end
  end

  def hand_out
    if @exam.hand_out(close_date: params[:close_date])
      render json: @exam, status: :ok
    else
      validation_error(@exam)
    end
  end

  def close
    if @exam.close
      render json: @exam, status: :ok
    else
      validation_error(@exam)
    end
  end

  def is_open
    if @exam.open?
      render json: @exam, status: :ok
    else
      validation_error(@exam)
    end
  end

  def random_questions
    json_response(questions.order("RANDOM()"))
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def set_exam
    @exam = Exam.find(params[:id] || params[:exam_id])
  end

  def exam_params
    params
      .require(:exam)
      .permit(:name, :description, :date, :time_limit, random_questions: {})
      .merge(course: course)
  end

  def require_ownership
    block_unless_owner(@exam)
  end
end