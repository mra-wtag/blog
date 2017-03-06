Rails.application.routes.draw do
  resources :contents
  root 'contents#index'
end
