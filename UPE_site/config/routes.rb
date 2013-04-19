UPESite::Application.routes.draw do
  get "public_pages/home"

  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  match "session" => "sessions#create", :via =>:post
  root :to => "public_pages#home"
  resources :users, :except => [:index,
                                    :new, 
                                    :destroy]
  resources :sessions
end
