Rails.application.routes.draw do
  # create the api endpoints in the correct scope
  scope module: :api, defaults: { format: :json } do
    namespace :v1 do
    end
  end

  root 'dashboard#index'

end
