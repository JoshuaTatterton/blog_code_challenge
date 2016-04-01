Rails.application.routes.draw do
  
  root to: "articles#index"

  resources :articles do
    resources :comments
  end

  resources :subscribers

  namespace :blogger do 
    post "/session", to: "/session#create", as: :login
  end

end
