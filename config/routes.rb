Rails.application.routes.draw do
  root to: 'staticpages#top', as: 'top'
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create', as: 'signup_create'
  get 'signup/detail/:id', to: 'users#new_detail', as: 'detail'
  post 'signup_detail', to: 'users#datail_create', as: 'detail_create'
  get    'login', to: 'sessions#new', as: 'login'
  post   'login', to: 'sessions#create', as: 'login_create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'users/:id/unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
  delete 'resign', to: 'users#resign', as: 'resign'
  
  resources :users, except: [:new] do
    resources :moneys, except: [:show]
  end
  get 'users/:user_id/search', to: 'moneys#search', as: 'search'
  get '/users/:user_id/moneys/graph', to: 'moneys#graph', as: 'moneygraph'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
