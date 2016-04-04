Rails.application.routes.draw do
  
  root to: "bloggers#index"
  
  resources :bloggers do
    resources :articles do
      resources :comments
    end
    resources :subscribers
  end
  
  resources :blogger_sessions
  
  
end
