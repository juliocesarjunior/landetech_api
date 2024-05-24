class JsonWebToken

    JWT_SECRET = ENV['JWT_SECRET'] || Rails.application.secrets.secret_key_base

    def self.encode payload
        JWT.encode payload, JWT_SECRET
    rescue StandardError => e
        Rails.logger.error("JWT Encode Error: #{e.message}")
        nil
    end

    def self.decode token
        body = JWT.decode(token, JWT_SECRET, true, algorithm: 'HS256')[0]
        HashWithIndifferentAccess.new body
    rescue StandardError => e
        Rails.logger.error("JWT Decode Error: #{e.message}")
        nil
    end
end