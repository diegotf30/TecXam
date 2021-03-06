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
    resources :exams, only: [:index, :create, :destroy, :update, :show] do
      post 'add/:question_id', to: 'exams#add'
      get 'export'
      get 'answer_key'
      post 'hand_out'
      post 'close'
      get 'is_open'
      get 'random_questions'
    end

    scope module: :exams do
      resources :exams, only: [] do
        resources :questions, only: [:index, :create, :destroy, :update]
        resources :attempts, only: [:index, :destroy, :update, :show]
      end
    end
  end

  resources :questions do
    resources :answers
  end

  get 'tags', to: 'questions#tags'
  
  resources :attempt, only: [:create, :destroy, :update, :show]
  post ':token', to: 'attempt#take_exam'

  default_url_options :host => "example.com"
end
