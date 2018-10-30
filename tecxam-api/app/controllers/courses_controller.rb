class CoursesController < ApplicationController
  before_action :set_course, only: [:update, :destroy]

  def index
    @courses = Course.where(user: current_user)
    json_response(@courses)
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :ok
    else
      validation_error(@course)
    end
  end

  def update
    if @course.update(course_params)
      render json: @course, status: :ok
    else
      validation_error(@course)
    end
  end

  def destroy
    if @course.destroy
      render json: @course, status: :ok
    else
      validation_error(@course)
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params
      .require(:course)
      .permit(:name, :acronym, :description)
      .merge(user: current_user)
  end

  def render_json
    json_response(@course)
  end
end
