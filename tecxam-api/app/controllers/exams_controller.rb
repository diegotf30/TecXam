class ExamsController < ApplicationController
  before_action :set_exam, only: [:update, :destroy, :edit]
  after_action :render_json, except: [:index]

  def index
    @exams = Exam.where(course: Course.second) # CHANGE
    json_response(@exams)
  end

  def create
    @exam = Exam.create(exam_params)
  end

  def update
    @exam.update(exam_params)
  end

  def destroy
    @exam.destroy
  end

  private

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params
      .permit(:name, :is_random)
      .merge(course: Course.second) # CHANGE
  end

  def render_json
    json_response(@exam)
  end
end
