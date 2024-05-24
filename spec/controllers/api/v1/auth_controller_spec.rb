require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  describe 'POST #authenticate' do
    context 'with valid credentials' do
      let(:valid_credentials) { { auth: { email: 'user@example.com', password: 'password' } } }

      it 'returns a success response' do
        post :authenticate, params: valid_credentials
        expect(response).to have_http_status(:ok)
      end

      it 'returns the authentication token' do
        post :authenticate, params: valid_credentials
        expect(JSON.parse(response.body)).to include('token')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_credentials) { { auth: { email: 'invalid@example.com', password: 'invalid_password' } } }

      it 'returns an unauthorized response' do
        post :authenticate, params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        post :authenticate, params: invalid_credentials
        expect(JSON.parse(response.body)).to include('message' => 'E-mail ou senha incorreta')
      end
    end
  end

  describe 'POST #register' do
    context 'with valid parameters' do
      let(:valid_params) { { name: 'John Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password' } }

      it 'creates a new recruiter' do
        expect {
          post :register, params: valid_params
        }.to change(Recruiter, :count).by(1)
      end

      it 'returns a success response' do
        post :register, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { name: '', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password' } }

      it 'does not create a new recruiter' do
        expect {
          post :register, params: invalid_params
        }.not_to change(Recruiter, :count)
      end

      it 'returns an error response' do
        post :register, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post :register, params: invalid_params
        expect(JSON.parse(response.body)).to include('message' => 'Erro ao registrar usuário')
      end
    end
  end
end
