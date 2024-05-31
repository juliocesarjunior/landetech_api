require 'rails_helper'

RSpec.describe Api::V1::RecruitersController, type: :controller do
  it { should use_before_action(:authorization_request) }
  it { should use_before_action(:set_recruiter) }
end

