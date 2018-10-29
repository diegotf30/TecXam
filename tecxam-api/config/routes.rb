Rails.application.routes.draw do
  devise_for :users

  root to: 'courses#index'

  resources :users, only: [:show, :update, :destroy]
  resources :courses

  resources :exams, only: [:index, :create, :destroy, :update] do
    resources :questions, only: [:index, :update]
  end

  resources :questions do
    resources :answers
  end

  get 'tags', to: 'questions#tags'
end
