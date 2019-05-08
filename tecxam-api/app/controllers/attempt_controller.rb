class AttemptsController < ApplicationController
  before_action :set_attempt, only: [:show, :update, :destroy]
  before_action :skip_authenticate_user!

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

  def take_exam
    json_response(exam)
  end

  private

  def attempt_params
    params
      .require(:attempt)
      .permit(:exam_token, :student_id)
      .merge(exam: exam)
  end

  def exam
    @exam ||= Exam.find_by_token(room_code)
  end

  def set_attempt
    @attempt = Attempt.find(params[:id])
  end

  def room_code
    params[:token]
  end
end
  