FactoryBot.define do
	factory :job do
		title { Faker::Job.title }
		description { Faker::Lorem.paragraph }
		start_date { Faker::Time.between(from: DateTime.now - 5.days, to: DateTime.now) }
		end_date { Faker::Time.between(from: DateTime.now, to: DateTime.now + 5.days) }
		status { 0 }
		skills { Faker::Job.key_skill }
		association :recruiter
	end
end
