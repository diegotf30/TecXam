class Course < ApplicationRecord
  belongs_to :user
  has_many :exams
  has_many :questions, through: :exams
end
