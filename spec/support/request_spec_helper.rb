module RequestSpecHelper
  def authenticated_header(recruiter)
    token = JsonWebToken.encode(recruiter_id: recruiter.id, expires_in: 24.hours.from_now.to_i)
    { 'Authorization': "Bearer #{token}" }
  end
end
