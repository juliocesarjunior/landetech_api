class ApplicationController < ActionController::API
	def index
		@q = Job.where(status: 0).ransack(params[:q])
		@jobs = @q.result.page(params[:page]).order(id: :asc)

		render json: @jobs, status: :ok, each_serializer: HomeSerializer
	end

	def show
		@job = Job.find(params[:id])
		render json: @job, status: :ok, each_serializer: HomeSerializer
	rescue ActiveRecord::RecordNotFound
		render json: { error: 'Job not found' }, status: :not_found
	end

	def create_submission
		@submission = Submission.new(submission_params)
		@submission.job_id = params[:id]
		if @submission.save
			render json: { message: 'Criado com sucesso' }, status: :created
		else
			render json: @submission.errors, status: :unprocessable_entity
		end
	end

	private

	def submission_params
		params.permit(:name, :email, :mobile_phone, :resume, :job_id)
	end

end
