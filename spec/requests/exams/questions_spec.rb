require 'spec_helper'

describe 'Exam::Questions API' do
  it 'sends a list of exam questions' do
    user = create :user
    course = create :course, user: user
    exam = create :exam, :with_questions, number_of_questions: 10, course: course

    get "/courses/#{course.id}/exams/#{exam.id}/questions", headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json.length).to eq 10
  end

  it 'creates an exam question' do
    user = create :user
    course = create :course, user: user
    exam = create :exam, course: course

    post "/courses/#{course.id}/exams/#{exam.id}/questions", params: question_params, headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json).to match_json_schema(:question)
    expect(json['name']).to eq 'Como me llamo?'
    expect(json['tags']).to eq ['Psicologia']
  end

  it 'updates an exam question details' do
    user = create :user
    course = create :course, user: user
    exam = create :exam, :with_questions, course: course
    question = exam.questions.first

    patch "/courses/#{course.id}/exams/#{exam.id}/questions/#{question.id}", params: question_params, headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json['name']).to eq 'Como me llamo?'
    expect(json['tags']).to eq ['Psicologia']
  end

  context 'exam question removal' do
    it 'removes questions' do
      user = create :user
      course = create :course, user: user
      exam = create :exam, :with_questions, number_of_questions: 1, course: course
      question = exam.questions.first

      delete "/courses/#{course.id}/exams/#{exam.id}/questions/#{question.id}", headers: auth_headers(user)

      expect(response.status).to eq 200
      expect(exam.questions.count).to eq 0
    end

    it 'doesnt remove question if another user tries to remove it' do
      user = create :user
      course = create :course, user: user
      exam = create :exam, :with_questions, course: course
      question = exam.questions.first

      hacker = create :user

      delete "/courses/#{course.id}/exams/#{exam.id}/questions/#{question.id}", headers: auth_headers(hacker)

      expect(response.status).to eq 401
    end
  end

  def question_params
    {
      question: {
        name: 'Como me llamo?',
        tags: ['Psicologia']
      }
    }.to_json
  end
end