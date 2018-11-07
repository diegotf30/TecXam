require 'spec_helper'

describe 'Exams API' do
  it 'sends a list of exams' do
    course = create :course
    create_list(:exam, 10, course: course)

    get "/courses/#{course.id}/exams", headers: auth_headers(course.user)

    expect(response.status).to eq 200
    expect(json.length).to eq 10
  end

  it 'creates an exam' do
    course = create :course

    post "/courses/#{course.id}/exams", params: exam_params, headers: auth_headers(course.user)

    expect(response.status).to eq 200
    expect(json).to match_json_schema(:exam)
    expect(json['name']).to eq 'Mi examen :)'
    expect(json['random_questions'].count).to eq 1
  end

  it 'updates exam details' do
    course = create :course
    exam = create :exam, course: course

    patch "/courses/#{course.id}/exams/#{exam.id}", params: exam_params, headers: auth_headers(course.user)

    expect(response.status).to eq 200
    expect(json['name']).to eq 'Mi examen :)'
    expect(json['random_questions'].count).to eq 1
  end

  context 'exam deletion' do
    it 'deletes exams' do
      course = create :course
      exam = create :exam, course: course

      delete "/courses/#{course.id}/exams/#{exam.id}", headers: auth_headers(course.user)

      expect(response.status).to eq 200
    end

    it 'doesnt delete course if another user tries to delete it' do
      course = create :course
      exam = create :exam, course: course
      hacker = create :user

      delete "/courses/#{course.id}/exams/#{exam.id}", headers: auth_headers(hacker)

      expect(response.status).to eq 401
    end
  end

  it 'returns exam in PDF format' do
    course = create :course
    exam = create :exam, course: course

    get "/courses/#{course.id}/exams/#{exam.id}/export", headers: auth_headers(course.user)

    expect(response.status).to eq 200
    expect(response.headers['Content-Type']).to eq 'application/pdf'
  end

  it 'adds question to exam' do
    course = create :course
    exam = create :exam, course: course
    question = create :question

    post "/courses/#{course.id}/exams/#{exam.id}/add/#{question.id}", headers: auth_headers(course.user)

    expect(response.status).to eq 200
    expect(json['name']).to eq question.name
    expect(exam.questions.count).to eq 1
  end

  def exam_params
    {
      exam: {
        name: 'Mi examen :)',
        random_questions: {
          bases: 20,
        }
      }
    }.to_json
  end
end