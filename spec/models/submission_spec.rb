require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe 'Model.Submission' do
    let(:job) { FactoryBot.create :job }
    let(:submission1) { FactoryBot.build :submission, job: job }

    context 'validates field using fixtures' do
      it 'valid attributes' do
        expect(submission1).to be_valid
      end

      it 'name must not be valid' do
        submission1.name = nil
        expect(submission1).to_not be_valid
      end

      it 'email must not be valid' do
        submission1.email = nil
        expect(submission1).to_not be_valid
      end

      it 'mobile_phone must not be valid' do
        submission1.mobile_phone = nil
        expect(submission1).to_not be_valid
      end

it 'ensures unique submission for job and email' do
  existing_submission = FactoryBot.create :submission, job: job
  submission1.email = existing_submission.email
  expect(submission1).to_not be_valid
  expect(submission1.errors[:base]).to include("Você já se inscreveu para este Job.")
end


      it 'allows submission for different job and email' do
        existing_submission = FactoryBot.create :submission
        expect(submission1).to be_valid
      end
    end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:mobile_phone) }
  end
    describe 'associations' do
      it { should belong_to(:job) }
    end
  end
end
