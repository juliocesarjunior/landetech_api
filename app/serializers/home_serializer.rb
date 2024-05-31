class HomeSerializer < BaseSerializer
  attributes  :id,
              :status,
              :title, 
              :description, 
              :start_date, 
              :end_date,
              :skills
end
