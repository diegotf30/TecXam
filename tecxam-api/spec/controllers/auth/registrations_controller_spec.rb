require 'spec_helper'

describe Auth::RegistrationsController do
  describe '#create' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context 'when user is unauthenticated' do
      it 'registers successfully' do
        post :create, params: signup_params

        expect(response.status).to eq 200
        expect(response.body).to match_json_schema('user')
      end
    end

    context 'when user already exists' do
      it 'returns error' do
        create :user, email: 'antonio@mejorado.com'
        post :create, params: signup_params

        expect(response.status).to eq 400
        expect(json['errors'].first['title']).to eq('Bad Request')
      end
    end
  end

  def signup_params
    {
      user: {
        email: 'antonio@mejorado.com',
        password: 'foobar123'
      }
    }
  end
end