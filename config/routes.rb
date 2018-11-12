Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/registrations'
    }
  root to: 'events#index'
  resources :events, shallow: true, only: [:show, :edit, :update, :destroy ] do
    resources :reviews, only: [:create, :edit, :update, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
  end

  get "me" => "users#me"
  get :legalpage, to: 'pages#legalpage'

end
