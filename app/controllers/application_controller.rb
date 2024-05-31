class ApplicationController < ActionController::API
	def index
		@q = Job.where(status: 0).ransack(params[:q])
		@jobs = @q.result.page(params[:page]).order(id: :asc)

		render json: @jobs, status: :ok, each_serializer: HomeSerializer
	end

	def show
		@job = Job.find(params[:id])
		
		render json: @job, status: :ok
	rescue ActiveRecord::RecordNotFound
		render json: { error: 'Job not found' }, status: :not_found
	end

	def create_submission
		@submission = Submission.new(submission_params)
		if @submission.save
			render json: @submission, status: :created
		else
			render json: @submission.errors, status: :unprocessable_entity
		end
	end

	private

	def submission_params
		params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
	end

end
