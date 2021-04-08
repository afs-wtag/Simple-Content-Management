Rails.application.routes.draw do
  root to: 'public#index'

  get 'show/:permalink', to: 'public#show', as: 'public_show'

  get 'admin', to: 'access#menu'
  get 'access/menu'

  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  resources :admin_users, except: [:show] do
    member do
      get :delete
    end
  end

  resources :pages do
    member do
      get :delete
    end
  end

  resources :sections do
    member do
      get :delete
    end
  end

  resources :subjects do
    member do
      get :delete
    end
  end

  get 'demo/index' # responds to GET request of index
  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/welldev'
  get 'demo/escape_output'
  # default route may go away in the future versions of rails
  # get ':controller(/:action(/:id))'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
