class  Api::V1::SubmissionsController < ApiController
	before_action :set_submission, only: [:show, :update, :destroy]
	
	def index
		@per_page = params[:per_page] || 10
		@page = params[:page] || 1
		
		@submissions = Submission.page(@page).per(@per_page)
		
		render json: @submissions, meta: pagination_dict(@submissions), each_serializer: SubmissionSerializer
	end
	
	def show
		@submission = Submission.find(params[:id])
		
		if @submission
			render json: @submission, status: :ok
		else
			render json: { error: 'submission not found' }, status: :not_found
		end
	end
	
	def create
		@submission = Submission.new(submission_params)
		if @submission.save
			render json: @submission, status: :created
		else
			render json: @submission.errors, status: :unprocessable_entity
		end
	end
	
	def update
		if @submission.update(submission_params)
			render json: @submission
		else
			render json: @submission.errors, status: :unprocessable_entity
		end
	end
	
	private
	
	def set_submission
		@submission = Submission.find(params[:id]) || {}
	end
	
	def submission_params
		params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
	end
end
