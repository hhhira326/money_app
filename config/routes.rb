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
  delete 'users/:id/resign', to: 'users#resign', as: 'resign'
  
  resources :users, except: [:new] do
    resources :moneys, except: [:show, :update, :destroy]
  end
  post 'users/moneys/update', to: 'moneys#update', as: 'moneysUpdate'
  get 'users/:user_id/search', to: 'moneys#search', as: 'search', defaults: {format: :json}
  get '/users/:user_id/moneys/graph', to: 'moneys#graph', as: 'graph'
  get '/users/:user_id/expenseBar', to: 'moneys#expenseBar', as: 'expenseBar', defaults: {format: :json}
  get '/users/:user_id/incomeBar', to: 'moneys#incomeBar', as: 'incomeBar', defaults: {format: :json}
  get '/users/:user_id/moneys/average', to: 'moneys#average', as: 'average'
  get '/users/:user_id/goal', to: 'goals#new', as: 'goal'
  post '/users/:user_id/goal', to: 'goals#create', as: 'goal_create'
  post '/users/:user_id/check', to: 'goals#check', as: 'check', defaults: {format: :json}
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
