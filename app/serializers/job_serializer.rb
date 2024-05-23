class JobSerializer < BaseSerializer
  attributes  :id,
              :title, 
              :description, 
              :start_date, 
              :end_date,
              :status,
              :skills,
              :recruiter

  def recruiter
    {
      id: object.recruiter.id,
      name: object.recruiter.name
    }
  end
end

