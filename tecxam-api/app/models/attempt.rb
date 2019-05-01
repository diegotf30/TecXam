class Attempt < ApplicationRecord
  belongs_to :exam
  before_update :verify_submitability
  before_update :grade

  def grade
    total_score = 0
    answers.sort.to_h.order(:created_at).each do |q_id, ans|
      q = Question.find_by_id(q_id)
      answer_ids = eval(ans)
      correct_ids = q.correct_answers.pluck(:id)
      wrong = (correct_ids - answer_ids).count
      total_score += q.points - (wrong.to_d / correct_ids.count * points)
    end
    self.grade = total_score
  end

  private

  def verify_submitability
    if exam.close_date.nil?
      exam_still_open?
    else
      exam_still_open? && allows_multiple_attempts  
    end
  end

  def exam_still_open?
    self.exam_token == exam.token
  end

  def allows_multiple_attempts
    self.created_at <= exam.close_date
  end
end
  