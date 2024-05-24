Rails.application.routes.draw do
  devise_for :recruiters

  namespace :api do
    namespace :v1 do
      resources :recruiters
      resources :jobs
      resources :submissions
      post '/login', to: 'auth#authenticate'
      post '/register', to: 'auth#register'
    end
  end

  root to: redirect('/jobs')  
  get 'jobs', to: 'application#index', as: :index
  get 'jobs/:id', to: 'application#show', as: :show_job
  post 'submissions', to: 'application#create_submission', as: :create_submission

end
