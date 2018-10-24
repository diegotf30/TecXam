# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User::Create.create(email: 'a@gmail.com', password: '123456789', name: 'diego', gender: 'male')
user = User.first

exams = Exam.create([{name: 'bases', is_random: false, user: user}, {name: 'fundamentos', is_random: true, user: user}, {name: 'amss', is_random: false, user: user}])

questions = ['Cuanto pesa Enrique?', 'Por qué samuel usa expansores?', 'Como bajo tanto peso jaime', 'xq no puedo dormir']

questions.each do |q|
  Question.create(name: q, user: user)
end

# Populate exams
exams.each do |e|
  e.questions |= Question.all
end
