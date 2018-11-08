# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

p '*****ADDING DATA*****'

User::Create.create(email: 'a@gmail.com', password: '123456789', name: 'diego', gender: 'male')
user = User.first
p '* - USER CREATED'

courses = Course.create([
  {name: 'Base de Datos', acronym: 'TC1234', user: user},
  {name: 'AMSS', acronym: 'FC0012', user: user},
  {name: 'FIS', acronym: 'TC1222', user: user}
])
p '* - COURSES CREATED'
# Multiple choice
questions = Question.create([
  {name: 'de donde es enrique?', user: user, tags: ['bases'], points: 20, category: 'radio'},
  {name: 'Por que samuel usa expansores?', user: user, tags: ['amss'], points: 80},
  {name: 'como bajo tanto peso jaime', user: user, tags: ['nutricion'], points: 30, category: 'checkbox'},
  {name: 'xq no puedo dormir', user: user, tags: ['psicologia', '???'], points: 100}
])
# Draw, write and essay
questions |= Question.create([
  {name: 'que es un ERD?', user: user, tags: ['bases'], points: 10, category: 'paragraph'},
  {name: 'Como se llama el profesor del curso?', user: user, tags: ['bases'], points: 30, category: 'essay'},
  {name: 'haz un diagrama secuencia', user: user, tags: ['amss'], points: 10, category: 'big_textbox'},
  {name: 'haz un SRS', user: user, tags: ['amss'], points: 90, category: 'essay'},
])
p '* - QUESTIONS CREATED'

Answer.create([
  {name: 'yucatan', question: Question.first},
  {name: 'es de x', vars: { x: [1,2,3] }, question: Question.first},
  {name: 'because var var2 var3', vars: { var: [7], var2: [8], var3: [9] }, question: Question.second},
  {name: 'sepa \#SamuelEsRaro', question: Question.second},
  {name: 'porque solo comia variable-muy-muy-larga calorias', vars: { 'variable-muy-muy-larga': [1000, 250, 500] }, question: Question.third},
  {name: 'es una trampa, verdaderamente no ha bajado de peso', question: Question.third},
  {name: 'porque x tenia muchas y variables z m xd', vars: { x: [1], y: [2,3], z: [10, 15, 3], m: [0] } ,question: Question.third},
  {name: 'idk', question: Question.fourth}
])
p '* - ANSWERS CREATED'

exams = []
(0...1).each do |i|
  exams |= Exam.create([
    {name: '1er parcial', course: Course.all[i], date: '11/12/19', description: 'suerte, dummies'},
    {name: '2o parcial', course: Course.all[i], date: '26/02/22', description: 'soy una descripcion', time_limit: 30},
    {name: '3er parcial', course: Course.all[i], date: '30/08/20', description: 'lmao ya valió', time_limit: 180}]
  )
end

# Randomized exam
Exam.create(name: 'pop quiz', course: Course.last, random_questions: { amss: 2, bases: 2 })

p '* - EXAMS CREATED'

# Populate exams
exams.each do |e|
  e.add_question(questions)
end
p '* - EXAMS POPULATED WITH QUESTIONS'

p '*****DONE*****'
