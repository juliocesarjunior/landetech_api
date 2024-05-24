class Authentication
  attr_reader :recruiter
    
    def initialize(recruiter_params, request)
        @recruiter_params = recruiter_params
        @recruiter = self.find_recruiter
    end

    def authenticate
        valid_recruiter_password?
    end

    def generate_token
        JsonWebToken.encode({ recruiter_id: @recruiter.id, email: @recruiter.email, expires_in: expiration_time })
    end

    private

    def valid_recruiter_password?
        @recruiter&.valid_password?(@recruiter_params[:password])
    end

    def find_recruiter
        Recruiter.find_by(email: @recruiter_params[:email])
    end

    def expiration_time
        (Time.now + 60.days).to_i
    end
end
