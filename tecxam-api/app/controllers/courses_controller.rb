class CoursesController < ApplicationController
  before_action :set_course, only: [:update, :destroy, :edit]
  after_action :render_json, except: [:index]

  def index
    @courses = Course.where(user: User.first) # CHANGE
    json_response(@courses)
  end

  def create
    @course = Course.create(course_params)
  end

  def update
    @course.update(course_params)
  end

  def destroy
    @course.destroy
  end

  private

  def set_course
    @course = course.find(params[:id])
  end

  def course_params
    params
      .permit(:name, :acronym, :description)
      .merge(user: User.first) # CHANGE
  end

  def render_json
    json_response(@course)
  end
end
