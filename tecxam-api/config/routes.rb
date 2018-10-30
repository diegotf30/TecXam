Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'auth/sessions',
               registrations: 'auth/registrations'
             }

  root to: 'courses#index'

  resources :users, only: [:show, :update, :destroy]
  resources :courses

  resources :exams, only: [:index, :create, :destroy, :update] do
    resources :questions, only: [:index, :update]
    post 'add_question', to: 'exams#add_question'
  end

  resources :questions do
    resources :answers
  end

  get 'tags', to: 'questions#tags'
end
