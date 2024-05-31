require 'rails_helper'

RSpec.describe "Api::V1::Jobs", type: :request do
  let!(:recruiter) { create(:recruiter) }
  let(:headers) { authenticated_header(recruiter) }
  let(:valid_attributes) { { job: { title: "Software Engineer", description: "Job description", start_date: "2024-06-01", end_date: "2024-12-31", status: "active", skills: ["Ruby on Rails", "React"], recruiter_id: recruiter.id } } }
  let(:invalid_attributes) { { job: { title: "", description: "Job description", start_date: "2024-06-01", end_date: "2024-12-31", status: "active", skills: ["Ruby on Rails", "React"], recruiter_id: recruiter.id } } }

  describe "GET /api/v1/jobs" do
    it "returns a success response" do
      get api_v1_jobs_path, headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/jobs/:id" do
    let!(:job) { create(:job) }

    it "returns the job" do
      get api_v1_job_path(job), headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq(job.id)
    end
  end

  describe "POST /api/v1/jobs" do
    context "with valid parameters" do
      it "creates a new job" do
        expect {
          post api_v1_jobs_path, params: valid_attributes, headers: headers
        }.to change(Job, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new job" do
        expect {
          post api_v1_jobs_path, params: invalid_attributes, headers: headers
        }.to change(Job, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /api/v1/jobs/:id" do
    let!(:job) { create(:job) }

    context "with valid parameters" do
      let(:new_attributes) { { job: { title: "Senior Software Engineer" } } }

      it "updates the requested job" do
        put api_v1_job_path(job), params: new_attributes, headers: headers
        job.reload
        expect(job.title).to eq("Senior Software Engineer")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entity response" do
        put api_v1_job_path(job), params: invalid_attributes, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  describe "DELETE /api/v1/jobs/:id" do
    let!(:job) { create(:job) }

    it "destroys the requested job and updates status to 2" do
      expect {
        delete api_v1_job_path(job), headers: headers
      }.to change { job.reload.status }.from("active").to("deleted")

      expect(response).to have_http_status(:ok)

      updated_job = Job.find_by(id: job.id)
      expect(updated_job).to_not be_nil
      expect(updated_job.status).to eq("deleted")
    end
  end

  def json
    JSON.parse(response.body)
  end
end
