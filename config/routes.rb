Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "auth/sessions",
    registrations: "auth/registrations"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "exams#index"
  resources :exams
  resources :questions
  resources :answers
end
