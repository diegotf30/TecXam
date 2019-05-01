class AttemptsController < ApplicationController
  before_action :set_attempt, only: [:show, :update, :destroy]

  def index
    @attempts = Attempt.where(exam: exam)
    json_response(@attempts)
  end

  def show
    json_response(@attempt)
  end

  def create
    @attempt = Attempt.new(attempt_params)

    if @attempt.save
      render :show, status: :created, location: @attempt
    else
      validation_error(@attempt)
    end
  end

  def update
    if @attempt.update(attempt_params)
      render :show, status: :ok, location: @attempt
    else
      validation_error(@attempt)
    end
  end

  def destroy
    @attempt.destroy
  end

  private

  def attempt_params
    params
      .require(:attempt)
      .permit(:exam_token, :student_id)
      .merge(exam: exam)
  end

  def set_attempt
    @attempt = Attempt.find(params[:id])
  end

  def exam
    @exam ||= Exam.find(params[:exam_id])
  end
end
