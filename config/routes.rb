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


end
