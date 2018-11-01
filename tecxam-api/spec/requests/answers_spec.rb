require 'spec_helper'

describe 'Answers API' do
  it 'sends a list of answers' do
    question = create :question
    create_list(:answer, 10, question: question)

    get "/questions/#{question.id}/answers", headers: auth_headers(question.user)

    expect(response.status).to eq 200
    expect(json.length).to eq 10
  end

  it 'creates an answer' do
    question = create :question
    user = question.user

    post "/questions/#{question.id}/answers", params: answer_params, headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json).to match_json_schema(:answer)
    expect(json['name']).to eq 'Tu nombre es #x'
    expect(json['variables']).to eq ['x']
  end

  it 'updates answer details' do
    question = create :question
    answer = create :answer, question: question
    user = question.user

    patch "/questions/#{question.id}/answers/#{answer.id}", params: answer_params, headers: auth_headers(user)

    expect(response.status).to eq 200
    expect(json['name']).to eq 'Tu nombre es #x'
    expect(json['variables']).to eq ['x']
  end

  context 'answer deletion' do
    it 'deletes answers' do
      question = create :question
      answer = create :answer, question: question
      user = question.user

      delete "/questions/#{question.id}/answers/#{answer.id}", headers: auth_headers(user)

      expect(response.status).to eq 200
    end

    it 'doesnt delete an answer if another user tries to delete it' do
      question = create :question
      answer = create :answer, question: question
      hacker = create :user

      delete "/questions/#{question.id}/answers/#{answer.id}", headers: auth_headers(hacker)

      expect(response.status).to eq 401
    end
  end

  def answer_params
    {
      answer: {
        name: 'Tu nombre es #x',
      }
    }.to_json
  end
end