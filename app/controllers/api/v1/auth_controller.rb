class Api::V1::AuthController < ApplicationController
	before_action :authenticate_recruiter!, only: [:logout]

	def login
		@recruiter = Recruiter.find_for_database_authentication(email: params[:email])
		if @recruiter&.valid_password?(params[:password])
			token = JsonWebToken.encode(recruiter_id: @recruiter.id)
			render json: { token: token, message: 'Log in successfully' }, status: :ok
		else
			render json: { error: 'Invalid email or password' }, status: :unauthorized
		end
	end

	def create
		@recruiter = Recruiter.new(recruiter_params)
		if @recruiter.save
			token = JsonWebToken.encode(recruiter_id: @recruiter.id)
			render json: { recruiter: @recruiter, token: token }, status: :created
		else
			render json: @recruiter.errors, status: :unprocessable_entity
		end
	end

	def logout
		render json: { message: 'Logged out successfully' }, status: :ok
	end

	private

	def authenticate_recruiter!
		header = request.headers['Authorization']
		token = header.split(' ').last if header
		decoded = JsonWebToken.decode(token)
		@current_recruiter = Recruiter.find(decoded[:recruiter_id]) if decoded
	rescue ActiveRecord::RecordNotFound, JWT::DecodeError
		render json: { errors: 'Unauthorized' }, status: :unauthorized
	end

	def recruiter_params
		params.require(:recruiter).permit(:name, :email, :password, :password_confirmation)
	end
end
