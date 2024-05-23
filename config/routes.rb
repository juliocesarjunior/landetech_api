Rails.application.routes.draw do
  devise_for :recruiters

  namespace :api do
    namespace :v1 do
      resources :recruiters
      # resources :jobs, only: [:index, :show]
      resources :jobs
      resources :submissions
      post 'auth/login', to: 'auth#login'
      delete 'auth/logout', to: 'auth#logout'
      post 'auth/register', to: 'auth#create' # Nova rota para criação de recrutador

    end
  end

end
