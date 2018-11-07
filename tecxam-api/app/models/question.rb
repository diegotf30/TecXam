class Question < ApplicationRecord
  has_and_belongs_to_many :exams
  has_many :answers
  belongs_to :user

  def self.where_tag(tag)
    Question.where('tags @> ?', "{#{tag}}")
  end

  def add_tag(t)
    tags_will_change!
    tags << t
    save
  end
end
