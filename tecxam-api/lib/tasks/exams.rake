namespace :exams do
  desc "Convert exam data to JSON for pdfLaTeX"
  task :json, [:exam_id] do |task, args|
    exam = Exam.find_by(id: args[:exam_id])

    exam_data = {
      course_name: exam.course.name,
      exam_name: exam.name,
      exam_date: exam.date,
      exam_description: exam.description,
      time_limit: exam.time_limit,
      questions: exam_questions(exam)
    }

    File.write('tmp/exam.json', JSON.pretty_generate(exam_data))
  end

  desc "generates LaTeX using RuLeX and then exports it to PDF"
  task :pdf do
    system('rulex lib/latex/exam.rex > tmp/exam.tex')
    system('pdflatex -output-directory tmp tmp/exam.tex > /dev/null')
    system('pdflatex -output-directory tmp tmp/exam.tex > /dev/null')
  end

  def exam_questions(exam)
    exam.questions.map do |q|
      {
        name: q.name,
        points: q.points,
        category: q.category,
        answers: q.answers.map { |a| a.name }.to_a
      }
    end
  end
end
