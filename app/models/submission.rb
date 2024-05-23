class Submission < ApplicationRecord
  belongs_to :job

    validates :mobile_phone, presence: true, uniqueness: true
end
