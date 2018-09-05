Rails.application.routes.draw do
  # create the api endpoints in the correct scope
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :page_views, only: :index
      resources :top_referrers, only: :index
    end
  end

  root 'dashboard#index'

end
