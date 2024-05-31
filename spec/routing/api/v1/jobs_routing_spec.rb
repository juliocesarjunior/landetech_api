require 'rails_helper'

RSpec.describe Api::V1::JobsController, type: :routing do
  describe 'routing' do
    it { should route(:get, '/api/v1/jobs').to(action: :index, format: :json) }
    it { should route(:get, '/api/v1/jobs/1').to(action: :show, id: '1', format: :json) }
    it { should route(:post, '/api/v1/jobs').to(action: :create, format: :json) }
    it { should route(:put, '/api/v1/jobs/1').to(action: :update, id: '1', format: :json) }
    it { should route(:patch, '/api/v1/jobs/1').to(action: :update, id: '1', format: :json) }
    it { should route(:delete, '/api/v1/jobs/1').to(action: :destroy, id: '1', format: :json) }
  end
end
