Rails.application.routes.draw do
  
  root to: "bloggers#index"
  
  resources :bloggers do
    resources :articles do
      resources :comments
    end
    resources :subscribers
  end
  
  resources :blogger_sessions
  post 'sign_in' => 'blogger_sessions#create', :as => :sign_in
  post 'sign_out' => 'blogger_sessions#destroy', :as => :sign_out
  
end
