# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

p '*****ADDING DATA*****'

User::Create.create(email: 'a@gmail.com', password: '123456789', name: 'diego', gender: 'male')
user = User.first
courses = Course.create([
  {name: 'Base de Datos', acronym: 'TC123456', user: user},
  {name: 'AMSS', acronym: 'FC00125', user: user},
  {name: 'FIS', acronym: 'TC1222', user: user}
])

exams = []
(0...2).each do |i|
  exams |= Exam.create([
    {name: '1er parcial', is_random: true, course: Course.all[i]},
    {name: '2o parcial', is_random: true, course: Course.all[i]},
    {name: '3er parcial', is_random: false, course: Course.all[i]}]
  )
end

questions = Question.create([
  {name: 'de donde es enrique?', user: user, tag: 'bases'},
  {name: 'Por que samuel usa expansores?', user: user, tag: 'amss'},
  {name: 'como bajo tanto peso jaime', user: user, tag: 'nutricion'},
  {name: 'xq no puedo dormir', user: user, tag: 'psicologia'}
])

Answer.create([
  {name: 'yucatan', question: Question.first},
  {name: 'es de #x', question: Question.first},
  {name: 'because #var ate #var2', question: Question.second},
  {name: 'sepa \#SamuelEsRaro', question: Question.second},
  {name: 'porque solo comia #variable-muy-muy-larga calorias', question: Question.third},
  {name: 'es una trampa, verdaderamente no ha bajado de peso', question: Question.third},
  {name: 'porque #x tenia muchas #y variables #z #m #a xd #e', question: Question.third},
  {name: 'idk', question: Question.fourth}
])

# Populate exams
exams.each do |e|
  e.questions |= questions
end

p '*****DONE*****'