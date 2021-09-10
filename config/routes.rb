Rails.application.routes.draw do
  root to: 'staticpages#top', as: 'top'
  get '/about', to: 'staticpages#about', as: 'about'
  get 'users/signup', to: 'users#new', as: 'signup'
  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, except: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
