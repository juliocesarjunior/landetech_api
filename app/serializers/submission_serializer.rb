class SubmissionSerializer < BaseSerializer
  attributes :id,
              :name, 
              :email,
              :mobile_phone,
              :resume,
              :job

              def job
                {
                  id: object.job.id,
                  name: object.job.name
                }
              end
end