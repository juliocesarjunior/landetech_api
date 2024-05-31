require 'rails_helper'

RSpec.describe "Api::V1::Recruiters", type: :request do
  let(:recruiter) { create(:recruiter) }
  let(:headers) { authenticated_header(recruiter) }
  let!(:recruiter) { create(:recruiter) }
  let(:valid_attributes) { { name: "John Doe", email: "john@example.com", password: "password", password_confirmation: "password" } }
  let(:invalid_attributes) { { name: "", email: "john@example.com", password: "password", password_confirmation: "password" } }

  describe "GET /api/v1/recruiters" do
    it "returns a success response" do
      get api_v1_recruiters_path, headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/recruiters/:id" do
    context "when the record exists" do
      it "returns the recruiter" do
        get api_v1_recruiter_path(recruiter), headers: headers
        expect(response).to have_http_status(:ok)
        expect(json['id']).to eq(recruiter.id)
      end
    end

    context "when the record does not exist" do
      it "returns a not found message" do
        get api_v1_recruiter_path(id: 0), headers: headers
        expect(response).to have_http_status(:not_found)
        expect(json['error']).to match(/Recruiter not found/)
      end
    end
  end

  describe "POST /api/v1/recruiters" do
    context "with valid parameters" do
      it "creates a new recruiter" do
        expect {
          post api_v1_recruiters_path, params: valid_attributes, headers: headers
        }.to change(Recruiter, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new recruiter" do
        expect {
          post api_v1_recruiters_path, params: invalid_attributes, headers: headers
        }.to change(Recruiter, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /api/v1/recruiters/:id" do
    context "with valid parameters" do
      let(:new_attributes) { { name: "Jane Doe" } }

      it "updates the requested recruiter" do
        put api_v1_recruiter_path(recruiter), params: new_attributes, headers: headers
        recruiter.reload
        expect(recruiter.name).to eq("Jane Doe")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity response" do
        put api_v1_recruiter_path(recruiter), params: invalid_attributes, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /api/v1/recruiters/:id" do
    it "destroys the requested recruiter" do
      expect {
        delete api_v1_recruiter_path(recruiter), headers: headers
      }.to change(Recruiter, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  def json
    JSON.parse(response.body)
  end
end
