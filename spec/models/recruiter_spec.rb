require 'rails_helper'

RSpec.describe Recruiter, type: :model do
  describe 'Model.Recruiter' do
    let(:recruiter) { FactoryBot.build :recruiter }

    context 'validates field using fixtures' do
      it 'valid attributes' do
        expect(recruiter).to be_valid
      end

      it 'name must not be valid' do
        recruiter.name = nil
        expect(recruiter).to_not be_valid
      end

      it 'email must not be valid' do
        recruiter.email = nil
        expect(recruiter).to_not be_valid
      end

      it 'password must not be valid' do
        recruiter.password = nil
        expect(recruiter).to_not be_valid
      end

      it 'password confirmation must not be valid' do
        recruiter.password_confirmation = 'invalid_password'
        expect(recruiter).to_not be_valid
      end
    end

    context 'Validates' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end
  end
end
