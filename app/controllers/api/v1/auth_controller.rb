class Api::V1::AuthController < ApplicationController

  def authenticate
    auth = Authentication.new(login_params, request)
    if auth.authenticate
      render json: {
        message: 'Login efetuado com sucesso!',
        token: auth.generate_token,
      }, status: :ok
    else
      render json: {
        message: 'E-mail ou senha incorreta'
      }, status: :unauthorized
    end

  rescue StandardError => e
    render json: {
      message: 'E-mail ou senha não encontrados'
    }, status: :not_found
  end

  def register
    recruiter = Recruiter.new(register_params)
    if recruiter.save
      render json: {
        message: 'Usuário registrado com sucesso!',
        recruiter: recruiter
      }, status: :created
    else
      render json: {
        message: 'Erro ao registrar usuário',
        errors: recruiter.errors.full_messages
      }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: {
      message: 'Erro inesperado ao registrar usuário',
    }, status: :internal_server_error
  end


  private

  def login_params
    params.require(:auth).permit(:email, :password)
  end

    def register_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
