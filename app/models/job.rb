class Job < ApplicationRecord
  belongs_to :recruiter

  enum status: { active: 0, inactive: 1, deleted: 2 }

  validates :title, :description, :recruiter_id, presence: true

  def destroy
    self.update_attribute(:status, 2)
  end
end
