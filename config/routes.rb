Rails.application.routes.draw do
  get 'welcome/index'
 
  resources :articles do
    resources :comments
  end
  resources :pdfs
  resources :fillablepdfs
  resources :dashboards
  root 'welcome#index'
end