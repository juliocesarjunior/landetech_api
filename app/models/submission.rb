class Submission < ApplicationRecord
  belongs_to :job

  validates :name, :email, :mobile_phone, presence: true
  validate :unique_submission_for_job

  private

  def unique_submission_for_job
    existing_submission = Submission.find_by(job_id: job_id, email: email)
    if existing_submission
      errors.add(:base, "Você já se inscreveu para este Job.")
    end
  end
end
