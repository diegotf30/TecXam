class Course < ApplicationRecord
  belongs_to :user
  has_many :exams
  has_many :questions, through: :exams

  validates :name, presence: true
  validates :acronym, presence: true
  validates_length_of :acronym, is: 6
end
