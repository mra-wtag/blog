Rails.application.routes.draw do
  resources :contents
  post 'contents/personal_posts'
  post 'contents/all_posts'
  root 'contents#index'
end
