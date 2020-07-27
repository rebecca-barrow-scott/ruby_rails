Rails.application.routes.draw do
  get 'welcome/index'
 
  resources :articles do
    resources :comments
  end
  resources :pdfs
 
  root 'welcome#index'
end