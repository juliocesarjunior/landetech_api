class JobSerializer < BaseSerializer
  attributes  :id,
              :title, 
              :description, 
              :start_date, 
              :end_date,
              :status,
              :skills,
              :recruiter,
              :created_at,
              :updated_at

  def recruiter
    {
      id: object.recruiter.id,
      name: object.recruiter.name
    }
  end
end

