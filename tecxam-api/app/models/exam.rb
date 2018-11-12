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

  def export(answer_key: false)
    export_to_json(answer_key)
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

  def export_to_json(answer_key)
    exam_data = {
      answer_key: answer_key,
      course_name: course.name,
      exam_name: name,
      exam_date: date,
      exam_description: description,
      time_limit: time_limit,
      questions: exam_questions
    }
    File.write('tmp/exam.json', JSON.pretty_generate(exam_data))
  end

  def exam_questions
    questions.map do |q|
      {
        name: q.name,
        points: q.points,
        category: q.category,
        answers: q.answers.map do |a|
          {
            value: a.evaluate,
            correct: a.correct
          }
        end
      }
    end
  end

  def generate_pdf
    system('rulex lib/latex/exam.rex > tmp/exam.tex')
    system('pdflatex -output-directory tmp tmp/exam.tex > /dev/null')
    system('pdflatex -output-directory tmp tmp/exam.tex > /dev/null')
  end
end
