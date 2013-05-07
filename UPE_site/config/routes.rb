UPESite::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  match "session" => "sessions#create", :via =>:post
  root :to => "public_pages#home"
  resources :users, :except => [:index,
                                    :new, 
                                    :destroy]
  resources :sessions
  resources :questions do
    resources :answers
    resources :taggings, :only => [:create, 
                                   :destroy]
  end
  resources :tags,      :only   => [:index,
                                    :show]
match 'search' => "application#search"
match 'set_tutor' => 'users#set_tutor'
match 'set_admin' => 'users#set_admin'
match 'revoke_tutor' =>'users#revoke_tutor'
match 'question_vote_up' =>'questions#question_vote_up'
match 'question_vote_down' =>'questions#question_vote_down'
match 'answer_vote_up' =>'answers#answer_vote_up'
match 'answer_vote_down' =>'answers#answer_vote_down'
end
