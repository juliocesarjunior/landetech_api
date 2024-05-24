class SubmissionSerializer < BaseSerializer
  attributes :id,
              :name, 
              :email,
              :mobile_phone,
              :resume,
              :job,
              :created_at,
              :updated_at
              
    def job
        {
          id: object.job.id,
          title: object.job.title
        }
    end
end