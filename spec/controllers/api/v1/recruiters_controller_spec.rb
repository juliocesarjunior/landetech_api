require 'rails_helper'

RSpec.describe Api::V1::RecruitersController, type: :controller do
  before(:each) do
    recruiter = create(:recruiter)
    sign_in recruiter
  end

  #render_views

  describe "GET #index" do
    it "responds a 200 response" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      recruiter = create(:recruiter)
      get :show, params: { id: recruiter.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    let(:recruiter_params) { { recruiter: attributes_for(:recruiter) } }

    it "creates a new recruiter" do
      puts user_params
      expect do
        post :create, params: recruiter_params
      end.to change(Recruiter, :count).by(1)
    end
  end

  describe "PATCH #update" do
    let(:recruiter) { create(:recruiter) }
    let(:new_email) { "testUpdate@teste.com" }
    let(:update_params) { { recruiter: { email: new_email } } }

    it "updates the recruiter" do
      patch :update, params: update_params.merge(id: recruiter.id)
      recruiter.reload
      expect(recruiter.email).to eq(new_email)
    end
  end

  describe "DELETE #destroy" do
    let!(:recruiter) { create(:recruiter) }

    it "destroys the recruiter" do
      expect do
        delete :destroy, params: { id: recruiter.id }
      end.to change(Recruiter, :count).by(-1)
    end
  end
end
