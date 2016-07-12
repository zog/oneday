Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions", passwords: 'passwords', masquerades: 'admin/masquerades' }

  get '/result', to: 'static#s3_results', as: :s3_results

  resources :signed_urls, only: :index

  namespace :admin do
    root to: 'home#index'

    resources :users
    resources :seo_meta
  end

  resources :days do
    member do
      get :add_moments
    end
    resources :moments
  end

  get "/404", to: "errors#routing"
  post "/404", to: "errors#routing"
  put "/404", to: "errors#routing"
  patch "/404", to: "errors#routing"
  delete "/404", to: "errors#routing"
end
