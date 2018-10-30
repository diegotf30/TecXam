require 'spec_helper'

describe Auth::SessionsController do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#create' do
    context 'when user is not found' do
      it 'returns unauthorized' do
        post :create, params: session_params

        expect(response.status).to eq 401
      end
    end

    context 'when user exists' do
      it 'sends auth-token in header' do
        user = create :user, email: 'antonio@mejorado.com', password: 'foobar123' 
        request.headers.merge! json_headers

        post :create, params: session_params

        expect(response).to have_http_status(200)
        expect(json['name']).to eq(user.name)
        expect(json['email']).to eq(user.email)
      end
    end
  end

  describe '#destroy' do
    it 'returns 204, no content' do
      delete :destroy, params: session_params

      expect(response).to have_http_status(204)
    end
  end

  def session_params
    {
      user: {
        email: 'antonio@mejorado.com',
        password: 'foobar123'
      }
    }
  end
end