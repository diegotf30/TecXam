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

  resources :users, only: [:show, :index]

  resources :courses, only: [:index, :create, :destroy, :update] do
    resources :exams, only: [:index, :create, :destroy, :update]

    scope module: :exams do
      resources :exams, only: [] do
        resources :questions, only: [:index, :create, :destroy, :update]
      end
    end
  end


  resources :questions do
    resources :answers
  end

  get 'tags', to: 'questions#tags'

  default_url_options :host => "example.com"
end
