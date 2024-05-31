class  Api::V1::RecruitersController < ApiController
  before_action :authorization_request
  before_action :set_recruiter, only: [:show, :update, :destroy]


  def index
    @per_page = params[:per_page] || 10
    @page = params[:page] || 1

    @recruiters = Recruiter.page(@page).per(@per_page)

    render json: @recruiters, meta: pagination_dict(@recruiters), each_serializer: RecruiterSerializer
  end
  
  def show        
    if @recruiter
      render json: @recruiter, status: :ok
    else
      render json: { error: 'Recruiter not found' }, status: :not_found
    end
  end

  
  def create
    @recruiter = Recruiter.new(recruiter_params)
    if @recruiter.save
      render json: { recruiter: @recruiter }, status: :created
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if params[:recruiter].present?
      params[:recruiter].delete(:password) if params[:recruiter][:password].blank?
      params[:recruiter].delete(:password_confirmation) if params[:recruiter][:password_confirmation].blank?
    end
    if @recruiter.update(recruiter_params)
      render json: @recruiter
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @recruiter.destroy
      render json: { message: 'Recruiter deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete recruiter' }, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_recruiter
    @recruiter = Recruiter.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Recruiter not found' }, status: :not_found
  end
  
  def recruiter_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
