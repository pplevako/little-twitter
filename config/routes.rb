Rails.application.routes.draw do
  resource :statistics, only: [:show, :update]

  namespace :api do
    namespace :v1 do
      resources :messages do
        patch :like, on: :member
      end
    end
  end

  scope :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end

  root to: redirect('/statistics')
end
