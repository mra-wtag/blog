Rails.application.routes.draw do
  resources :contents
  post 'contents/personal_posts'
  root 'contents#index'
end
