Rails.application.routes.draw do
  devise_for :users
  root to: 'exams#index'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :exams, only: [:index, :create, :destroy, :update] do
    resources :questions, only: [:index, :update]
  end
  resources :courses
  resources :questions
  resources :answers
  get 'tags', to: 'questions#tags'
end
