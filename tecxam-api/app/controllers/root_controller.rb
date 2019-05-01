class RootController < ApplicationController
  def take_exam
    @exam = Exam.find_by_token(room_code)
    json_response(@exam)
  end

  private

  def room_code
    params[:token]
  end
end