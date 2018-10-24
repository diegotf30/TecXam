class Exam < ApplicationRecord
  has_and_belongs_to_many :questions
  belongs_to :user

  def add_question(q)
    questions << q
  end
end
