class  Api::V1::RecruitersController < ApiController
	before_action :set_recruiter, only: [:show, :update, :destroy]

  def index
    @per_page = params[:per_page] || 10
    @page = params[:page] || 1

    @recruiters = Recruiter.page(@page).per(@per_page)

    render json: @recruiters, meta: pagination_dict(@recruiters), each_serializer: RecruiterSerializer
  end
  
  def show
    @recruiter = Recruiter.find(params[:id])

    if @recruiter
      render json: @recruiter, status: :ok
    else
      render json: { error: 'recruiter not found' }, status: :not_found
    end
  end
  
  def create
    @recruiter = Recruiter.new(recruiter_params)
    if @recruiter.save
      token = JsonWebToken.encode(recruiter_id: @recruiter.id)
      render json: { recruiter: @recruiter, token: token }, status: :created
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @recruiter.update(recruiter_params)
      render json: @recruiter
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_recruiter
    @recruiter = Recruiter.find(params[:id]) || {}
  end
  
  def recruiter_params
    params.require(:recruiter).permit(:name, :email, :password, :password_confirmation)
  end
end
