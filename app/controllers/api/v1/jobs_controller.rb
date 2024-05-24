class  Api::V1::JobsController < ApiController

	before_action :set_job, only: [:show, :update, :destroy]
   	before_action :authorization_request

	def index
		@per_page = params[:per_page] || 10
		@page = params[:page] || 1

		@jobs = Job.page(@page).per(@per_page)

		render json: @jobs, meta: pagination_dict(@jobs), each_serializer: JobSerializer
	end

	def show
		@job = Job.find(params[:id])

		if @job
			render json: @job, status: :ok
		else
			render json: { error: 'Job not found' }, status: :not_found
		end
	end

	def create
		@job = Job.new(job_params)
		if @job.save
			render json: @job, status: :created
		else
			render json: @job.errors, status: :unprocessable_entity
		end
	end

	def update
		if @job.update(job_params)
			render json: @job
		else
			render json: @job.errors, status: :unprocessable_entity
		end
	end

	private

	def set_job
		@job = Job.find(params[:id]) || {}
	end

	def job_params
		params.require(:job).permit(:title, :description, :start_date, :end_date, :status, :skills, :recruiter_id)
	end
end
