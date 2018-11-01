require 'spec_helper'

describe 'Questions API' do
  it 'sends a list of questions' do
    user = create :user
    create_list(:question, 10, user: user)

    get "/questions", headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json.length).to eq 10
  end

  it 'creates a question' do
    user = create :user

    post "/questions", params: question_params, headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json).to match_json_schema(:question)
    expect(json['name']).to eq 'Como me llamo?'
    expect(json['tags']).to eq ['Psicologia']
  end

  it 'updates question details' do
    question = create :question

    patch "/questions/#{question.id}", params: question_params, headers: auth_headers(question.user)

    expect(response.status).to eq 200
    expect(json['name']).to eq 'Como me llamo?'
    expect(json['tags']).to eq ['Psicologia']
  end

  context 'question deletion' do
    it 'deletes questions' do
      question = create :question

      delete "/questions/#{question.id}", headers: auth_headers(question.user)

      expect(response.status).to eq 200
    end

    it 'doesnt delete question if another user tries to delete it' do
      question = create :question
      hacker = create :user

      delete "/questions/#{question.id}", headers: auth_headers(hacker)

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