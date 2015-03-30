Rails.application.routes.draw do
  root "urls#index"
  resources :urls, param: :short_url, path: "", except: [:edit, :update]
end
