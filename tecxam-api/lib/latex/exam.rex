require File.expand_path('../config/environment', __FILE__)
require './lib/season'

def eval(answer)
  return answer&.evaluate(answer_key: true)
end

def print_answers?
  return ARGV.dig(2) == 'print_answers'
end

def single_column(category, answers)
  raw "\\begin{#{category}}\n"
    answers.each do |a|
      if a.correct
        CorrectChoice eval(a)
      else
        choice eval(a)
      end
    end
  raw "\\end{#{category}}\n"
end

def question(category, answers)
  columns = answers.count / 4
  if columns > 1
    multicols columns do
      single_column(category, answers)
    end
  else
    single_column(category, answers)
  end
end

def box(size, answer)
  raw "\\begin{solutionorbox}[#{size}]\n"
    raw eval(answer) || "Seccion revisada por el profesor.\n"
  raw "\\end{solutionorbox}\n"
end

def paragraph(answer)
  raw "\\begin{solutionordottedlines}[2in]\n"
    raw eval(answer) || "Seccion revisada por el profesor.\n"
  raw "\\end{solutionordottedlines}\n"
end

def essay(answer)
  raw "\\ifprintanswers\n"
    raw "\\begin{solutionorlines}[2in]\n"
      raw eval(answer) || "Seccion revisada por el profesor.\n"
    raw "\\end{solutionorlines}\n"
  raw "\\else\n"
    fillwithlines '\fill'
    newpage
  raw "\\fi\n"
end

exam = Exam.find_by(id: ARGV[1])

nonstopmode
documentclass 'lib/latex/exam'

printanswers if print_answers?

<##
\usepackage[utf8]{inputenc}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amssymb}
\usepackage{multicol}
\usepackage{color}

##>

newcommand '\\class', exam.course.name
newcommand '\\term', "#{Date.today.season} #{Date.today.year}"
newcommand '\\examnum', exam.name.split.map(&:capitalize).join(' ')
newcommand '\\examdate', exam.date
newcommand '\\timelimit', "#{exam.time_limit} Minutos"

<##
\pagestyle{head}
\firstpageheader{}{}{}
\runningheader{\class}{\examnum\ - Page \thepage\ of \numpages}{\examdate}
\runningheadrule
\CorrectChoiceEmphasis{\color{red}\bfseries}

##>

document do

<##
\noindent
\begin{tabular*}{\textwidth}{l @{\extracolsep{\fill}} r @{\extracolsep{6pt}} l}
\textbf{\class} & \textbf{Nombre:} & \makebox[2in]{\hrulefill}\\
\textbf{\term} &&\\
\textbf{\examnum} &&\\
\textbf{\examdate} &&\\
\textbf{Tiempo Límite: \timelimit} & Maestro & \makebox[2in]{\hrulefill}
\end{tabular*}\\
\rule[2ex]{\textwidth}{2pt}

Este examen contiene \numpages\ páginas (incluyendo esta portada) y \numquestions\ preguntas.\\
La máxima calificación es \numpoints.

##>

  raw "#{exam.description}\n"

<##
\begin{center}
Tabla para Calificar (para uso exclusivo docente)\\
\addpoints
\gradetable[v][questions]
\end{center}

\noindent
\rule[2ex]{\textwidth}{2pt}

##>
  questions do
    raw "\n"
    exam.questions.each do |question|
      answers = question.answers.order(:created_at)

      if question.category == 'checkbox'
        raw "{\n"
        checkboxchar '$\Box$'
      elsif question.category == 'essay' && !print_answers?
        newpage
      end

      raw "\\question[#{question.points}] #{question.name}\n"
      addpoints

      case question.category
        when 'multiple_choice'
          question('choices', answers)
        when 'checkbox'
          question('checkboxes', answers)
          raw "}\n"
        when 'radio'
          question('checkboxes', answers)
        when 'small_textbox'
          box('1in', answers.first)
        when 'big_textbox'
          box('2in', answers.first)
        when 'paragraph'
          paragraph(answers.first)
        when 'essay'
          essay(answers.first)
      end
      raw "\n"
    end
  end
  raw "\n"
end
