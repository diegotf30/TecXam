require './lib/season'
require 'json'

def single_column(category, answers)
  raw "\\begin{#{category}}\n"
    answers.each do |answer|
      if answer['correct']
        CorrectChoice answer['value']
      else
        choice answer['value']
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
    raw answer&.dig('value') || "Seccion revisada por el profesor.\n"
  raw "\\end{solutionorbox}\n"
end

def paragraph(answer)
  raw "\\begin{solutionordottedlines}[2in]\n"
    raw answer&.dig('value') || "Seccion revisada por el profesor.\n"
  raw "\\end{solutionordottedlines}\n"
end

def essay(answer)
  raw "\\ifprintanswers\n"
    raw "\\begin{solutionorlines}[2in]\n"
      raw answer&.dig('value') || "Seccion revisada por el profesor.\n"
    raw "\\end{solutionorlines}\n"
  raw "\\else\n"
    fillwithlines '\fill'
    newpage
  raw "\\fi\n"
end

def read_exam_json
  file = File.read('tmp/exam.json')
  return JSON.parse(file)
end

json = read_exam_json

nonstopmode
documentclass 'lib/latex/exam'

if json['answer_key']
  printanswers
end

<##
\usepackage[utf8]{inputenc}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amssymb}
\usepackage{multicol}
\usepackage{color}

##>

newcommand '\\class', json['course_name']
newcommand '\\term', "#{Date.today.season} #{Date.today.year}"
newcommand '\\examnum', json['exam_name'].split.map(&:capitalize).join(' ')
newcommand '\\examdate', json['exam_date']
newcommand '\\timelimit', "#{json['time_limit']} Minutos"


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

  raw json['exam_description']
  raw '\n'

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
    json['questions'].each do |question|
      answers = question['answers']

      if question['category'] == 'checkbox'
        raw "{\n"
        checkboxchar '$\Box$'
      elsif question['category'] == 'essay' && !json['answer_key']
        newpage
      end

      raw "\\question[#{question['points']}] #{question['name']}\n"
      addpoints

      case question['category']
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
