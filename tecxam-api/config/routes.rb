Rails.application.routes.draw do
  devise_for :users
  root to: 'exams#index'
  resources :users, only: [:show, :edit, :update]
  resources :exams, only: [:index, :create, :edit]
  resources :questions
  resources :answers
end
