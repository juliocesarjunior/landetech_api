require 'rails_helper'

RSpec.describe Job, type: :model do
  context 'Creation' do
    it "creates a job with valid attributes" do
      expect { FactoryBot.create(:job) }.to change(Job, :count).by(1)
    end

    it "does not create job without title" do
      expect { FactoryBot.create(:job, title: '') }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "does not create job without description" do
      expect { FactoryBot.create(:job, description: '') }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "does not create job without recruiter" do
      expect { FactoryBot.create(:job, recruiter: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:recruiter_id) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:recruiter) }
  end
end
