class Exam < ApplicationRecord
  store_accessor :random_questions

  belongs_to :course
  has_and_belongs_to_many :questions

  before_save :add_random_questions

  def add_question(q)
    questions << q
  end

  def remove_question(q)
    questions.delete(q)
  end

  def user
    course.user
  end

  def clean_questions
    questions.delete_all
  end

  def export
    require 'rake'

    load File.join(Rails.root, 'lib', 'tasks', 'exams.rake')
    Rake::Task['exams:json'].invoke(id)
    Rake::Task['exams:pdf'].invoke
  end

  private

  def add_random_questions
    return if random_questions.nil?

    clean_questions
    random_questions.each do |tag, amount|
      add_question(Question.where_tag(tag).sample(amount.to_i))
    end
  end
end
