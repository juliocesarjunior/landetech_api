require 'rails_helper'

RSpec.describe Api::V1::SubmissionsController, type: :request do
  let(:recruiter) { FactoryBot.create(:recruiter) }
  let(:headers) { authenticated_header(recruiter) }

  let(:job) { FactoryBot.create(:job) }
  let(:valid_attributes) { { submission: attributes_for(:submission, job_id: job.id) } }
  let(:invalid_attributes) { { submission: { name: "", email: "john@example.com", mobile_phone: "1234567890", resume: "lorem...", job_id: job.id } } }

  describe 'GET /api/v1/submissions' do
    it 'returns a success response' do
      get '/api/v1/submissions', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /api/v1/submissions" do
    context "with valid parameters" do
      it "creates a new submission" do
        expect {
          post api_v1_submissions_path, params: valid_attributes, headers: headers
        }.to change(Submission, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new submission" do
        expect {
          post api_v1_submissions_path, params: invalid_attributes, headers: headers
        }.to change(Submission, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end



  describe "PUT /api/v1/submissions/:id" do
    let!(:submission) { create(:submission) }

    context "with valid parameters" do
      let(:new_attributes) { attributes_for :submission }

      it "updates the requested submission" do
        put api_v1_submission_path(submission), 
        params: { submission: new_attributes }, 
        headers: headers
        submission.reload
        expect(submission.name).to eq(new_attributes[:name])
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity response" do
        put api_v1_submission_path(submission), params: invalid_attributes, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end



  describe "DELETE /api/v1/submissions/:id" do
    let(:submission) { FactoryBot.create(:submission) }

    it 'destroys the submission' do
      delete "/api/v1/submissions/#{submission.id}", headers: headers
      expect(response).to have_http_status(:success)
      expect { Submission.find(submission.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
