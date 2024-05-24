class Authorization
	def initialize(request)
		authorization_header = request.headers['Authorization']
		@token = authorization_header.split(' ').last if authorization_header.present?
	end

	def current_recruiter
		@current_recruiter ||= fetch_current_recruiter if @token.present?
	rescue StandardError => e
		Rails.logger.error("Search recruiter Error: #{e.message}")
		nil
	end

	private

	def fetch_current_recruiter

		decodeToken = JsonWebToken.decode(@token)

		recruiter_id = decodeToken[:recruiter_id]

		recruiter = Recruiter.find_by(id: recruiter_id)
		
		recruiter = recruiter if recruiter && decodeToken[:expires_in].to_i > Time.now.to_i 
		
		recruiter
	end
end
