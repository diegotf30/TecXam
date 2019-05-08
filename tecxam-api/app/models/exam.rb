class Exam < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :questions
  has_many :attempts

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

  def hand_out(close_date: nil)
    self.token = loop do
      random_token = rand(10 ** 5).to_s.rjust(5, '0')
      break random_token unless Exam.exists?(token: random_token)
    end
    self.close_date = close_date
    save
  end

  def close
    self.close_date = Date.current
    save
  end

  def open?
    if self.token?
      return self.close_date ? self.close_date < Date.current : true
    else
      return false
    end
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
