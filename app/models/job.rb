class Job < ApplicationRecord
  belongs_to :recruiter

  enum status: { active: 0, inactive: 1, deleted: 2 }

  validates :title, :description, presence: true

end
