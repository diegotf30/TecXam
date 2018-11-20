class Exam < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :questions

  store_accessor :random_questions
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

  def export(answer_key: false)
    generate_latex(answer_key ? 'print_answers' : '')
    generate_pdf
    true
  end

  private

  def add_random_questions
    return if random_questions.nil?

    clean_questions
    random_questions.each do |tag, amount|
      add_question(Question.where_tag(tag).sample(amount.to_i))
    end
  end

  def generate_latex(print_answers)
    system("rulex lib/latex/exam.rex #{id} #{print_answers} > tmp/exam.tex")
  end

  def generate_pdf
    system('pdflatex -output-directory tmp tmp/exam.tex > /dev/null')
    system('pdflatex -output-directory tmp tmp/exam.tex > /dev/null')
  end
end
