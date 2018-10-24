class Question < ApplicationRecord
  has_and_belongs_to_many :exams
  has_many :answers
  belongs_to :user
end
