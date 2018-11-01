require 'spec_helper'

describe 'Courses API' do
  it 'sends a list of courses' do
    user = create :user
    create_list(:course, 10, user: user)

    get '/courses', headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json.length).to eq 10
  end

  it 'creates a course' do
    user = create :user
    post '/courses', params: course_params, headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json).to match_json_schema(:course)
  end

  it 'updates course details' do
    user = create :user
    course = create :course, user: user

    patch "/courses/#{course.id}", params: course_params, headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json['name']).to eq 'Mi curso'
    expect(json['acronym']).to eq 'CU1234'
  end

  context 'course deletion' do
    it 'deletes courses' do
      user = create :user
      course = create :course, user: user

      delete "/courses/#{course.id}", headers: auth_headers(user)

      expect(response.status).to eq 200
    end

    it 'doesnt delete course if another user tries to delete it' do
      user = create :user
      course = create :course, user: user
      hacker = create :user

      delete "/courses/#{course.id}", headers: auth_headers(hacker)

      expect(response.status).to eq 401
    end
  end

  def course_params
    {
      course: {
        name: 'Mi curso',
        acronym: 'CU1234'
      }
    }.to_json
  end
end